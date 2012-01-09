/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/9/12
 * Time: 7:37 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.events {
import flash.events.Event;

import org.strym.amqp.actionscript.exchange.Exchange;

public class ExchangeEvent extends Event {
    static public const EXCHANGE_DECLARED:String = "exchangedDeclared";

    private var _exchange:Exchange;

    public function ExchangeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
        super(type, bubbles, cancelable);
    }

    override public function clone():Event {
        var result:ExchangeEvent = new ExchangeEvent(type, bubbles, cancelable);
        result.exchange = _exchange;

        return result;
    }

    public function get exchange():Exchange {
        return _exchange;
    }

    public function set exchange(value:Exchange):void {
        _exchange = value;
    }
}
}
