/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/28/11
 * Time: 2:43 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.io {
import flash.utils.ByteArray;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

public interface IReadWritable {
    function read(data:IDataInput):void;

    function write(data:IDataOutput):void;
}
}
