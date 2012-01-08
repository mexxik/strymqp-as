/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/27/11
 * Time: 4:08 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.protocol.definition {
import org.as3commons.collections.Map;

public interface IProtocolDefinition {
    function getMethod(classId:int, methodId:int):IProtocolMethod;
    function findMethod(className:String, methodName:String):IProtocolMethod;
}
}
