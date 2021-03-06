/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/28/11
 * Time: 2:01 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.protocol.v091.definition {
import flash.utils.ByteArray;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

import org.strym.amqp.core.di.Injector;

import org.strym.amqp.core.protocol.definition.IDomainReaderWriter;

import org.strym.amqp.core.protocol.definition.ProtocolDomain;

public class ProtocolDomain091 extends ProtocolDomain {
    public function ProtocolDomain091() {
        _readWriter = Injector.getObject("domainReadWriter091");
    }

    override public function read(data:IDataInput):* {
        var result:*;

        switch (_type) {
            case "bit":
                result = _readWriter.readBit(data);
                break;

            case "octet":
                result = _readWriter.readOctet(data);
                break;

            case "short":
                result = _readWriter.readShort(data);
                break;

            case "long":
                result = _readWriter.readInt(data);
                break;

            case "table":
                result = _readWriter.readTable(data);
                break;

            case "longstr":
                result = _readWriter.readLongString(data);
                break;
        }

        return result;
    }

    override public function write(data:IDataOutput, value:*):void {
        //super.write(value);
        if (value != null) {
            switch (_type) {
                case "bit":
                    _readWriter.writeBit(data, value);
                    break;

                case "octet":
                    _readWriter.writeOctet(data, value);
                    break;

                case "short":
                    _readWriter.writeShort(data, value);
                    break;

                case "long":
                    _readWriter.writeInt(data, value);
                    break;

                case "table":
                    _readWriter.writeTable(data, value);
                    break;

                case "shortstr":
                    _readWriter.writeShortString(data, value);
                    break;

                case "longstr":
                    var byteArray:ByteArray;
                    if (value is String) {
                        byteArray = new ByteArray();
                        byteArray.writeUTFBytes(value);
                    }
                    else if (value is ByteArray) {
                        byteArray = value;
                    }


                    _readWriter.writeLongString(data, byteArray);
                    break;
            }
        }

    }
}
}
