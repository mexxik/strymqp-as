/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/10/12
 * Time: 12:59 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.converters {
import flash.utils.ByteArray;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

public class StringConverter implements IMessageConverter {
    public function StringConverter() {
    }

    public function serialize(object:*):IDataInput {
        if (!(object is String))
            throw Error("Unable to serialize: payload is not a String");

        var result:ByteArray = new ByteArray();
        var string:String = object as String;

        result.writeUTFBytes(string);
        result.position = 0;

        return result;
    }

    public function deserialize(data:IDataInput):* {
        var result:String = data.readUTFBytes((data as ByteArray).length);

        return result;
    }
}
}
