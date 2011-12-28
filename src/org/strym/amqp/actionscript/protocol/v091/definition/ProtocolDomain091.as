/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/28/11
 * Time: 2:01 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.protocol.v091.definition {
import flash.utils.ByteArray;

import org.strym.amqp.actionscript.protocol.definition.ProtocolDomain;

public class ProtocolDomain091 extends ProtocolDomain {
    public function ProtocolDomain091() {
    }


    override public function read(data:ByteArray):* {
        var result:*;

        switch (_type) {
            case "octet":
                result = data.readUnsignedByte();
                break;
        }

        return result;
    }

    override public function write(value:*):void {
        super.write(value);
    }
}
}
