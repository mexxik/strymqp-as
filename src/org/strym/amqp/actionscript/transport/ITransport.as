/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 5:13 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.transport {
import flash.events.IEventDispatcher;

import org.strym.amqp.actionscript.connection.ConnectionParameters;
import org.strym.amqp.actionscript.exchange.Exchange;
import org.strym.amqp.actionscript.io.IODelegate;
import org.strym.amqp.actionscript.protocol.IProtocol;
import org.strym.amqp.actionscript.queue.Queue;

public interface ITransport extends IEventDispatcher {
    function connect(connectionParameters:ConnectionParameters):void;
    function open(host:String):void;

    function declareExchange(exchange:Exchange):void;
    function declareQueue(queue:Queue):void;

    function get connected():Boolean;
}
}
