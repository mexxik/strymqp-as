/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 1:50 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core {
import flash.events.TimerEvent;
import flash.utils.Timer;

import org.flexunit.asserts.assertEquals;

import org.flexunit.asserts.assertTrue;

import org.flexunit.async.Async;
import org.strym.amqp.core.connection.ConnectionFactory;
import org.strym.amqp.core.connection.ConnectionParameters;
import org.strym.amqp.core.connection.IConnection;
import org.strym.amqp.core.events.ChannelEvent;
import org.strym.amqp.core.events.ConnectionEvent;
import org.strym.amqp.core.domain.Exchange;
import org.strym.amqp.core.domain.Queue;
import org.strym.amqp.core.events.MessageEvent;

public class BasicTest {
    private var _delayTimer:Timer;

    private var _exchange:Exchange = new Exchange("develop.exchange2", Exchange.DIRECT);
    private var _queue:Queue = new Queue("develop.queue");
    private var _testMessage:String = "Hello, World!";

    private var _producerConnectionParameters:ConnectionParameters;
    private var _producerConnectionFactory:ConnectionFactory;
    private var _producerConnection:IConnection;

    private var _consumerConnectionParameters:ConnectionParameters;
    private var _consumerConnectionFactory:ConnectionFactory;
    private var _consumerConnection:IConnection;

    public function BasicTest() {
        _delayTimer = new Timer(100, 1);

    }

    [Before]
    public function setUp():void {
        // producer set up
        _producerConnectionParameters = new ConnectionParameters();
        _producerConnectionParameters.host = "localhost";

        _producerConnectionFactory = new ConnectionFactory(_producerConnectionParameters);
        _producerConnection = _producerConnectionFactory.connection;
        _producerConnection.name = "producer";

        _producerConnection.addEventListener(ChannelEvent.CHANNEL_OPENED, onProducerOpened);

        _producerConnection.connect();

        //consumer set up
        _consumerConnectionParameters = new ConnectionParameters();
        _consumerConnectionParameters.host = "localhost";

        _consumerConnectionFactory = new ConnectionFactory(_consumerConnectionParameters);
        _consumerConnection = _consumerConnectionFactory.connection;
        _consumerConnection.name = "consumer";

        _consumerConnection.addEventListener(ChannelEvent.CHANNEL_OPENED, onConsumerOpened);
        _consumerConnection.addEventListener(MessageEvent.MESSAGE_RECEIVED, onMessageReceived);

        _consumerConnection.connect();
    }

    [After]
    public function tearDown():void {
        _delayTimer.stop();
        _delayTimer = null;
    }

    /**
     * Async setup
     */
    [Test(async)]
    public function testAsync():void {
        var asyncHandler:Function = Async.asyncHandler(this, timerCompleteHandler, 10000, null, timeoutHandler);
        _delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, asyncHandler, false, 0, true);

        _delayTimer.start();
    }

    protected function timerCompleteHandler(event:TimerEvent, data:Object):void {

    }

    protected function timeoutHandler(data:Object):void {
    }

    /*
     handlers
     */
    protected function onProducerOpened(event:ChannelEvent):void {
        _producerConnection.declareExchange(_exchange);
        _producerConnection.declareQueue(_queue);
        _producerConnection.bindQueue(_exchange, _queue, "routing.key");

        _producerConnection.convertAndSend(_testMessage, _exchange, "routing.key");

    }

    protected function onConsumerOpened(event:ChannelEvent):void {
        _consumerConnection.consume(_queue);
    }

    protected function onMessageReceived(event:MessageEvent):void {
        assertEquals(_testMessage, event.message.body);
    }
}
}
