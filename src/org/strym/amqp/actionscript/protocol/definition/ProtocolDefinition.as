/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/27/11
 * Time: 4:03 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.protocol.definition {
import org.as3commons.collections.Map;

public class ProtocolDefinition implements IProtocolDefinition {
    protected var _classes:Map = new Map();

    public function ProtocolDefinition() {
    }


    public function getMethod(classId:int, methodId:int):IProtocolMethod {
        var protocolClass:IProtocolClass = _classes.itemFor(classId);

        if (protocolClass)
            return protocolClass.getMethod(methodId);

        return null;
    }
}
}
