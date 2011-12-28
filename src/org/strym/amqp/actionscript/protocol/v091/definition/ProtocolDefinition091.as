/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/27/11
 * Time: 4:09 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.protocol.v091.definition {
import flash.utils.ByteArray;

import org.as3commons.collections.Map;
import org.strym.amqp.actionscript.protocol.definition.IProtocolClass;
import org.strym.amqp.actionscript.protocol.definition.ProtocolClass;

import org.strym.amqp.actionscript.protocol.definition.ProtocolDefinition;

public class ProtocolDefinition091 extends ProtocolDefinition {
    [Embed(source="amqp-0.9.1.xml", mimeType="application/octet-stream")]
    private var _xmlData:Class;

    public function ProtocolDefinition091() {
        var byteArray:ByteArray = new _xmlData();
        var xml:XML = new XML(byteArray.readUTFBytes(byteArray.length));

        for each (var classXML:XML in xml["class"]) {
            var protocolClass:ProtocolClass091 = new ProtocolClass091();
            protocolClass.id = classXML.@index;

            for each (var methodXML:XML in classXML.method) {
                var protocolMethod:ProtocolMethod091 = new ProtocolMethod091();
                protocolMethod.id = methodXML.@index;
                protocolMethod.name = methodXML.@name;

                protocolClass.methods.add(protocolMethod.id, protocolMethod);
            }

            _classes.add(protocolClass.id, protocolClass);
        }
    }
}
}
