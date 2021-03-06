/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/27/11
 * Time: 5:14 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.protocol.v091.definition {
import flash.utils.ByteArray;
import flash.utils.IDataOutput;

import org.as3commons.collections.framework.IIterator;
import org.strym.amqp.core.di.Injector;
import org.strym.amqp.core.protocol.definition.IMethodField;

import org.strym.amqp.core.protocol.definition.ProtocolMethod;

public class ProtocolMethod091 extends ProtocolMethod {
    public function ProtocolMethod091() {
        _readWriter = Injector.getObject("domainReadWriter091");
    }

    override public function write(data:IDataOutput):void {
        super.write(data);

        data.writeShort(_protocolClass.id);
        data.writeShort(id);

        var arguments:ByteArray = new ByteArray();

        var iterator:IIterator = _fields.iterator();
        while (iterator.hasNext()) {
            var field:IMethodField = iterator.next() as IMethodField;

            field.write(arguments);
        }

        _readWriter.flush(arguments);

        //data.writeUnsignedInt(arguments.length);
        data.writeBytes(arguments);
    }
}
}
