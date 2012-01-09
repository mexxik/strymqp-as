/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/9/12
 * Time: 8:24 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.events {
import flash.events.Event;

import org.strym.amqp.actionscript.queue.Queue;

public class QueueEvent extends Event {
    static public const QUEUE_CREATED:String = "queueCreated";

    private var _queue:Queue;

    public function QueueEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
        super(type, bubbles, cancelable);
    }

    override public function clone():Event {
        var result:QueueEvent = new QueueEvent(type, bubbles, cancelable);
        result.queue = _queue;

        return result;
    }

    public function get queue():Queue {
        return _queue;
    }

    public function set queue(value:Queue):void {
        _queue = value;
    }
}
}
