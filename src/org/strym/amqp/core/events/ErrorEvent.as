/**
 * Created with IntelliJ IDEA.
 * User: user
 * Date: 05.06.12
 * Time: 13:47
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.events {
import flash.events.Event;

public class ErrorEvent extends Event {
    static public const ERROR:String = "error";

    private var _errorMessage:String;
    private var _errorDescription:String;

    public function ErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable);
    }

    override public function clone():Event {
        var result:ErrorEvent = new ErrorEvent(type, bubbles, cancelable);
        result.errorMessage = _errorMessage;
        result.errorDescription = _errorDescription;

        return result;
    }

    public function get errorMessage():String {
        return _errorMessage;
    }

    public function set errorMessage(value:String):void {
        _errorMessage = value;
    }

    public function get errorDescription():String {
        return _errorDescription;
    }

    public function set errorDescription(value:String):void {
        _errorDescription = value;
    }
}
}
