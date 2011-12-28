/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 2:13 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.io {
import flash.events.IEventDispatcher;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

import org.strym.amqp.actionscript.connection.ConnectionParameters;

public interface IODelegate extends IEventDispatcher, IDataInput, IDataOutput {
    function open(connectionParameters:ConnectionParameters):void;
    function get connected():Boolean;

    function flush():void;
}
}
