/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/29/11
 * Time: 2:37 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.events {
import flash.events.Event;

import org.as3commons.collections.SortedMap;
import org.strym.amqp.core.connection.IConnection;

public class ConnectionEvent extends Event {
    static public const CONNECTION_STARTED:String = "connectionStarted";
    static public const CONNECTION_TUNED:String = "connectionTuned";
    static public const CONNECTION_OPENED:String = "connectionOpened";
    static public const SIMPLE_CONNECTION_CREATED:String = "simpleConnectionCreated";
    static public const CONNECTION_CLOSED:String = "connectionClosed";

    private var _connection:IConnection;

    private var _arguments:SortedMap;
    private var _data:*;

    public function ConnectionEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable);
    }

    override public function clone():Event {
        var result:ConnectionEvent = new ConnectionEvent(type, bubbles, cancelable);
        result.arguments = _arguments;
        result.data = _data;
        result.connection = _connection;

        return result;
    }

    public function get connection():IConnection {
        return _connection;
    }

    public function set connection(value:IConnection):void {
        _connection = value;
    }

    public function get arguments():SortedMap {
        return _arguments;
    }

    public function set arguments(value:SortedMap):void {
        _arguments = value;
    }

    public function get data():* {
        return _data;
    }

    public function set data(value:*):void {
        _data = value;
    }
}
}
