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

    private var _producerConnectionParameters:ConnectionParameters;
    private var _producerConnectionFactory:ConnectionFactory;
    private var _producerConnection:IConnection;

    private var _consumerConnectionParameters:ConnectionParameters;
    private var _consumerConnectionFactory:ConnectionFactory;
    private var _consumerConnection:IConnection;

    [Before]
    public function setUp():void {
        _delayTimer = new Timer(100, 1);

        // producer set up
        _producerConnectionParameters = new ConnectionParameters();
        _producerConnectionParameters.host = "localhost";

        _producerConnectionFactory = new ConnectionFactory(_producerConnectionParameters);
        _producerConnection = _producerConnectionFactory.connection;
        _producerConnection.name = "producer";

        _producerConnection.addEventListener(ChannelEvent.CHANNEL_OPENED, connection_channelOpenedHandler);

        _producerConnection.connect();

        /* consumer set up
         _consumerConnectionParameters = new ConnectionParameters();
         _consumerConnectionParameters.host = "localhost";

         _consumerConnectionFactory = new ConnectionFactory(_consumerConnectionParameters);
         _consumerConnection = _consumerConnectionFactory.connection;
         _producerConnection.name = "consumer";

         _producerConnection.addEventListener(ConnectionEvent.CONNECTION_OPENED, connection_openedHandler);

         _consumerConnection.connect();*/
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
        var asyncHandler:Function = Async.asyncHandler(this, timerCompleteHandler, 5000, null, timeoutHandler);
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
    protected function connection_channelOpenedHandler(event:ChannelEvent):void {
        var exchange:Exchange = new Exchange("develop_exchange2", Exchange.DIRECT);
        var queue:Queue = new Queue("develop_queue");

        _producerConnection.declareExchange(exchange);
        _producerConnection.declareQueue(queue);
        _producerConnection.bindQueue(exchange, queue, "routing.key");

    }

    /*
     functional methods
     */

}
}
