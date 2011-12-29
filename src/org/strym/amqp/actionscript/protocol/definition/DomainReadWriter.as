/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/28/11
 * Time: 4:16 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.protocol.definition {
import flash.utils.ByteArray;

import org.as3commons.collections.SortedMap;

public class DomainReadWriter implements IDomainReaderWriter {
    public function DomainReadWriter() {
    }

    public function readBit(data:ByteArray):Boolean {
        return false;
    }

    public function writeBit(data:ByteArray, bit:Boolean):void {
    }

    public function readOctet(data:ByteArray):uint {
        return 0;
    }

    public function writeOctet(data:ByteArray, octet:uint):void {
    }

    public function writeShortString(data:ByteArray, string:String):void {
    }

    public function readShortString(data:ByteArray):String {
        return "";
    }

    public function readLongString(data:ByteArray):ByteArray {
        return new ByteArray();
    }

    public function writeLongString(data:ByteArray, string:ByteArray):void {
        }

    public function readTimestamp(data:ByteArray):Date {
        return new Date();
    }

    public function writeTimestamp(data:ByteArray, timestamp:Date):void {
    }

    public function readTable(data:ByteArray):SortedMap {
        return null;
    }

    public function writeTable(data:ByteArray, table:SortedMap):void {
    }
}
}
