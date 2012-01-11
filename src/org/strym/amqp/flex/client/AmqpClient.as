/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/11/12
 * Time: 4:11 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.flex.client {
import flash.events.EventDispatcher;

import mx.core.IMXMLObject;

import org.strym.amqp.core.connection.Connection;
import org.strym.amqp.core.connection.ConnectionFactory;
import org.strym.amqp.core.connection.ConnectionParameters;
import org.strym.amqp.core.connection.IConnection;
import org.strym.amqp.core.connection.IConnectionFactory;
import org.strym.amqp.core.events.ChannelEvent;

public class AmqpClient extends EventDispatcher implements IMXMLObject {
    // defaults:

    // amqp core:
    protected var _connectionParameters:ConnectionParameters;
    protected var _connection:IConnection;
    protected var _connectionFactory:IConnectionFactory;

    // component properties
    private var _host:String;

    // component state
    private var _connected:Boolean;

    public function AmqpClient() {
        super();
    }


    public function initialized(document:Object, id:String):void {
        _connectionParameters = new ConnectionParameters();
        _connectionParameters.host = _host;

        _connectionFactory = new ConnectionFactory(_connectionParameters);
        _connection = _connectionFactory.connection;

        _connection.addEventListener(ChannelEvent.CHANNEL_OPENED, onChannelOpened);

        _connection.connect();
    }

    // ------------------------------------------------------------
    // event handlers
    // ------------------------------------------------------------
    protected function onChannelOpened(event:ChannelEvent):void {
        connected = true;
    }

    // ------------------------------------------------------------
    // getters/setters
    // ------------------------------------------------------------
    [Bindable(event="propertyChange")]
    public function get host():String {
        return _host;
    }

    public function set host(value:String):void {
        _host = value;
    }

    [Bindable(event="propertyChange")]
    public function get connected():Boolean {
        return _connected;
    }

    public function set connected(value:Boolean):void {
        _connected = value;
    }
}
}
