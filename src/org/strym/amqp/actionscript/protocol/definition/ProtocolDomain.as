/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/28/11
 * Time: 1:59 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.protocol.definition {
import flash.utils.ByteArray;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

public class ProtocolDomain implements IProtocolDomain {
    protected var _name:String;
    protected var _type:String;


    public function read(data:IDataInput):* {

    }

    public function write(data:IDataOutput, value:*):void {
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
}
}
