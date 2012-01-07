/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 6:36 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.transport.v091 {
import flash.utils.ByteArray;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

import org.strym.amqp.actionscript.io.IReadWritable;
import org.strym.amqp.actionscript.transport.Frame;

public class Frame091 extends Frame {


    public function Frame091() {
    }

    override public function read(data:IDataInput):void {
        if (!_isHeaderComplete) {

            // not enough data
            if (data.bytesAvailable < 8)
                return;

            _type = data.readUnsignedByte();

            if (type == ('A' as uint)) {
                // possibly wrong protocol
                // TODO implement proper handling
            }

            _channel = data.readUnsignedShort();
            _payloadSize = data.readInt();

            _isHeaderComplete = true;
        }

        if (_payloadSize > 0 && _payload.length < _payloadSize) {

            data.readBytes(_payload, _payload.length, Math.min(data.bytesAvailable, _payloadSize - _payload.length));

            if (_payload.length < _payloadSize)
                return;
        }

        if (data.bytesAvailable > 0)
            var frameEnd:int = data.readUnsignedByte();

        // TODO handler end frame marker handling (code: 206)

        _isComplete = true;
    }

    override public function write(data:IDataOutput):void {
        data.writeByte(_type);
        data.writeShort(_channel);
        data.writeInt(_payload.length);
        data.writeBytes(_payload);
        data.writeByte(206);
    }


}
}
