/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/28/11
 * Time: 4:17 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.protocol.v091.definition {
import flash.utils.ByteArray;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

import org.as3commons.collections.SortedMap;
import org.as3commons.collections.framework.IIterator;

import org.strym.amqp.core.protocol.definition.DomainReadWriter;
import org.strym.amqp.core.protocol.v091.utils.BitAccumulator;

public class DomainReadWriter091 extends DomainReadWriter {
    private var _bitAccumulator:BitAccumulator = new BitAccumulator();

    public function DomainReadWriter091() {
    }

    override public function flush(data:IDataOutput):void {
        _bitAccumulator.flush(data);
    }

    override public function readBit(data:IDataInput):Boolean {
        return false;
    }

    override public function writeBit(data:IDataOutput, bit:Boolean):void {
        _bitAccumulator.writeBit(data, bit);
    }

    /*
     numeric
     */

    override public function readOctet(data:IDataInput):uint {
        return data.readUnsignedByte();
    }

    override public function writeOctet(data:IDataOutput, octet:uint):void {
        _bitAccumulator.flush(data);

        data.writeByte(octet);
    }

    override public function readShort(data:IDataInput):int {
        return data.readShort();
    }

    override public function writeShort(data:IDataOutput, value:int):void {
        _bitAccumulator.flush(data);

        data.writeShort(value);
    }

    override public function readInt(data:IDataInput):int {
        return data.readInt();
    }

    override public function writeInt(data:IDataOutput, value:int):void {
        _bitAccumulator.flush(data);

        data.writeInt(value);
    }

    /*
     strings
     */

    override public function readShortString(data:IDataInput):String {
        var length:uint = data.readUnsignedByte();
        var result:String = data.readUTFBytes(length);

        return result;
    }

    override public function writeShortString(data:IDataOutput, string:String):void {
        _bitAccumulator.flush(data);

        if (string == "")
            data.writeByte(0);
        else {
            data.writeByte(string.length);
            data.writeUTFBytes(string);
        }
    }

    // TODO check if read/write long string is correct
    override public function readLongString(data:IDataInput):ByteArray {
        var result:ByteArray = new ByteArray();

        data.readBytes(result, 0, data.readUnsignedInt());
        result.position = 0;

        return result;
    }

    override public function writeLongString(data:IDataOutput, string:ByteArray):void {
        _bitAccumulator.flush(data);

        data.writeUnsignedInt(string.length);
        data.writeBytes(string, 0, string.length);
    }

    /*
     miscellaneous
     */

    override public function readTimestamp(data:IDataInput):Date {
        var result:Date = new Date();

        var upper:uint = data.readUnsignedInt();
        var lower:uint = data.readUnsignedInt();

        result.setTime(lower);

        return result;
    }

    override public function writeTimestamp(data:IDataOutput, timestamp:Date):void {
        _bitAccumulator.flush(data);

        data.writeUnsignedInt(0);
        data.writeUnsignedInt(timestamp.getTime() * 1000);
    }

    override public function readTable(data:IDataInput):SortedMap {
        var result:SortedMap = new SortedMap();

        var length:uint = data.readUnsignedInt();

        if (length) {
            var start:uint = (data as ByteArray).position;

            while ((data as ByteArray).position < (start + length)) {
                var name:String = readShortString(data);
                var type:uint = data.readUnsignedByte();
                var value:* = null;

                switch (type) {
                    case 70:
                        value = readTable(data);
                        break;

                    case 73:
                        value = data.readUnsignedInt();
                        break;

                    case 83:
                        value = readLongString(data);
                        break;

                    case 84:
                        value = readTimestamp(data);
                        break;

                    case 116: // boolean?
                        // TODO implement proper amqp bits handling
                        value = data.readUnsignedByte();
                        break;
                }

                if (value) {
                    result.add(name, value);
                }
            }
        }

        return result;
    }

    override public function writeTable(data:IDataOutput, table:SortedMap):void {
        _bitAccumulator.flush(data);
        //data.writeByte(70);

        var content:ByteArray = new ByteArray();

        var iterator:IIterator = table.keyIterator();
        while (iterator.hasNext()) {
            var key:String = iterator.next() as String;
            var value:* = table.itemFor(key);

            writeShortString(content, key);

            if (value is String) {
                content.writeByte(83);

                var byteArray:ByteArray = new ByteArray();
                byteArray.writeUTFBytes(value);
                writeLongString(content, byteArray);
            }
        }

        data.writeUnsignedInt(content.length);
        data.writeBytes(content);
    }
}
}
