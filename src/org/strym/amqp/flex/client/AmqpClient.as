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
import org.strym.amqp.core.events.ConnectionEvent;

[Event(name="simpleConnectionCreated", type="org.strym.amqp.core.events.ConnectionEvent")]
public class AmqpClient extends EventDispatcher implements IMXMLObject {
    // defaults:

    // amqp core:
    protected var _connectionParameters:ConnectionParameters;
    protected var _connection:IConnection;
    protected var _connectionFactory:IConnectionFactory;

    // component properties
    protected var _autoConnect:Boolean = false;
    protected var _host:String;

    private var _exchanges:Array = [];

    // component state
    protected var _connected:Boolean;

    public function AmqpClient() {
        super();
    }


    public function initialized(document:Object, id:String):void {
        _connectionParameters = new ConnectionParameters();
        _connectionParameters.host = _host;

        _connectionFactory = new ConnectionFactory(_connectionParameters);
        _connection = _connectionFactory.connection;

        _connection.addEventListener(ChannelEvent.CHANNEL_OPENED, onChannelOpened);

        if (_autoConnect) {
            _connection.connect();
        }
    }

    // ------------------------------------------------------------
    // public methods
    // ------------------------------------------------------------a
    public function connect():void {
        if (_connection && !_connected) {
            _connection.connect();
        }
    }

    // ------------------------------------------------------------
    // event handlers
    // ------------------------------------------------------------
    protected function onChannelOpened(event:ChannelEvent):void {
        connected = true;

        dispatchEvent(new ConnectionEvent(ConnectionEvent.SIMPLE_CONNECTION_CREATED));
    }

    // ------------------------------------------------------------
    // getters/setters
    // ------------------------------------------------------------
    [Inspectable(defaultValue="true")]
    [Bindable(event="propertyChange")]
    public function get autoConnect():Boolean {
        return _autoConnect;
    }

    public function set autoConnect(value:Boolean):void {
        _autoConnect = value;
    }

    [Bindable(event="propertyChange")]
    public function get host():String {
        return _host;
    }

    public function set host(value:String):void {
        _host = value;
    }

    [Bindable]
    public function get connected():Boolean {
        return _connected;
    }

    public function set connected(value:Boolean):void {
        _connected = value;
    }

    [Bindable("propertyChange")]
    [Inspectable(category="General", arrayType="org.strym.amqp.flex.client.AmqpExchange")]
    public function get exchanges():Array {
        return _exchanges;
    }

    public function set exchanges(value:Array):void {
        _exchanges = value;
    }
}
}
