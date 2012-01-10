/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/10/12
 * Time: 7:57 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.domain {
public class Delivery {
    private var _consumerTag:String;
    private var _deliveryTag:String;
    private var _redelivered:Boolean;
    private var _exchange:String;
    private var _routingKey:String;

    public function Delivery() {
    }

    public function get consumerTag():String {
        return _consumerTag;
    }

    public function set consumerTag(value:String):void {
        _consumerTag = value;
    }

    public function get deliveryTag():String {
        return _deliveryTag;
    }

    public function set deliveryTag(value:String):void {
        _deliveryTag = value;
    }

    public function get redelivered():Boolean {
        return _redelivered;
    }

    public function set redelivered(value:Boolean):void {
        _redelivered = value;
    }

    public function get exchange():String {
        return _exchange;
    }

    public function set exchange(value:String):void {
        _exchange = value;
    }

    public function get routingKey():String {
        return _routingKey;
    }

    public function set routingKey(value:String):void {
        _routingKey = value;
    }
}
}
