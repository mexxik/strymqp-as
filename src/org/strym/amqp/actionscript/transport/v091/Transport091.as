/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 5:15 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.transport.v091 {
import flash.events.ProgressEvent;
import flash.utils.ByteArray;

import org.as3commons.collections.Map;
import org.as3commons.collections.SortedMap;

import org.strym.amqp.actionscript.connection.ConnectionParameters;
import org.strym.amqp.actionscript.events.ConnectionEvent;
import org.strym.amqp.actionscript.io.IODelegate;
import org.strym.amqp.actionscript.protocol.IProtocol;
import org.strym.amqp.actionscript.protocol.definition.IProtocolMethod;
import org.strym.amqp.actionscript.transport.IFrame;
import org.strym.amqp.actionscript.transport.Transport;
import org.strym.amqp.actionscript.utils.DataUtils;

public class Transport091 extends Transport {

    private var _currentFrame:IFrame;

    private var _tuneProperties:TuneProperties = new TuneProperties();

    private var _channels:Map = new Map();

    override public function connect(connectionParameters:ConnectionParameters):void {
        super.connect(connectionParameters);
    }

    override public function open(host:String):void {

    }

    override protected function sendHeader():void {
        _delegate.writeUTFBytes("AMQP");
        _delegate.writeByte(_connectionParameters.protocol.id);
        _delegate.writeByte(_connectionParameters.protocol.major);
        _delegate.writeByte(_connectionParameters.protocol.minor);
        _delegate.writeByte(_connectionParameters.protocol.revision);

        _delegate.flush();
    }

    /**
     * IO overrides
     */
    override protected function delegate_dataHandler(event:ProgressEvent):void {
        if (_delegate.bytesAvailable > 0) {
            if (!_currentFrame)
                _currentFrame = new Frame091();

            if (!_currentFrame.isComplete) {
                if (!_currentFrame.isHeaderComplete) {

                    // not enough data
                    if (_delegate.bytesAvailable < 8)
                        return;

                    _currentFrame.type = _delegate.readUnsignedByte();

                    if (_currentFrame.type == ('A' as uint)) {
                        // possibly wrong protocol
                        // TODO implement proper handling
                    }

                    _currentFrame.channel = _delegate.readUnsignedShort();
                    _currentFrame.payloadSize = _delegate.readInt();

                    _currentFrame.isHeaderComplete = true;
                }

                if (_currentFrame.payloadSize > 0 &&
                        _currentFrame.payload.length < _currentFrame.payloadSize) {

                    _delegate.readBytes(
                            _currentFrame.payload,
                            _currentFrame.payload.length,
                            Math.min(_delegate.bytesAvailable, _currentFrame.payloadSize - _currentFrame.payload.length)
                    );

                    if (_currentFrame.payload.length < _currentFrame.payloadSize)
                        return;
                }

                if (_delegate.bytesAvailable > 0)
                    var frameEnd:int = _delegate.readUnsignedByte();

                // TODO handler end frame marker handling (code: 206)

                _currentFrame.isComplete = true;
            }
        }

        if (_currentFrame.isComplete) {
            switch (_currentFrame.type) {
                // TODO retrieve these constants from the protocol definition
                case 1:
                    var classId:int = _currentFrame.payload.readShort();
                    var methodId:int = _currentFrame.payload.readShort();
                    var protocolMethod:IProtocolMethod = _connectionParameters.protocol.getMethod(classId, methodId);

                    protocolMethod.read(_currentFrame.payload);

                    processMethod(protocolMethod);

                    break;
            }


            _currentFrame = null;
        }
    }

    private function processMethod(method:IProtocolMethod):void {
        var connectionEvent:ConnectionEvent;

        switch (method.qualifiedName) {
            case "connection.start":
                // received Connection.Start
                connectionEvent = new ConnectionEvent(ConnectionEvent.CONNECTION_STARTED);
                connectionEvent.arguments = method.fields;

                dispatchEvent(connectionEvent);

                // sending back Connection.Start-Ok
                var startOkFrame:Frame091 = new Frame091();
                startOkFrame.type = 1;
                startOkFrame.channel = 0;

                var startOkMethod:IProtocolMethod = _connectionParameters.protocol.findMethod("start-ok");

                var clientProperties:SortedMap = new SortedMap();
                clientProperties.add("product", "StrymQP");
                clientProperties.add("information", "http://www.strym.org");
                clientProperties.add("platform", "Flash");
                clientProperties.add("copyright", "Copyright (C) 2012 Strym");
                clientProperties.add("version", "0.1.0");

                startOkMethod.setField("client-properties", clientProperties);
                startOkMethod.setField("mechanism", "PLAIN");

                var responseByteArray:ByteArray = new ByteArray();
                responseByteArray.writeByte(0);
                responseByteArray.writeUTFBytes("guest");
                responseByteArray.writeByte(0);
                responseByteArray.writeUTFBytes("guest");

                startOkMethod.setField("response", responseByteArray);
                startOkMethod.setField("locale", "en_US");


                writeMethodAndFlush(startOkFrame, startOkMethod);

                break;

            case "connection.tune":
                _tuneProperties.channelMax = method.getField("channel-max") as int;
                _tuneProperties.frameMax = method.getField("frame-max") as uint;
                _tuneProperties.heartbeat = method.getField("heartbeat") as int;

                connectionEvent = new ConnectionEvent(ConnectionEvent.CONNECTION_TUNED);

                dispatchEvent(connectionEvent);

                // sending back Connection.Tune-Ok
                var tuneOkFrame:Frame091 = new Frame091();
                tuneOkFrame.type = 1;
                tuneOkFrame.channel = 0;

                var tuneOkMethod:IProtocolMethod = _connectionParameters.protocol.findMethod("tune-ok");

                tuneOkMethod.setField("channel-max", _tuneProperties.channelMax);
                tuneOkMethod.setField("frame-max", _tuneProperties.frameMax);
                tuneOkMethod.setField("heartbeat", _tuneProperties.heartbeat);

                writeMethodAndFlush(tuneOkFrame, tuneOkMethod);

                break;
        }
    }

    private function writeMethodAndFlush(frame:IFrame, method:IProtocolMethod):void {
        method.write(frame.payload);

        var byteArray:ByteArray = new ByteArray();
        frame.write(byteArray);

        _delegate.writeBytes(byteArray);
        _delegate.flush();
    }
}
}
