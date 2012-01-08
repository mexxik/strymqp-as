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
    function flush(data:IDataOutput):void;

    function readBit(data:IDataInput):Boolean;
    function writeBit(data:IDataOutput, value:Boolean):void;

    function readOctet(data:IDataInput):uint;
    function writeOctet(data:IDataOutput, value:uint):void;

    function readShort(data:IDataInput):int;
    function writeShort(data:IDataOutput, value:int):void;

    function readInt(data:IDataInput):int;
    function writeInt(data:IDataOutput, value:int):void;

    function readShortString(data:IDataInput):String;
    function writeShortString(data:IDataOutput, value:String):void;

    function readLongString(data:IDataInput):ByteArray;
    function writeLongString(data:IDataOutput, value:ByteArray):void;

    function readTimestamp(data:IDataInput):Date;
    function writeTimestamp(data:IDataOutput, value:Date):void;

    function readTable(data:IDataInput):SortedMap;
    function writeTable(data:IDataOutput, value:SortedMap):void;
}
}
