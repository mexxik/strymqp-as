/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 6:36 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.transport.v091 {
import flash.utils.ByteArray;

import org.strym.amqp.actionscript.io.ByteReadWritable;
import org.strym.amqp.actionscript.transport.Frame;

public class Frame091 extends Frame {


    public function Frame091() {
    }

    override public function read(data:ByteArray):void {
    }

    override public function write(data:ByteArray):void {
        data.writeByte(_type);
        data.writeShort(_channel);
        data.writeInt(_payload.length);
        data.writeBytes(_payload);
        data.writeByte(206);
    }


}
}
