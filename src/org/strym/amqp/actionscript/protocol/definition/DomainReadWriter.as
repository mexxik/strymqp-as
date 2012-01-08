/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/28/11
 * Time: 4:16 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.protocol.definition {
import flash.utils.ByteArray;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

import org.as3commons.collections.SortedMap;

public class DomainReadWriter implements IDomainReaderWriter {
    public function DomainReadWriter() {
    }

    public function flush(data:IDataOutput):void {
    }


    public function readBit(data:IDataInput):Boolean {
        return false;
    }

    public function writeBit(data:IDataOutput, value:Boolean):void {
    }

    /*
     numeric
     */

    public function readOctet(data:IDataInput):uint {
        return 0;
    }

    public function writeOctet(data:IDataOutput, value:uint):void {
    }

    public function readShort(data:IDataInput):int {
        return 0;
    }

    public function writeShort(data:IDataOutput, value:int):void {
    }

    public function readInt(data:IDataInput):int {
        return 0;
    }

    public function writeInt(data:IDataOutput, value:int):void {
    }

    /*
     strings
     */
    public function readShortString(data:IDataInput):String {
        return "";
    }

    public function writeShortString(data:IDataOutput, value:String):void {
    }

    public function readLongString(data:IDataInput):ByteArray {
        return new ByteArray();
    }

    public function writeLongString(data:IDataOutput, value:ByteArray):void {
    }

    /*
     miscellaneous
     */

    public function readTimestamp(data:IDataInput):Date {
        return new Date();
    }

    public function writeTimestamp(data:IDataOutput, value:Date):void {
    }

    public function readTable(data:IDataInput):SortedMap {
        return null;
    }

    public function writeTable(data:IDataOutput, value:SortedMap):void {
    }
}
}
