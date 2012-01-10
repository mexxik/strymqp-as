/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 5:15 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.transport.v091 {
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.utils.ByteArray;
import flash.utils.IDataInput;

import org.as3commons.collections.Map;
import org.as3commons.collections.SortedMap;

import org.strym.amqp.actionscript.connection.ConnectionParameters;
import org.strym.amqp.actionscript.di.Injector;
import org.strym.amqp.actionscript.events.ChannelEvent;
import org.strym.amqp.actionscript.events.ConnectionEvent;
import org.strym.amqp.actionscript.events.ExchangeEvent;
import org.strym.amqp.actionscript.events.QueueEvent;
import org.strym.amqp.actionscript.exchange.Exchange;
import org.strym.amqp.actionscript.io.IODelegate;
import org.strym.amqp.actionscript.protocol.IProtocol;
import org.strym.amqp.actionscript.protocol.definition.IDomainReaderWriter;
import org.strym.amqp.actionscript.protocol.definition.IProtocolMethod;
import org.strym.amqp.actionscript.protocol.definition.IProtocolMethod;
import org.strym.amqp.actionscript.protocol.v091.definition.DomainReadWriter091;
import org.strym.amqp.actionscript.queue.Queue;
import org.strym.amqp.actionscript.transport.IChannel;
import org.strym.amqp.actionscript.transport.IFrame;
import org.strym.amqp.actionscript.transport.Transport;
import org.strym.amqp.actionscript.transport.TuneProperties;
import org.strym.amqp.actionscript.utils.DataUtils;

public class Transport091 extends Transport {

    private var _currentFrame:IFrame;

    private var _currentExchange:Exchange;
    private var _currentQueue:Queue;

    private var _tuneProperties:TuneProperties = new TuneProperties();

    public function Transport091() {

    }

    override public function get readWriter():IDomainReaderWriter {
        if (!_readWriter)
            _readWriter = Injector.getObject("domainReadWriter091");

        return _readWriter;
    }

    override public function connect(connectionParameters:ConnectionParameters):void {
        super.connect(connectionParameters);
    }

    override protected function getChannel(id:int):IChannel {
        var result:IChannel = _channels.itemFor(id);

        if (!result) {
            result = new Channel091(id, _connectionParameters.protocol);
            addChannel(result);
        }

        return result;
    }

    override public function open(host:String):void {
        var frame:MethodFrame091 = new MethodFrame091();
        frame.type = 1;
        frame.channel = 0;

        var method:IProtocolMethod = _connectionParameters.protocol.findMethod("connection", "open");
        method.setField("virtual-host", host);
        method.setField("reserved-1", "");
        method.setField("reserved-2", false);

        method.write(frame.payload);

        flushFrame(frame);
    }

    override public function declareExchange(exchange:Exchange):void {
        var channel:IChannel = getChannel(1);
        if (channel) {
            _currentExchange = exchange;

            var frame:MethodFrame091 = new MethodFrame091();
            frame.type = 1;
            frame.channel = channel.id;

            var method:IProtocolMethod = _connectionParameters.protocol.findMethod("exchange", "declare");
            method.setField("reserved-1", 0);
            method.setField("exchange", exchange.name);
            method.setField("type", exchange.type);
            method.setField("passive", exchange.passive);
            method.setField("durable", exchange.durable);
            method.setField("reserved-2", exchange.autoDelete);
            method.setField("reserved-3", exchange.internal);
            method.setField("no-wait", exchange.nowait);
            method.setField("arguments", new SortedMap());

            method.write(frame.payload);

            flushFrame(frame);
        }
    }

    override public function declareQueue(queue:Queue):void {
        var channel:IChannel = getChannel(1);
        if (channel) {
            _currentQueue = queue;

            var frame:MethodFrame091 = new MethodFrame091();
            frame.type = 1;
            frame.channel = channel.id;

            var method:IProtocolMethod = _connectionParameters.protocol.findMethod("queue", "declare");
            method.setField("reserved-1", 0);
            method.setField("queue", queue.name);
            method.setField("passive", queue.passive);
            method.setField("durable", queue.durable);
            method.setField("exclusive", queue.exclusive);
            method.setField("auto-delete", queue.autoDelete);
            method.setField("no-wait", queue.nowait);
            method.setField("arguments", new SortedMap());

            method.write(frame.payload);

            flushFrame(frame);
        }
    }

    override public function bindQueue(exchange:Exchange, queue:Queue, routingKey:String):void {
        var channel:IChannel = getChannel(1);
        if (channel) {
            _currentExchange = exchange;
            _currentQueue = queue;

            var frame:MethodFrame091 = new MethodFrame091();
            frame.type = 1;
            frame.channel = channel.id;

            var method:IProtocolMethod = _connectionParameters.protocol.findMethod("queue", "bind");
            method.setField("reserved-1", 0);
            method.setField("queue", queue.name);
            method.setField("exchange", exchange.name);
            method.setField("routing-key", routingKey);
            method.setField("no-wait", false);
            method.setField("arguments", new SortedMap());

            method.write(frame.payload);

            flushFrame(frame);
        }
    }

    override public function publish(data:IDataInput, routingKey:String):void {

    }

    override public function consume(queue:Queue):void {
        var channel:IChannel = getChannel(1);
        if (channel) {
            _currentQueue = queue;

            var frame:MethodFrame091 = new MethodFrame091();
            frame.type = 1;
            frame.channel = channel.id;

            var method:IProtocolMethod = _connectionParameters.protocol.findMethod("basic", "consume");
            method.setField("reserved-1", 0);
            method.setField("queue", queue.name);
            method.setField("consumer-tag", "");
            method.setField("no-local", false);
            method.setField("no-ack", false);
            method.setField("exclusive", false);
            method.setField("no-wait", false);
            method.setField("arguments", new SortedMap());

            method.write(frame.payload);

            flushFrame(frame);
        }
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
    override protected function delegate_connectHandler(event:Event):void {
        var controlChannel:IChannel = new Channel091(0, _connectionParameters.protocol);
        addChannel(controlChannel);

        super.delegate_connectHandler(event);
    }

    override protected function delegate_dataHandler(event:ProgressEvent):void {
        if (_delegate.bytesAvailable > 0) {
            if (!_currentFrame)
                _currentFrame = new MethodFrame091();

            if (!_currentFrame.isComplete) {
                _currentFrame.read(_delegate);
            }
        }

        if (_currentFrame.isComplete) {
            var channel:IChannel = getChannel(_currentFrame.channel);
            channel.handleFrame(_currentFrame);

            _currentFrame = null;
        }
    }

    private function flushFrame(frame:IFrame):void {
        var byteArray:ByteArray = new ByteArray();
        frame.write(byteArray);

        _delegate.writeBytes(byteArray);
        _delegate.flush();
    }

    /*
     overridden handlers
     */
    override protected function channel_connectionStartedHandler(event:ConnectionEvent):void {
        var frame:MethodFrame091 = new MethodFrame091();
        frame.type = 1;
        frame.channel = 0;

        var method:IProtocolMethod = _connectionParameters.protocol.findMethod("connection", "start-ok");

        var clientProperties:SortedMap = new SortedMap();
        clientProperties.add("product", "StrymQP");
        clientProperties.add("information", "http://www.strym.org");
        clientProperties.add("platform", "Flash");
        clientProperties.add("copyright", "Copyright (C) 2012 Strym");
        clientProperties.add("version", "0.1.0");

        method.setField("client-properties", clientProperties);
        method.setField("mechanism", "PLAIN");

        var responseByteArray:ByteArray = new ByteArray();
        responseByteArray.writeByte(0);
        responseByteArray.writeUTFBytes("guest");
        responseByteArray.writeByte(0);
        responseByteArray.writeUTFBytes("guest");
        /*var credentials:SortedMap = new SortedMap();
         credentials.add("LOGIN", "guest");
         credentials.add("PASSWORD", "guest");*/

        method.setField("response", responseByteArray);
        method.setField("locale", "en_US");

        method.write(frame.payload);

        flushFrame(frame);


        super.channel_connectionStartedHandler(event);
    }

    override protected function channel_connectionTunedHandler(event:ConnectionEvent):void {
        _tuneProperties = event.data;

        var frame:MethodFrame091 = new MethodFrame091();
        frame.type = 1;
        frame.channel = 0;

        var method:IProtocolMethod = _connectionParameters.protocol.findMethod("connection", "tune-ok");

        method.setField("channel-max", _tuneProperties.channelMax);
        method.setField("frame-max", _tuneProperties.frameMax);
        method.setField("heartbeat", _tuneProperties.heartbeat);

        method.write(frame.payload);

        flushFrame(frame);

        super.channel_connectionTunedHandler(event);
    }

    override protected function channel_connectionOpenedHandler(event:ConnectionEvent):void {
        var frame:MethodFrame091 = new MethodFrame091();
        frame.type = 1;
        frame.channel = 1;

        var method:IProtocolMethod = _connectionParameters.protocol.findMethod("channel", "open");
        method.setField("reserved-1", 0);

        method.write(frame.payload);

        flushFrame(frame);

        super.channel_connectionOpenedHandler(event);
    }

    override protected function channel_channelOpenedHandler(event:ChannelEvent):void {
        super.channel_channelOpenedHandler(event);
    }


    override protected function channel_exchangeDeclaredHandler(event:ExchangeEvent):void {
        event.exchange = _currentExchange;

        super.channel_exchangeDeclaredHandler(event);
    }

    override protected function channel_queueDeclaredHandler(event:QueueEvent):void {
        event.queue = _currentQueue;

        super.channel_queueDeclaredHandler(event);
    }


    override protected function channel_queueBoundHandler(event:QueueEvent):void {
        event.exchange = _currentExchange;
        event.queue = _currentQueue;

        super.channel_queueBoundHandler(event);
    }
}
}
