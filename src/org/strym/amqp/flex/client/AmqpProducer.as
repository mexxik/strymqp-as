/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/11/12
 * Time: 4:32 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.flex.client {
import org.strym.amqp.core.domain.Exchange;
import org.strym.amqp.core.domain.Queue;
import org.strym.amqp.core.events.ChannelEvent;

public class AmqpProducer extends AmqpClient {
    protected var _exchangeObject:Exchange;
    protected var _queueObject:Queue;

    // component properties
    protected var _exchange:String;
    protected var _queue:String;
    protected var _routingKey:String = "";

    public function AmqpProducer() {
        super();
    }

    // ------------------------------------------------------------
    // public methods
    // ------------------------------------------------------------
    public function send(message:*, exchange:String = null, routingKey:String = null):void {
        var destExchange:Exchange = exchange ? new Exchange(exchange) : _exchangeObject;

        //if (!destExchange) {
        //    throw Error("Neither exchange name specified in the send() method nor exchange defined in the Producer");
        //}

        _connection.convertAndSend(message, destExchange, routingKey ? routingKey : _routingKey);
    }

    // ------------------------------------------------------------
    // event handlers
    // ------------------------------------------------------------
    override protected function onChannelOpened(event:ChannelEvent):void {
        super.onChannelOpened(event);

        if (_exchange && _exchange != "") {
            _exchangeObject = new Exchange(_exchange);

            _connection.declareExchange(_exchangeObject);
        }

        if (_queue && _queue != "") {
            _queueObject = new Queue(_queue);

            _connection.declareQueue(_queueObject);
        }

        if (_exchange && _queue) {
            _connection.bindQueue(_exchangeObject, _queueObject, _routingKey);
        }
    }

    // ------------------------------------------------------------
    // getters/setters
    // ------------------------------------------------------------
    public function get exchange():String {
        return _exchange;
    }

    public function set exchange(value:String):void {
        _exchange = value;
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
}
}
