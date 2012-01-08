/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/8/12
 * Time: 4:26 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.protocol.v091.utils {
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

public class BitAccumulator {
    private var _bits:uint = 0;
    private var _mask:uint = 1;

    public function BitAccumulator() {
    }

    private function clear():void {
        _bits = 0;
        _mask = 1;
    }

    private function get isDirty():Boolean {
        return _mask > 1;
    }

    public function flush(data:IDataOutput):void {
        if (isDirty) {
            data.writeByte(_bits);
            clear();
        }
    }

    public function writeBit(data:IDataOutput, bit:Boolean):void {
        if (_mask > 128) {
            flush(data);
        }

        if (bit) {
            _bits |= _mask;
        }

        _mask <<= 1;
    }
}
}
