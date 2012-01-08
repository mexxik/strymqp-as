/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 2:30 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.connection {
import flash.events.IEventDispatcher;

public interface IConnection extends IEventDispatcher {
    function get name():String;
    function set name(value:String):void;

    function get connectionParameters():ConnectionParameters;
    function set connectionParameters(value:ConnectionParameters):void;

    function connect():void;

    function get connected():Boolean;
    function get started():Boolean;
    function get tuned():Boolean;
}
}
