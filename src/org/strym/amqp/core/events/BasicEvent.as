/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/10/12
 * Time: 7:54 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.events {
import flash.events.Event;
import flash.utils.IDataInput;

import org.strym.amqp.core.domain.Delivery;

public class BasicEvent extends Event {
    static public const DELIVERY_STARTED:String = "deliveryStarted";

    static public const DELIVERY_COMPLETE:String = "deliveryComplete";

    private var _delivery:Delivery;

    private var _body:IDataInput;

    public function BasicEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable);
    }

    override public function clone():Event {
        var result:BasicEvent = new BasicEvent(type, bubbles, cancelable);
        result.delivery = _delivery;
        result.body = _body;

        return result;
    }

    public function get delivery():Delivery {
        return _delivery;
    }

    public function set delivery(value:Delivery):void {
        _delivery = value;
    }

    public function get body():IDataInput {
        return _body;
    }

    public function set body(value:IDataInput):void {
        _body = value;
    }
}
}
