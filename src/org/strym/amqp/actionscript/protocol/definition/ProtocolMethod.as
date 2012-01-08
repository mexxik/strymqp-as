/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/27/11
 * Time: 5:09 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.protocol.definition {
import flash.utils.ByteArray;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

import org.as3commons.collections.Map;
import org.as3commons.collections.SortedMap;
import org.as3commons.collections.framework.IIterator;

public class ProtocolMethod implements IProtocolMethod {
    protected var _readWriter:IDomainReaderWriter;

    protected var _id:int = 0;
    protected var _name:String;
    protected var _fields:SortedMap = new SortedMap();

    protected var _protocolClass:IProtocolClass;

    public function ProtocolMethod() {
    }

    public function set readWriter(readWriter:IDomainReaderWriter):void {
        _readWriter = readWriter;
    }

    public function addField(field:IMethodField):void {
        _fields.add(field.name, field);
    }


    public function get fields():SortedMap {
        return _fields;
    }

    public function getField(name:String):* {
        var field:IMethodField = _fields.itemFor(name);
        return field.value;
    }

    public function setField(name:String, value:*):void {
        var field:IMethodField = _fields.itemFor(name);
        field.value = value;
    }

    public function read(data:IDataInput):void {
        var iterator:IIterator = _fields.iterator();
        while (iterator.hasNext()) {
            var field:IMethodField = iterator.next();

            field.read(data);
        }
    }

    public function write(data:IDataOutput):void {

    }

    public function get qualifiedName():String {
        return _protocolClass.name + "." + _name;
    }

    public function get id():int {
        return _id;
    }

    public function set id(value:int):void {
        _id = value;
    }

    public function get name():String {
        return _name;
    }

    public function set name(value:String):void {
        _name = value;
    }

    public function get protocolClass():IProtocolClass {
        return _protocolClass;
    }

    public function set protocolClass(value:IProtocolClass):void {
        _protocolClass = value;
    }
}
}
