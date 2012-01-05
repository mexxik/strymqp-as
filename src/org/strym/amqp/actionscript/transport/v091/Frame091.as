/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 6:36 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.transport.v091 {
import flash.utils.ByteArray;

import org.strym.amqp.actionscript.io.ByteReadWritable;

// TODO: make Frames more generic via interfaces and parent classes
public class Frame091 implements ByteReadWritable {
    private var _isComplete:Boolean = false;
    private var _isHeaderComplete:Boolean = false;

    private var _type:uint;
    private var _channel:int;
    private var _payloadSize:int;
    private var _payload:ByteArray = new ByteArray();

    public function Frame091() {
    }

    public function read(data:ByteArray):void {
    }

    public function write(data:ByteArray):void {
        data.writeByte(_type);
        data.writeShort(_channel);
        data.writeInt(_payload.length);
        data.writeBytes(_payload);
        data.writeByte(206);
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
}
}
