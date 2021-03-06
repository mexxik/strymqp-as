/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 5:15 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.transport {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.utils.IDataInput;

import org.as3commons.collections.Map;

import org.strym.amqp.core.connection.ConnectionParameters;
import org.strym.amqp.core.di.Injector;
import org.strym.amqp.core.events.BasicEvent;
import org.strym.amqp.core.events.ChannelEvent;
import org.strym.amqp.core.events.ConnectionEvent;
import org.strym.amqp.core.events.ErrorEvent;
import org.strym.amqp.core.events.ExchangeEvent;
import org.strym.amqp.core.events.QueueEvent;
import org.strym.amqp.core.domain.Exchange;
import org.strym.amqp.core.io.IODelegate;
import org.strym.amqp.core.io.SocketDelegate;
import org.strym.amqp.core.protocol.IProtocol;
import org.strym.amqp.core.protocol.Protocol;
import org.strym.amqp.core.protocol.definition.IDomainReaderWriter;
import org.strym.amqp.core.domain.Queue;
import org.strym.amqp.core.transport.v091.Transport091;

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
        _delegate.addEventListener(SecurityErrorEvent.SECURITY_ERROR, delegate_securityErrorHandler);
        _delegate.addEventListener(IOErrorEvent.IO_ERROR, delegate_errorHandler);
        _delegate.addEventListener(ProgressEvent.SOCKET_DATA, delegate_dataHandler);

        _delegate.open(_connectionParameters);
    }

    public function open(host:String):void {
    }

    public function close():void {
        _delegate.close();
    }

    public function declareExchange(exchange:Exchange):void {
    }

    public function declareQueue(queue:Queue):void {
    }

    public function bindQueue(exchange:Exchange, queue:Queue, routingKey:String):void {
    }

    public function publish(data:IDataInput, exchange:Exchange, routingKey:String):void {
    }

    public function consume(queue:Queue):void {
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

        channel.addEventListener(ExchangeEvent.EXCHANGE_DECLARED, channel_exchangeDeclaredHandler);

        channel.addEventListener(QueueEvent.QUEUE_CREATED, channel_queueDeclaredHandler);
        channel.addEventListener(QueueEvent.QUEUE_BOUND, channel_queueBoundHandler);

        channel.addEventListener(BasicEvent.DELIVERY_COMPLETE, channel_deliveryCompleteHandler);
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
        dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECTION_CLOSED));
    }

    protected function delegate_securityErrorHandler(event:SecurityErrorEvent):void {
        var errorEvent:ErrorEvent = new ErrorEvent(ErrorEvent.ERROR);
        errorEvent.errorMessage = "Security Error";
        errorEvent.errorDescription = event.text;

        dispatchEvent(errorEvent);
    }

    protected function delegate_errorHandler(event:IOErrorEvent):void {
        var errorEvent:ErrorEvent = new ErrorEvent(ErrorEvent.ERROR);
        errorEvent.errorMessage = "IO Error";
        errorEvent.errorDescription = event.text;

        dispatchEvent(errorEvent);
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

    protected function channel_exchangeDeclaredHandler(event:ExchangeEvent):void {
        dispatchEvent(event);
    }

    protected function channel_queueDeclaredHandler(event:QueueEvent):void {
        dispatchEvent(event);
    }

    protected function channel_queueBoundHandler(event:QueueEvent):void {
        dispatchEvent(event);
    }

    protected function channel_deliveryCompleteHandler(event:BasicEvent):void {
        dispatchEvent(event);
    }

}
}
