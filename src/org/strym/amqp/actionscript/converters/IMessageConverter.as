/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/10/12
 * Time: 12:57 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.converters {
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

public interface IMessageConverter {
    function serialize(object:*):IDataInput;
    function deserialize(data:IDataInput):*;
}
}
