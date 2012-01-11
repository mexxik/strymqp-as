/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/11/12
 * Time: 7:25 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.flex.client {
import flash.events.Event;

import org.strym.amqp.core.domain.Queue;
import org.strym.amqp.core.events.ChannelEvent;
import org.strym.amqp.core.events.MessageEvent;

public class AmqpConsumer extends AmqpClient {
    static public const BINDING_RESULT:String = "bindingResult";

    protected var _queueObject:Queue;

    // component properties
    protected var _queue:String;
    protected var _routingKey:String;

    protected var _autoConsume:Boolean;

    protected var _result:Object;

    public function AmqpConsumer() {
        super();
    }


    override public function initialized(document:Object, id:String):void {
        super.initialized(document, id);

        _connection.addEventListener(MessageEvent.MESSAGE_RECEIVED, onMessageReceived);
    }

// ------------------------------------------------------------
    // public methods
    // ------------------------------------------------------------
    public function setResult(value:Object):void {
        _result = value;

        dispatchEvent(new Event(BINDING_RESULT));
    }

    // ------------------------------------------------------------
    // event handlers
    // ------------------------------------------------------------
    override protected function onChannelOpened(event:ChannelEvent):void {
        super.onChannelOpened(event);

        if (_queue && _queue != "") {
            _queueObject = new Queue(_queue);

            _connection.declareQueue(_queueObject);
        }

        if (_autoConsume) {
            _connection.consume(_queueObject);
        }
    }

    protected function onMessageReceived(event:MessageEvent):void {
        setResult(event.message.body);
    }

    // ------------------------------------------------------------
    // getters/setters
    // ------------------------------------------------------------
    public function get queueObject():Queue {
        return _queueObject;
    }

    public function set queueObject(value:Queue):void {
        _queueObject = value;
    }

    public function get queue():String {
        return _queue;
    }

    public function set queue(value:String):void {
        _queue = value;
    }

    public function get routingKey():String {
        return _routingKey;
    }

    public function set routingKey(value:String):void {
        _routingKey = value;
    }

    [Inspectable(defaultValue="true")]
    public function get autoConsume():Boolean {
        return _autoConsume;
    }

    public function set autoConsume(value:Boolean):void {
        _autoConsume = value;
    }

    [Bindable("bindingResult")]
    public function get lastResult():Object {
        return _result;
    }
}
}
