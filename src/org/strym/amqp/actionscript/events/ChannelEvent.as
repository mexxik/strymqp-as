/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/8/12
 * Time: 9:16 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.events {
import flash.events.Event;

import org.strym.amqp.actionscript.transport.IChannel;

public class ChannelEvent extends Event {
    static public const CHANNEL_OPENED:String = "channelOpened";

    private var _channel:IChannel;

    public function ChannelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
        super(type, bubbles, cancelable);
    }

    override public function clone():Event {
        var result:ChannelEvent = new ChannelEvent(type, bubbles, cancelable);
        result.channel = _channel;

        return result;
    }

    public function get channel():IChannel {
        return _channel;
    }

    public function set channel(value:IChannel):void {
        _channel = value;
    }
}
}
