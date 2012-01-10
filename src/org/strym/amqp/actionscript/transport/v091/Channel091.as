/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 7:45 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.transport.v091 {
import flash.utils.ByteArray;
import flash.utils.IDataInput;

import org.as3commons.collections.SortedMap;
import org.strym.amqp.actionscript.events.BasicEvent;
import org.strym.amqp.actionscript.events.ChannelEvent;
import org.strym.amqp.actionscript.events.ConnectionEvent;
import org.strym.amqp.actionscript.events.ExchangeEvent;
import org.strym.amqp.actionscript.events.QueueEvent;
import org.strym.amqp.actionscript.protocol.IProtocol;
import org.strym.amqp.actionscript.protocol.definition.IProtocolMethod;
import org.strym.amqp.actionscript.transport.Channel;
import org.strym.amqp.actionscript.transport.IFrame;
import org.strym.amqp.actionscript.transport.TuneProperties;

public class Channel091 extends Channel {

    public function Channel091(id:uint, protocol:IProtocol) {
        super(id, protocol);
    }

    override public function handleFrame(frame:IFrame):void {
        switch (frame.type) {
            // TODO retrieve these constants from the protocol definition
            case 1:
                var classId:int = frame.payload.readShort();
                var methodId:int = frame.payload.readShort();
                var protocolMethod:IProtocolMethod = _protocol.getMethod(classId, methodId);

                protocolMethod.read(frame.payload);

                handlerMethod(protocolMethod);

                break;

            case 2:
                _currentHeader = frame;
                break;

            case 3:
                _currentBody = frame;

                var bodyPayload:ByteArray = frame.payload;

                var basicEvent:BasicEvent = new BasicEvent(BasicEvent.DELIVERY_COMPLETE);
                basicEvent.body = bodyPayload;

                dispatchEvent(basicEvent);

                break;
        }
    }

    private function handlerMethod(method:IProtocolMethod):void {
        var connectionEvent:ConnectionEvent;
        var channelEvent:ChannelEvent;
        var exchangeEvent:ExchangeEvent;
        var queueEvent:QueueEvent;
        var basicEvent:BasicEvent;

        switch (method.qualifiedName) {
            // connection class
            case "connection.start":
                connectionEvent = new ConnectionEvent(ConnectionEvent.CONNECTION_STARTED);
                connectionEvent.arguments = method.fields;

                break;

            case "connection.tune":
                var tuneProperties:TuneProperties = new TuneProperties();
                tuneProperties.channelMax = method.getField("channel-max") as int;
                tuneProperties.frameMax = method.getField("frame-max") as uint;
                tuneProperties.heartbeat = method.getField("heartbeat") as int;

                connectionEvent = new ConnectionEvent(ConnectionEvent.CONNECTION_TUNED);
                connectionEvent.data = tuneProperties;

                break;

            case "connection.open-ok":
                connectionEvent = new ConnectionEvent(ConnectionEvent.CONNECTION_OPENED);

                break;

            // channel class
            case "channel.open-ok":
                channelEvent = new ChannelEvent(ChannelEvent.CHANNEL_OPENED);
                break;

            // exchange class
            case "exchange.declare-ok":
                exchangeEvent = new ExchangeEvent(ExchangeEvent.EXCHANGE_DECLARED);

                break;

            // queue class
            case "queue.declare-ok":
                queueEvent = new QueueEvent(QueueEvent.QUEUE_CREATED);

                break;

            case "queue.bind-ok":
                queueEvent = new QueueEvent(QueueEvent.QUEUE_BOUND);

                break;

            // basic class
            case "basic.deliver":
                basicEvent = new BasicEvent(BasicEvent.DELIVERY_STARTED);
                break;

        }

        if (connectionEvent)
            dispatchEvent(connectionEvent);

        if (channelEvent) {
            channelEvent.channel = this;

            dispatchEvent(channelEvent);
        }

        if (exchangeEvent)
            dispatchEvent(exchangeEvent);

        if (queueEvent)
            dispatchEvent(queueEvent);

        if (basicEvent)
            dispatchEvent(basicEvent);

    }

    /*
     Specific
     */
}
}
