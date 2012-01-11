/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 4:44 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.protocol {
import org.strym.amqp.core.protocol.definition.IProtocolDefinition;
import org.strym.amqp.core.protocol.definition.IProtocolMethod;
import org.strym.amqp.core.protocol.v091.Protocol091;

public class Protocol implements IProtocol {
    static public const VERSION_0_9_1:String = "0.9.1";

    protected var _definition:IProtocolDefinition;

    static public function getProtocol(version:String):IProtocol {
        switch (version) {
            case (VERSION_0_9_1):
                return new Protocol091();

            default:
                return new Protocol();
        }
    }

    public function Protocol() {
    }

    public function get id():int {
        return 0;
    }

    public function get major():int {
        return 0;
    }

    public function get minor():int {
        return 0;
    }

    public function get revision():int {
        return 0;
    }

    public function get version():String {
        return major.toString() + "." + minor.toString() + "." + revision.toString();
    }

    public function getMethod(classId:int, methodId:int):IProtocolMethod {
        return _definition.getMethod(classId, methodId);
    }

    public function findMethod(className:String, methodName:String):IProtocolMethod {
        return _definition.findMethod(className, methodName);
    }
}
}
