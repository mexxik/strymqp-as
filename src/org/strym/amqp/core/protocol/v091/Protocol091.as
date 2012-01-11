/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 2:18 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.protocol.v091 {
import org.strym.amqp.core.protocol.IProtocol;
import org.strym.amqp.core.protocol.Protocol;
import org.strym.amqp.core.protocol.v091.definition.ProtocolDefinition091;

public class Protocol091 extends Protocol {

    public function Protocol091() {
        _definition = new ProtocolDefinition091();
    }

    override public function get id():int {
        return 0;
    }

    override public function get major():int {
        return 0;
    }

    override public function get minor():int {
        return 9;
    }

    override public function get revision():int {
        return 1;
    }
}
}
