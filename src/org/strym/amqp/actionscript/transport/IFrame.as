/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/6/12
 * Time: 2:53 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.transport {
import flash.utils.ByteArray;
import flash.utils.IDataOutput;

import org.strym.amqp.actionscript.io.IReadWritable;
import org.strym.amqp.actionscript.protocol.definition.IDomainReaderWriter;

public interface IFrame extends IReadWritable {
    function get isComplete():Boolean;
    function set isComplete(value:Boolean):void;

    function get isHeaderComplete():Boolean;
    function set isHeaderComplete(value:Boolean):void;

    function get type():uint;
    function set type(value:uint):void;

    function get channel():int;
    function set channel(value:int):void;

    function get payloadSize():int;
    function set payloadSize(value:int):void;

    function get payload():ByteArray;
    function set payload(value:ByteArray):void;

    function close(data:IDataOutput):void;
}
}
