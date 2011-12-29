/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 2:30 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.connection {
public interface IConnection {
    function get connectionParameters():ConnectionParameters;
    function set connectionParameters(value:ConnectionParameters):void;

    function open():void;
    function get isOpened():Boolean;

    function get isStarted():Boolean;
}
}
