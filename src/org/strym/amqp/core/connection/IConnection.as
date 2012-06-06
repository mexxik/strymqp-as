/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 2:30 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.connection {
import flash.events.IEventDispatcher;

import org.strym.amqp.core.converters.IMessageConverter;

import org.strym.amqp.core.domain.Exchange;
import org.strym.amqp.core.domain.Queue;

public interface IConnection extends IEventDispatcher {
    function get name():String;

    function set name(value:String):void;

    function get connectionParameters():ConnectionParameters;

    function set connectionParameters(value:ConnectionParameters):void;

    function connect():void;

    function close():void;

    function declareExchange(exchange:Exchange):void;

    function declareQueue(queue:Queue):void;

    function bindQueue(exchange:Exchange, queue:Queue, routingKey:String):void;

    function convertAndSend(object:*, exchange:Exchange, routingKey:String):void;

    function consume(queue:Queue):void;

    function get connected():Boolean;

    function get started():Boolean;

    function get tuned():Boolean;

    function get messageConverter():IMessageConverter;

    function set messageConverter(value:IMessageConverter):void;
}
}
