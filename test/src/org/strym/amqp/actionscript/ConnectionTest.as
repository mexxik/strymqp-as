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

public class ConnectionTest {
    private var _delayTimer:Timer;

    private var _connectionParameters:ConnectionParameters;
    private var _connectionFactory:ConnectionFactory;
    private var _connection:IConnection;

    [Before]
    public function setUp():void {
        _delayTimer = new Timer(100, 1);

        _connectionParameters = new ConnectionParameters();
        _connectionParameters.host = "localhost";

        _connectionFactory = new ConnectionFactory(_connectionParameters);
        _connection = _connectionFactory.connection;

        _connection.connect();
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

    /**
     * tests
     */
    //[Test(async)]
    public function testConnectionStarted():void {
        assertTrue(_connection.started, "connected was not started");
    }
}
}
