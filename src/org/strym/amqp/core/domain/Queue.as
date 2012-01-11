/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/9/12
 * Time: 8:22 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.domain {
public class Queue {

    private var _name:String;

    private var _passive:Boolean = false;
    private var _durable:Boolean = false;
    private var _exclusive:Boolean = false;
    private var _autoDelete:Boolean = true;
    private var _nowait:Boolean = false;

    public function Queue(name:String) {
        _name = name;
    }

    public function get name():String {
        return _name;
    }

    public function set name(value:String):void {
        _name = value;
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

    public function get exclusive():Boolean {
        return _exclusive;
    }

    public function set exclusive(value:Boolean):void {
        _exclusive = value;
    }

    public function get autoDelete():Boolean {
        return _autoDelete;
    }

    public function set autoDelete(value:Boolean):void {
        _autoDelete = value;
    }

    public function get nowait():Boolean {
        return _nowait;
    }

    public function set nowait(value:Boolean):void {
        _nowait = value;
    }
}
}
