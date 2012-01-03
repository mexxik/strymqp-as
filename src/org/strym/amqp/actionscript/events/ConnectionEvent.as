/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/29/11
 * Time: 2:37 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.events {
import flash.events.Event;

import org.as3commons.collections.SortedMap;

public class ConnectionEvent extends Event {
    static public const CONNECTION_START:String = "connectionStart";

    private var _arguments:SortedMap;

    public function ConnectionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
            super(type, bubbles, cancelable);
    }

    override public function clone():Event {
        var result:ConnectionEvent = new ConnectionEvent(type, bubbles, cancelable);

        return result;
    }

    public function get arguments():SortedMap {
        return _arguments;
    }

    public function set arguments(value:SortedMap):void {
        _arguments = value;
    }
}
}
