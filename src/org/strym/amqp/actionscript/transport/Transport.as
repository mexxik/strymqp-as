/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 5:15 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.transport {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;

import org.strym.amqp.actionscript.connection.ConnectionParameters;
import org.strym.amqp.actionscript.io.IODelegate;
import org.strym.amqp.actionscript.io.SocketDelegate;
import org.strym.amqp.actionscript.protocol.IProtocol;
import org.strym.amqp.actionscript.protocol.Protocol;
import org.strym.amqp.actionscript.transport.v091.Transport091;

public class Transport extends EventDispatcher implements ITransport {
    protected var _connectionParameters:ConnectionParameters;

    protected var _delegate:IODelegate;

    static public function getTransport(protocol:IProtocol):ITransport {
        switch (protocol.version) {
            case Protocol.VERSION_0_9_1:
                return new Transport091();

            default:
                return new Transport();
        }
    }

    public function connect(connectionParameters:ConnectionParameters):void {
        _connectionParameters = connectionParameters;

        _delegate = new SocketDelegate();

        _delegate.addEventListener(Event.CONNECT, delegate_connectHandler);
        _delegate.addEventListener(Event.CLOSE, delegate_closeHandler);
        _delegate.addEventListener(IOErrorEvent.IO_ERROR, delegate_errorHandler);
        _delegate.addEventListener(ProgressEvent.SOCKET_DATA, delegate_dataHandler);

        _delegate.open(_connectionParameters);
    }

    public function open(host:String):void {
    }

    public function get connected():Boolean {
        return _delegate.connected;
    }

    protected function sendHeader():void {
    }

    /*
     IO delegate event handlers
     */
    protected function delegate_connectHandler(event:Event):void {
        sendHeader();
    }

    protected function delegate_closeHandler(event:Event):void {

    }

    protected function delegate_errorHandler(event:IOErrorEvent):void {

    }

    protected function delegate_dataHandler(event:ProgressEvent):void {
    }
}
}
