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

public interface IDomainReaderWriter {
    function readBit(data:ByteArray):Boolean;
    function writeBit(data:ByteArray, bit:Boolean):void;

    function readOctet(data:ByteArray):uint;
    function writeOctet(data:ByteArray, octet:uint):void;

    function readShortString(data:ByteArray):String;
    function writeShortString(data:ByteArray, string:String):void;

    function readLongString(data:ByteArray):ByteArray;
    function writeLongString(data:ByteArray, string:ByteArray):void;

    function readTimestamp(data:ByteArray):Date;
    function writeTimestamp(data:ByteArray, timestamp:Date):void;

    function readTable(data:ByteArray):SortedMap;
    function writeTable(data:ByteArray, table:SortedMap):void;
}
}
