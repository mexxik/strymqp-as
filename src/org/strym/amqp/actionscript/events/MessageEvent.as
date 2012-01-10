/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/10/12
 * Time: 8:18 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.events {
import flash.events.Event;

import org.strym.amqp.actionscript.domain.Message;

public class MessageEvent extends Event {
    static public const MESSAGE_RECEIVED:String = "messageReceived";

    private var _message:Message;

    public function MessageEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
        super(type, bubbles, cancelable);
    }

    override public function clone():Event {
        var result:MessageEvent = new MessageEvent(type, bubbles, cancelable);
        result.message = _message;

        return result;
    }

    public function get message():Message {
        return _message;
    }

    public function set message(value:Message):void {
        _message = value;
    }
}
}
