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
    protected var _exchange:Exchange;
    protected var _queue:Queue;

    // component properties
    private var _autoBind:Boolean = false;

    protected var _exchangeName:String;
    protected var _queueName:String;
    protected var _routingKey:String = "";

    public function AmqpProducer() {
        super();
    }

    // ------------------------------------------------------------
    // public methods
    // ------------------------------------------------------------
    public function send(message:*, exchange:String = null, routingKey:String = null):void {
        var destExchange:Exchange = exchange ? new Exchange(exchange) : _exchange;

        //if (!destExchange) {
        //    throw Error("Neither exchange name specified in the send() method nor exchange defined in the Producer");
        //}

        if (_connected) {
            _connection.convertAndSend(message, destExchange, routingKey ? routingKey : _routingKey);
        }
        else {
            throw Error("Unable to send a message - Amqp connection is not opened");
        }
    }

    // ------------------------------------------------------------
    // event handlers
    // ------------------------------------------------------------
    override protected function onChannelOpened(event:ChannelEvent):void {
        super.onChannelOpened(event);

        if (_exchangeName && _exchangeName != "") {
            _exchange = new Exchange(_exchangeName);

            _connection.declareExchange(_exchange);
        }

        if (_queueName && _queueName != "") {
            _queue = new Queue(_queueName);

            _connection.declareQueue(_queue);
        }

        if (_autoBind && _exchangeName && _queueName) {
            _connection.bindQueue(_exchange, _queue, _routingKey);
        }
    }

    // ------------------------------------------------------------
    // getters/setters
    // ------------------------------------------------------------
    [Inspectable(defaultValue="true")]
    public function get autoBind():Boolean {
        return _autoBind;
    }

    public function set autoBind(value:Boolean):void {
        _autoBind = value;
    }

    public function get exchangeName():String {
        return _exchangeName;
    }

    public function set exchangeName(value:String):void {
        _exchangeName = value;
    }

    public function get queueName():String {
        return _queueName;
    }

    public function set queueName(value:String):void {
        _queueName = value;
    }

    public function get routingKey():String {
        return _routingKey;
    }

    public function set routingKey(value:String):void {
        _routingKey = value;
    }
}
}
