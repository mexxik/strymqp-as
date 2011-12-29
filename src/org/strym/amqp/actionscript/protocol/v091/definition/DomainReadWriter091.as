/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/28/11
 * Time: 4:17 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.protocol.v091.definition {
import flash.utils.ByteArray;

import org.as3commons.collections.SortedMap;

import org.strym.amqp.actionscript.protocol.definition.DomainReadWriter;

public class DomainReadWriter091 extends DomainReadWriter {
    public function DomainReadWriter091() {
    }


    override public function readBit(data:ByteArray):Boolean {
        return false;
    }

    override public function writeBit(data:ByteArray, bit:Boolean):void {
        super.writeBit(data, bit);
    }

    override public function readOctet(data:ByteArray):uint {
        return data.readUnsignedByte();
    }

    override public function writeOctet(data:ByteArray, octet:uint):void {
        data.writeByte(octet);
    }

    override public function readShortString(data:ByteArray):String {
        var length:uint = data.readUnsignedByte();
        var result:String = data.readUTFBytes(length);

        return result;
    }

    override public function writeShortString(data:ByteArray, string:String):void {
        data.writeByte(string.length);
        data.writeUTFBytes(string);
    }

    // TODO check if read/write long string is correct
    override public function readLongString(data:ByteArray):ByteArray {
        var result:ByteArray = new ByteArray();

        data.readBytes(result, 0, data.readUnsignedInt());
        result.position = 0;

        return result;
    }

    override public function writeLongString(data:ByteArray, string:ByteArray):void {
        data.writeUnsignedInt(string.length);
        data.writeBytes(string, 0, string.length);
    }

    override public function readTimestamp(data:ByteArray):Date {
        var result:Date = new Date();

        var upper:uint = data.readUnsignedInt();
        var lower:uint = data.readUnsignedInt();

        result.setTime(lower);

        return result;
    }

    override public function writeTimestamp(data:ByteArray, timestamp:Date):void {
        data.writeUnsignedInt(0);
        data.writeUnsignedInt(timestamp.getTime() * 1000);
    }

    override public function readTable(data:ByteArray):SortedMap {
        var result:SortedMap = new SortedMap();

        var length:uint = data.readUnsignedInt();

        if (length) {
            var start:uint = data.position;

            while (data.position < (start + length)) {
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

    override public function writeTable(data:ByteArray, table:SortedMap):void {
    }
}
}
