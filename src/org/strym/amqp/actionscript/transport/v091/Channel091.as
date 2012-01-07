/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 7:45 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.transport.v091 {
import org.as3commons.collections.SortedMap;
import org.strym.amqp.actionscript.events.ConnectionEvent;
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
        }
    }

    private function handlerMethod(method:IProtocolMethod):void {
        var connectionEvent:ConnectionEvent;

        switch (method.qualifiedName) {
            case "connection.start":
                connectionEvent = new ConnectionEvent(ConnectionEvent.CONNECTION_STARTED);
                connectionEvent.arguments = method.fields;

                dispatchEvent(connectionEvent);

                break;

            case "connection.tune":
                var tuneProperties:TuneProperties = new TuneProperties();
                tuneProperties.channelMax = method.getField("channel-max") as int;
                tuneProperties.frameMax = method.getField("frame-max") as uint;
                tuneProperties.heartbeat = method.getField("heartbeat") as int;

                connectionEvent = new ConnectionEvent(ConnectionEvent.CONNECTION_TUNED);
                connectionEvent.data = tuneProperties;

                dispatchEvent(connectionEvent);

                break;
        }
    }

    /*
     Specific
     */
}
}
