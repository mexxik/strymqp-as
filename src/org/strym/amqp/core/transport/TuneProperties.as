/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/5/12
 * Time: 9:22 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.transport {
public class TuneProperties {
    private var _channelMax:int;
    private var _frameMax:uint;
    private var _heartbeat:int;

    public function TuneProperties() {
    }

    public function get channelMax():int {
        return _channelMax;
    }

    public function set channelMax(value:int):void {
        _channelMax = value;
    }

    public function get frameMax():uint {
        return _frameMax;
    }

    public function set frameMax(value:uint):void {
        _frameMax = value;
    }

    public function get heartbeat():int {
        return _heartbeat;
    }

    public function set heartbeat(value:int):void {
        _heartbeat = value;
    }
}
}
