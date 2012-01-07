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

public interface IDomainReaderWriter {
    function readBit(data:IDataInput):Boolean;
    function writeBit(data:IDataOutput, bit:Boolean):void;

    function readOctet(data:IDataInput):uint;
    function writeOctet(data:IDataOutput, octet:uint):void;

    function readShortString(data:IDataInput):String;
    function writeShortString(data:IDataOutput, string:String):void;

    function readLongString(data:IDataInput):ByteArray;
    function writeLongString(data:IDataOutput, string:ByteArray):void;

    function readTimestamp(data:IDataInput):Date;
    function writeTimestamp(data:IDataOutput, timestamp:Date):void;

    function readTable(data:IDataInput):SortedMap;
    function writeTable(data:IDataOutput, table:SortedMap):void;
}
}
