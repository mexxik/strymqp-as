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

import org.as3commons.collections.Map;

import org.strym.amqp.actionscript.connection.ConnectionParameters;
import org.strym.amqp.actionscript.di.Injector;
import org.strym.amqp.actionscript.events.ChannelEvent;
import org.strym.amqp.actionscript.events.ConnectionEvent;
import org.strym.amqp.actionscript.io.IODelegate;
import org.strym.amqp.actionscript.io.SocketDelegate;
import org.strym.amqp.actionscript.protocol.IProtocol;
import org.strym.amqp.actionscript.protocol.Protocol;
import org.strym.amqp.actionscript.protocol.definition.IDomainReaderWriter;
import org.strym.amqp.actionscript.transport.v091.Transport091;

public class Transport extends EventDispatcher implements ITransport {
    protected var _connectionParameters:ConnectionParameters;

    protected var _delegate:IODelegate;
    protected var _readWriter:IDomainReaderWriter;

    protected var _channels:Map = new Map();

    static public function getTransport(protocol:IProtocol):ITransport {
        switch (protocol.version) {
            case Protocol.VERSION_0_9_1:
                return new Transport091();

            default:
                return new Transport();
        }
    }

    public function get readWriter():IDomainReaderWriter {
        return _readWriter;
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

    protected function addChannel(channel:IChannel):void {
        _channels.add(channel.id, channel);

        channel.addEventListener(ConnectionEvent.CONNECTION_STARTED, channel_connectionStartedHandler);
        channel.addEventListener(ConnectionEvent.CONNECTION_TUNED, channel_connectionTunedHandler);
        channel.addEventListener(ConnectionEvent.CONNECTION_OPENED, channel_connectionOpenedHandler);

        channel.addEventListener(ChannelEvent.CHANNEL_OPENED, channel_channelOpenedHandler);
    }

    protected function getChannel(id:int):IChannel {
        return null;
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

    /*
     Channel event handlers
     */
    protected function channel_connectionStartedHandler(event:ConnectionEvent):void {
        dispatchEvent(event);
    }

    protected function channel_connectionTunedHandler(event:ConnectionEvent):void {
        dispatchEvent(event);
    }

    protected function channel_connectionOpenedHandler(event:ConnectionEvent):void {
        dispatchEvent(event);
    }

    protected function channel_channelOpenedHandler(event:ChannelEvent):void {
        dispatchEvent(event);
    }

}
}
