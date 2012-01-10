/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/6/12
 * Time: 5:22 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.transport {
import flash.events.EventDispatcher;

import org.strym.amqp.actionscript.protocol.IProtocol;

public class Channel extends EventDispatcher implements IChannel  {
    protected var _id:uint;
    protected var _protocol:IProtocol;

    protected var _currentHeader:IFrame;
    protected var _currentBody:IFrame;

    public function Channel(id:uint, protocol:IProtocol) {
        _id = id;
        _protocol = protocol;
    }

    public function get id():uint {
        return _id;
    }

    public function handleFrame(frame:IFrame):void {
    }
}
}
