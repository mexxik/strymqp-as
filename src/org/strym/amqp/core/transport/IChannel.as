/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/6/12
 * Time: 5:15 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.transport {
import flash.events.IEventDispatcher;

public interface IChannel extends IEventDispatcher {
    function get id():uint;

    function handleFrame(frame:IFrame):void;
}
}
