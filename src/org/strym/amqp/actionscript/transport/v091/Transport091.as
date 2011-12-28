/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 5:15 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.transport.v091 {
import flash.events.ProgressEvent;

import org.as3commons.collections.Map;

import org.strym.amqp.actionscript.connection.ConnectionParameters;
import org.strym.amqp.actionscript.io.IODelegate;
import org.strym.amqp.actionscript.protocol.IProtocol;
import org.strym.amqp.actionscript.protocol.definition.IProtocolMethod;
import org.strym.amqp.actionscript.transport.Transport;

public class Transport091 extends Transport {

    private var _currentFrame:Frame091;

    private var _channels:Map = new Map();

    override public function open(connectionParameters:ConnectionParameters):void {
        super.open(connectionParameters);
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
        switch (method.qualifiedName) {
            case "connection.start":
                var versionMajor:int = method.getField("version-major");
                var versionMinor:int = method.getField("version-minor");


                break;
        }
    }
}
}
