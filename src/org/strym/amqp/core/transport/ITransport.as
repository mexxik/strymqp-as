/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 5:13 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.transport {
import flash.events.IEventDispatcher;
import flash.utils.IDataInput;

import org.strym.amqp.core.connection.ConnectionParameters;
import org.strym.amqp.core.domain.Exchange;
import org.strym.amqp.core.io.IODelegate;
import org.strym.amqp.core.protocol.IProtocol;
import org.strym.amqp.core.domain.Queue;

public interface ITransport extends IEventDispatcher {
    function connect(connectionParameters:ConnectionParameters):void;

    function open(host:String):void;

    function close():void;

    function declareExchange(exchange:Exchange):void;

    function declareQueue(queue:Queue):void;

    function bindQueue(exchange:Exchange, queue:Queue, routingKey:String):void;

    function publish(data:IDataInput, exchange:Exchange, routingKey:String):void;

    function consume(queue:Queue):void;

    function get connected():Boolean;
}
}
