/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 1:50 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript {
import flash.events.TimerEvent;
import flash.utils.Timer;

import org.flexunit.asserts.assertTrue;

import org.flexunit.async.Async;
import org.strym.amqp.actionscript.connection.ConnectionFactory;
import org.strym.amqp.actionscript.connection.ConnectionParameters;
import org.strym.amqp.actionscript.connection.IConnection;
import org.strym.amqp.actionscript.events.ChannelEvent;
import org.strym.amqp.actionscript.events.ConnectionEvent;
import org.strym.amqp.actionscript.exchange.Exchange;
import org.strym.amqp.actionscript.queue.Queue;

public class BasicTest {
    private var _delayTimer:Timer;

    private var _exchange:Exchange = new Exchange("develop.exchange2", Exchange.DIRECT);
    private var _queue:Queue = new Queue("develop.queue");

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
        _producerConnection.name = "consumer";

        _producerConnection.addEventListener(ChannelEvent.CHANNEL_OPENED, onConsumerOpened);

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

        _producerConnection.convertAndSend("Hello, World!", _exchange, "routing.key");

    }

    protected function onConsumerOpened(event:ChannelEvent):void {
        _consumerConnection.consume(_queue);
    }

    /*
     functional methods
     */

}
}
