/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/28/11
 * Time: 2:37 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.protocol.definition {
import flash.utils.ByteArray;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

public class MethodField implements IMethodField {
    protected var _name:String;
    protected var _domain:IProtocolDomain;
    protected var _value:*;

    public function MethodField() {
    }

    public function read(data:IDataInput):void {
        _value = _domain.read(data);
    }

    public function write(data:IDataOutput):void {
        _domain.write(data, _value);
    }

    public function get name():String {
        return _name;
    }

    public function set name(value:String):void {
        _name = value;
    }

    public function get domain():IProtocolDomain {
        return _domain;
    }

    public function set domain(value:IProtocolDomain):void {
        _domain = value;
    }

    public function get value():* {
        return _value;
    }

    public function set value(value:*):void {
        _value = value;
    }
}
}
