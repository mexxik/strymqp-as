/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/28/11
 * Time: 2:35 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.protocol.definition {
import org.strym.amqp.actionscript.io.ByteReadWritable;

public interface IMethodField extends ByteReadWritable {
    function get name():String;
    function get domain():IProtocolDomain;
    function get value():*;
}
}