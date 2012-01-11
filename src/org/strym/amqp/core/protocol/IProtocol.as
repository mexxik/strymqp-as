/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 2:19 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.protocol {
import org.strym.amqp.core.protocol.definition.IProtocolMethod;

public interface IProtocol {
    function get id():int;

    function get major():int;

    function get minor():int;

    function get revision():int;

    function get version():String;

    function getMethod(classId:int, methodId:int):IProtocolMethod;

    function findMethod(className:String, methodName:String):IProtocolMethod;
}
}
