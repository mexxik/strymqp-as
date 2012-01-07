/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/27/11
 * Time: 5:09 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.protocol.definition {
import flash.utils.ByteArray;

import org.as3commons.collections.SortedMap;
import org.strym.amqp.actionscript.io.IReadWritable;

public interface IProtocolMethod extends IReadWritable {
    function get id():int;
    function get name():String;
    function get qualifiedName():String;

    function getField(name:String):*;
    function setField(name:String, value:*):void;
    function get fields():SortedMap;
}
}
