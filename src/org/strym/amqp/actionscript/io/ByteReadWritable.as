/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/28/11
 * Time: 2:43 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.io {
import flash.utils.ByteArray;

public interface ByteReadWritable {
    function read(data:ByteArray):void;
    function write(data:ByteArray):void;
}
}
