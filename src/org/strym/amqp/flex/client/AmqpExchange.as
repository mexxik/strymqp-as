/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 2/1/12
 * Time: 12:58 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.flex.client {
import org.strym.amqp.core.domain.Exchange;

public class AmqpExchange {

    private var _type:String = Exchange.DIRECT;
    private var _name:String;

    public function AmqpExchange() {
    }

    public function get exchange():Exchange {
        var result:Exchange = new Exchange(_type);
        result.name = _name;

        return result;
    }

    [Bindable("propertyChange")]
    [Inspectable(category="General", enumeration="direct,fanout")]
    public function get type():String {
        return _type;
    }

    public function set type(value:String):void {
        _type = value;
    }


    [Bindable("propertyChange")]
    public function get name():String {
        return _name;
    }

    public function set name(value:String):void {
        _name = value;
    }
}
}
