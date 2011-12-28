/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/27/11
 * Time: 4:04 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.protocol.definition {
import org.as3commons.collections.Map;

public class ProtocolClass implements IProtocolClass {
    protected var _id:int = 0;
    protected var _name:String = "";

    private var _methods:Map = new Map();
    
    public function ProtocolClass() {
    }

    /**
     * id
     */
    public function get id():int {
        return _id;
    }

    public function set id(value:int):void {
        _id = value;
    }

    /**
     * name
     */
    public function get name():String {
        return _name;
    }
    
    public function set name(value:String):void {
        _name = value;
    }

    /**
     * methods
     */
    public function getMethod(id:int):IProtocolMethod {
        return _methods.itemFor(id) as IProtocolMethod;
    }

    public function get methods():Map {
        return _methods;
    }

    public function set methods(value:Map):void {
        _methods = value;
    }
}
}
