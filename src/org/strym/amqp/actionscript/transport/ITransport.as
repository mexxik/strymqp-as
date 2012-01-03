/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 5:13 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.transport {
import flash.events.IEventDispatcher;

import org.strym.amqp.actionscript.connection.ConnectionParameters;
import org.strym.amqp.actionscript.io.IODelegate;
import org.strym.amqp.actionscript.protocol.IProtocol;

public interface ITransport extends IEventDispatcher {
    function open(connectionParameters:ConnectionParameters):void;
    function get connected():Boolean;
}
}
