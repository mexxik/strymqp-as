/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/6/12
 * Time: 5:22 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.transport {
import flash.events.EventDispatcher;

public class Channel extends EventDispatcher implements IChannel  {
    protected var _id:uint;

    public function Channel() {
    }

    public function get id():uint {
        return _id;
    }

    public function handleFrame(frame:IFrame):void {
    }
}
}
