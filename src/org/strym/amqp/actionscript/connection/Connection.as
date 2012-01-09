/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 2:32 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.connection {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;

import org.strym.amqp.actionscript.events.ChannelEvent;

import org.strym.amqp.actionscript.events.ConnectionEvent;
import org.strym.amqp.actionscript.events.ExchangeEvent;
import org.strym.amqp.actionscript.events.QueueEvent;
import org.strym.amqp.actionscript.exchange.Exchange;

import org.strym.amqp.actionscript.io.IODelegate;
import org.strym.amqp.actionscript.io.SocketDelegate;
import org.strym.amqp.actionscript.queue.Queue;
import org.strym.amqp.actionscript.transport.ITransport;
import org.strym.amqp.actionscript.transport.Transport;

public class Connection extends EventDispatcher implements IConnection {
    protected var _name:String;
    
    protected var _connectionParameters:ConnectionParameters;

    protected var _transport:ITransport;

    protected var _started:Boolean = false;
    protected var _tuned:Boolean = false;
    protected var _opened:Boolean = false;

    public function Connection(connectionParameters:ConnectionParameters) {
        _connectionParameters = connectionParameters;
    }

    public function get name():String {
        return _name;
    }

    public function set name(value:String):void {
        _name = value;
    }

    public function get connectionParameters():ConnectionParameters {
        return _connectionParameters;
    }

    public function set connectionParameters(value:ConnectionParameters):void {
        _connectionParameters = connectionParameters;
    }

    public function connect():void {
        if (_connectionParameters && !connected) {
            _transport = Transport.getTransport(_connectionParameters.protocol);

            _transport.addEventListener(ConnectionEvent.CONNECTION_STARTED, transport_connectionStartedHandler);
            _transport.addEventListener(ConnectionEvent.CONNECTION_TUNED, transport_connectionTunedHandler);
            _transport.addEventListener(ConnectionEvent.CONNECTION_OPENED, transport_connectionOpenedHandler);

            _transport.addEventListener(ChannelEvent.CHANNEL_OPENED, transport_channelOpenedHandler);

            _transport.addEventListener(ExchangeEvent.EXCHANGE_DECLARED, transport_exchangeDeclaredHandler);

            _transport.addEventListener(QueueEvent.QUEUE_CREATED, transport_queueDeclaredHandler);
            _transport.addEventListener(QueueEvent.QUEUE_BOUND, transport_queueBoundHandler);

            _transport.connect(_connectionParameters);
        }
        else {
            throw Error("connection parameters are not specified");
        }
    }

    public function declareExchange(exchange:Exchange):void {
        _transport.declareExchange(exchange);
    }

    public function declareQueue(queue:Queue):void {
        _transport.declareQueue(queue);
    }

    public function bindQueue(exchange:Exchange, queue:Queue, routingKey:String):void {
        _transport.bindQueue(exchange, queue, routingKey);
    }

    public function get connected():Boolean {
        return _transport ? _transport.connected : false;
    }

    public function get started():Boolean {
        return _started;
    }

    public function get tuned():Boolean {
        return _tuned;
    }

    /**
     * transport event handlers
     */
    protected function transport_connectionStartedHandler(event:ConnectionEvent):void {
        _started = true;
    }

    protected function transport_connectionTunedHandler(event:ConnectionEvent):void {
        _tuned = true;

        _transport.open("/");
    }

    protected function transport_connectionOpenedHandler(event:ConnectionEvent):void {
        _opened = true;

        event.connection = this;

        dispatchEvent(event);
    }

    protected function transport_channelOpenedHandler(event:ChannelEvent):void {
        event.connection = this;

        dispatchEvent(event);
    }

    protected function transport_exchangeDeclaredHandler(event:ExchangeEvent):void {
        dispatchEvent(event);
    }

    protected function transport_queueDeclaredHandler(event:QueueEvent):void {
        dispatchEvent(event);
    }

    protected function transport_queueBoundHandler(event:QueueEvent):void {
        dispatchEvent(event);
    }
}
}
