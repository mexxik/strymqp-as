/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/9/12
 * Time: 8:24 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.events {
import flash.events.Event;

import org.strym.amqp.core.domain.Exchange;

import org.strym.amqp.core.domain.Queue;

public class QueueEvent extends Event {
    static public const QUEUE_CREATED:String = "queueCreated";
    static public const QUEUE_BOUND:String = "queueBound";

    private var _queue:Queue;
    private var _exchange:Exchange;

    public function QueueEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable);
    }

    override public function clone():Event {
        var result:QueueEvent = new QueueEvent(type, bubbles, cancelable);
        result.queue = _queue;
        result.exchange = _exchange;

        return result;
    }

    public function get queue():Queue {
        return _queue;
    }

    public function set queue(value:Queue):void {
        _queue = value;
    }

    public function get exchange():Exchange {
        return _exchange;
    }

    public function set exchange(value:Exchange):void {
        _exchange = value;
    }
}
}
