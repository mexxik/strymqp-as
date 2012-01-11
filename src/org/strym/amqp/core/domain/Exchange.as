/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/9/12
 * Time: 7:06 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.domain {
public class Exchange {
    static public const DIRECT:String = "direct";

    protected var _name:String;
    protected var _type:String;

    private var _passive:Boolean = false;
    private var _durable:Boolean = false;
    private var _autoDelete:Boolean = true;
    private var _internal:Boolean = false;
    private var _nowait:Boolean = false;

    public function Exchange(name:String, type:String = DIRECT) {
        _name = name;
        _type = type;
    }

    public function get name():String {
        return _name;
    }

    public function set name(value:String):void {
        _name = value;
    }

    public function get type():String {
        return _type;
    }

    public function set type(value:String):void {
        _type = value;
    }

    public function get passive():Boolean {
        return _passive;
    }

    public function set passive(value:Boolean):void {
        _passive = value;
    }

    public function get durable():Boolean {
        return _durable;
    }

    public function set durable(value:Boolean):void {
        _durable = value;
    }

    public function get autoDelete():Boolean {
        return _autoDelete;
    }

    public function set autoDelete(value:Boolean):void {
        _autoDelete = value;
    }

    public function get internal():Boolean {
        return _internal;
    }

    public function set internal(value:Boolean):void {
        _internal = value;
    }

    public function get nowait():Boolean {
        return _nowait;
    }

    public function set nowait(value:Boolean):void {
        _nowait = value;
    }
}
}
