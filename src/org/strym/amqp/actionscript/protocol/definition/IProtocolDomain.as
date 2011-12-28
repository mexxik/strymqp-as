/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/28/11
 * Time: 1:57 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.protocol.definition {
import flash.utils.ByteArray;

import org.strym.amqp.actionscript.io.ByteReadWritable;

public interface IProtocolDomain {
    function get name():String;
    function get type():String;

    function read(data:ByteArray):*;
    function write(value:*):void;
}
}
