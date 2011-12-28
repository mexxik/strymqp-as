/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/27/11
 * Time: 4:06 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.protocol.definition {
public interface IProtocolClass {
    function get id():int;

    function getMethod(id:int):IProtocolMethod;
}
}
