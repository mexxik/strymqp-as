/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 2:32 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.connection {
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;

import org.strym.amqp.actionscript.events.ConnectionEvent;

import org.strym.amqp.actionscript.io.IODelegate;
import org.strym.amqp.actionscript.io.SocketDelegate;
import org.strym.amqp.actionscript.transport.ITransport;
import org.strym.amqp.actionscript.transport.Transport;

public class Connection implements IConnection {
    protected var _connectionParameters:ConnectionParameters;

    protected var _transport:ITransport;

    protected var _started:Boolean = false;

    public function Connection(connectionParameters:ConnectionParameters) {
        _connectionParameters = connectionParameters;
    }

    public function get connectionParameters():ConnectionParameters {
        return _connectionParameters;
    }

    public function set connectionParameters(value:ConnectionParameters):void {
        _connectionParameters = connectionParameters;
    }

    public function open():void {
        if (_connectionParameters && !isOpened) {
            _transport = Transport.getTransport(_connectionParameters.protocol);

            _transport.addEventListener(ConnectionEvent.CONNECTION_START, transport_connectionStartHandler);

            _transport.open(_connectionParameters);
        }
        else {
            throw Error("connection parameters are not specified");
        }
    }

    public function get isOpened():Boolean {
        return _transport ? _transport.connected : false;
    }


    public function get isStarted():Boolean {
        return _started;
    }

    /**
     * transport event handlers
     */
    protected function transport_connectionStartHandler(event:ConnectionEvent):void {
        _started = true;
    }
}
}
