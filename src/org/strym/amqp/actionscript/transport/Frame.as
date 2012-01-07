/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/6/12
 * Time: 2:55 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.transport {
import flash.utils.ByteArray;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

import org.strym.amqp.actionscript.io.IReadWritable;

public class Frame implements IFrame {
    protected var _isComplete:Boolean = false;
    protected var _isHeaderComplete:Boolean = false;

    protected var _type:uint;
    protected var _channel:int;
    protected var _payloadSize:int;
    protected var _payload:ByteArray = new ByteArray();

    public function Frame() {
    }

    public function get isComplete():Boolean {
        return _isComplete;
    }

    public function set isComplete(value:Boolean):void {
        _isComplete = value;
    }

    public function get isHeaderComplete():Boolean {
        return _isHeaderComplete;
    }

    public function set isHeaderComplete(value:Boolean):void {
        _isHeaderComplete = value;
    }

    public function get type():uint {
        return _type;
    }

    public function set type(value:uint):void {
        _type = value;
    }

    public function get channel():int {
        return _channel;
    }

    public function set channel(value:int):void {
        _channel = value;
    }

    public function get payloadSize():int {
        return _payloadSize;
    }

    public function set payloadSize(value:int):void {
        _payloadSize = value;
    }

    public function get payload():ByteArray {
        return _payload;
    }

    public function set payload(value:ByteArray):void {
        _payload = value;
    }

    public function read(data:IDataInput):void {
    }

    public function write(data:IDataOutput):void {
    }
}
}
