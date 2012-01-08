/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/27/11
 * Time: 4:03 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.protocol.definition {
import org.as3commons.collections.Map;
import org.as3commons.collections.framework.IIterator;

public class ProtocolDefinition implements IProtocolDefinition {
    protected var _domains:Map = new Map();
    protected var _classes:Map = new Map();

    public function ProtocolDefinition() {
    }

    public function getMethod(classId:int, methodId:int):IProtocolMethod {
        var protocolClass:IProtocolClass = _classes.itemFor(classId);

        if (protocolClass)
            return protocolClass.getMethod(methodId);

        return null;
    }

    public function findMethod(methodName:String):IProtocolMethod {
        var iterator:IIterator = _classes.iterator();
        while (iterator.hasNext()) {
            var methodClass:IProtocolClass = iterator.next() as IProtocolClass;
            var protocolMethod:IProtocolMethod = methodClass.findMethod(methodName);
            if (protocolMethod)
                return protocolMethod;
        }
        return null;
    }
}
}
