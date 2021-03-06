/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/27/11
 * Time: 4:09 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.protocol.v091.definition {
import flash.utils.ByteArray;

import org.as3commons.collections.Map;
import org.strym.amqp.core.di.Injector;
import org.strym.amqp.core.protocol.definition.IProtocolClass;
import org.strym.amqp.core.protocol.definition.ProtocolClass;

import org.strym.amqp.core.protocol.definition.ProtocolDefinition;

public class ProtocolDefinition091 extends ProtocolDefinition {
    //[Embed(source="amqp-0.9.1.xml", mimeType="application/octet-stream")]
    //private var _xmlData:Class;

    public function ProtocolDefinition091() {
        Injector.addObject("domainReadWriter091", new DomainReadWriter091());

        //var byteArray:ByteArray = new _xmlData();
        var xml:XML = _xml; // new XML(byteArray.readUTFBytes(byteArray.length));

        for each (var domainXML:XML in xml.domain) {
            var protocolDomain:ProtocolDomain091 = new ProtocolDomain091();
            protocolDomain.name = domainXML.@name;
            protocolDomain.type = domainXML.@type;

            _domains.add(protocolDomain.name, protocolDomain);
        }

        for each (var classXML:XML in xml["class"]) {
            var protocolClass:ProtocolClass091 = new ProtocolClass091();
            protocolClass.id = classXML.@index;
            protocolClass.name = classXML.@name;

            for each (var methodXML:XML in classXML.method) {
                var protocolMethod:ProtocolMethod091 = new ProtocolMethod091();
                protocolMethod.id = methodXML.@index;
                protocolMethod.name = methodXML.@name;

                for each (var fieldXML:XML in methodXML.field) {
                    var methodField:MethodField091 = new MethodField091();
                    methodField.name = fieldXML.@name;
                    methodField.domain = _domains.itemFor(fieldXML.@domain.toString());

                    if (!methodField.domain)
                        methodField.domain = _domains.itemFor(fieldXML.@type.toString());

                    protocolMethod.addField(methodField);
                }

                protocolMethod.protocolClass = protocolClass;

                protocolClass.methods.add(protocolMethod.id, protocolMethod);
            }

            _classes.add(protocolClass.id, protocolClass);
        }
    }

    private var _xml:XML =
                    <amqp major="0" minor="9" revision="1" port="5672">
                        <constant name="frame-method" value="1"/>
                        <constant name="frame-header" value="2"/>
                        <constant name="frame-body" value="3"/>
                        <constant name="frame-heartbeat" value="8"/>
                        <constant name="frame-min-size" value="4096"/>
                        <constant name="frame-end" value="206"/>
                        <constant name="reply-success" value="200"/>
                        <constant name="content-too-large" value="311" class="soft-error"/>
                        <constant name="no-consumers" value="313" class="soft-error"/>
                        <constant name="connection-forced" value="320" class="hard-error"/>
                        <constant name="invalid-path" value="402" class="hard-error"/>
                        <constant name="access-refused" value="403" class="soft-error"/>
                        <constant name="not-found" value="404" class="soft-error"/>
                        <constant name="resource-locked" value="405" class="soft-error"/>
                        <constant name="precondition-failed" value="406" class="soft-error"/>
                        <constant name="frame-error" value="501" class="hard-error"/>
                        <constant name="syntax-error" value="502" class="hard-error"/>
                        <constant name="command-invalid" value="503" class="hard-error"/>
                        <constant name="channel-error" value="504" class="hard-error"/>
                        <constant name="unexpected-frame" value="505" class="hard-error"/>
                        <constant name="resource-error" value="506" class="hard-error"/>
                        <constant name="not-allowed" value="530" class="hard-error"/>
                        <constant name="not-implemented" value="540" class="hard-error"/>
                        <constant name="internal-error" value="541" class="hard-error"/>
                        <domain name="class-id" type="short"/>
                        <domain name="consumer-tag" type="shortstr"/>
                        <domain name="delivery-tag" type="longlong"/>
                        <domain name="exchange-name" type="shortstr">
                            <assert check="length" value="127"/>
                            <assert check="regexp" value="^[a-zA-Z0-9-_.:]*$"/>
                        </domain>
                        <domain name="method-id" type="short"/>
                        <domain name="no-ack" type="bit"/>
                        <domain name="no-local" type="bit"/>
                        <domain name="no-wait" type="bit"/>
                        <domain name="path" type="shortstr">
                            <assert check="notnull"/>
                            <assert check="length" value="127"/>
                        </domain>
                        <domain name="peer-properties" type="table"/>
                        <domain name="queue-name" type="shortstr">
                            <assert check="length" value="127"/>
                            <assert check="regexp" value="^[a-zA-Z0-9-_.:]*$"/>
                        </domain>
                        <domain name="redelivered" type="bit"/>
                        <domain name="message-count" type="long"/>
                        <domain name="reply-code" type="short">
                            <assert check="notnull"/>
                        </domain>
                        <domain name="reply-text" type="shortstr">
                            <assert check="notnull"/>
                        </domain>
                        <domain name="bit" type="bit"/>
                        <domain name="octet" type="octet"/>
                        <domain name="short" type="short"/>
                        <domain name="long" type="long"/>
                        <domain name="longlong" type="longlong"/>
                        <domain name="shortstr" type="shortstr"/>
                        <domain name="longstr" type="longstr"/>
                        <domain name="timestamp" type="timestamp"/>
                        <domain name="table" type="table"/>
                        <class name="connection" handler="connection" index="10">
                            <chassis name="server" implement="MUST"/>
                            <chassis name="client" implement="MUST"/>
                            <method name="start" synchronous="1" index="10">
                                <chassis name="client" implement="MUST"/>
                                <response name="start-ok"/>
                                <field name="version-major" domain="octet"/>
                                <field name="version-minor" domain="octet"/>
                                <field name="server-properties" domain="peer-properties"/>
                                <field name="mechanisms" domain="longstr">
                                    <assert check="notnull"/>
                                </field>
                                <field name="locales" domain="longstr">
                                    <assert check="notnull"/>
                                </field>
                            </method>
                            <method name="start-ok" synchronous="1" index="11">
                                <chassis name="server" implement="MUST"/>
                                <field name="client-properties" domain="peer-properties"/>
                                <field name="mechanism" domain="shortstr">
                                    <assert check="notnull"/>
                                </field>
                                <field name="response" domain="longstr">
                                    <assert check="notnull"/>
                                </field>
                                <field name="locale" domain="shortstr">
                                    <assert check="notnull"/>
                                </field>
                            </method>
                            <method name="secure" synchronous="1" index="20">
                                <chassis name="client" implement="MUST"/>
                                <response name="secure-ok"/>
                                <field name="challenge" domain="longstr"/>
                            </method>
                            <method name="secure-ok" synchronous="1" index="21">
                                <chassis name="server" implement="MUST"/>
                                <field name="response" domain="longstr">
                                    <assert check="notnull"/>
                                </field>
                            </method>
                            <method name="tune" synchronous="1" index="30">
                                <chassis name="client" implement="MUST"/>
                                <response name="tune-ok"/>
                                <field name="channel-max" domain="short"/>
                                <field name="frame-max" domain="long"/>
                                <field name="heartbeat" domain="short"/>
                            </method>
                            <method name="tune-ok" synchronous="1" index="31">
                                <chassis name="server" implement="MUST"/>
                                <field name="channel-max" domain="short">
                                    <assert check="notnull"/>
                                    <assert check="le" method="tune" field="channel-max"/>
                                </field>
                                <field name="frame-max" domain="long"/>
                                <field name="heartbeat" domain="short"/>
                            </method>
                            <method name="open" synchronous="1" index="40">
                                <chassis name="server" implement="MUST"/>
                                <response name="open-ok"/>
                                <field name="virtual-host" domain="path"/>
                                <field name="reserved-1" type="shortstr" reserved="1"/>
                                <field name="reserved-2" type="bit" reserved="1"/>
                            </method>
                            <method name="open-ok" synchronous="1" index="41">
                                <chassis name="client" implement="MUST"/>
                                <field name="reserved-1" type="shortstr" reserved="1"/>
                            </method>
                            <method name="close" synchronous="1" index="50">
                                <chassis name="client" implement="MUST"/>
                                <chassis name="server" implement="MUST"/>
                                <response name="close-ok"/>
                                <field name="reply-code" domain="reply-code"/>
                                <field name="reply-text" domain="reply-text"/>
                                <field name="class-id" domain="class-id"/>
                                <field name="method-id" domain="method-id"/>
                            </method>
                            <method name="close-ok" synchronous="1" index="51">
                                <chassis name="client" implement="MUST"/>
                                <chassis name="server" implement="MUST"/>
                            </method>
                        </class>
                        <class name="channel" handler="channel" index="20">
                            <chassis name="server" implement="MUST"/>
                            <chassis name="client" implement="MUST"/>
                            <method name="open" synchronous="1" index="10">
                                <chassis name="server" implement="MUST"/>
                                <response name="open-ok"/>
                                <field name="reserved-1" type="shortstr" reserved="1"/>
                            </method>
                            <method name="open-ok" synchronous="1" index="11">
                                <chassis name="client" implement="MUST"/>
                                <field name="reserved-1" type="longstr" reserved="1"/>
                            </method>
                            <method name="flow" synchronous="1" index="20">
                                <chassis name="server" implement="MUST"/>
                                <chassis name="client" implement="MUST"/>
                                <response name="flow-ok"/>
                                <field name="active" domain="bit"/>
                            </method>
                            <method name="flow-ok" index="21">
                                <chassis name="server" implement="MUST"/>
                                <chassis name="client" implement="MUST"/>
                                <field name="active" domain="bit"/>
                            </method>
                            <method name="close" synchronous="1" index="40">
                                <chassis name="client" implement="MUST"/>
                                <chassis name="server" implement="MUST"/>
                                <response name="close-ok"/>
                                <field name="reply-code" domain="reply-code"/>
                                <field name="reply-text" domain="reply-text"/>
                                <field name="class-id" domain="class-id"/>
                                <field name="method-id" domain="method-id"/>
                            </method>
                            <method name="close-ok" synchronous="1" index="41">
                                <chassis name="client" implement="MUST"/>
                                <chassis name="server" implement="MUST"/>
                            </method>
                        </class>
                        <class name="exchange" handler="channel" index="40">
                            <chassis name="server" implement="MUST"/>
                            <chassis name="client" implement="MUST"/>
                            <method name="declare" synchronous="1" index="10">
                                <chassis name="server" implement="MUST"/>
                                <response name="declare-ok"/>
                                <field name="reserved-1" type="short" reserved="1"/>
                                <field name="exchange" domain="exchange-name">
                                    <assert check="notnull"/>
                                </field>
                                <field name="type" domain="shortstr"/>
                                <field name="passive" domain="bit"/>
                                <field name="durable" domain="bit"/>
                                <field name="reserved-2" type="bit" reserved="1"/>
                                <field name="reserved-3" type="bit" reserved="1"/>
                                <field name="no-wait" domain="no-wait"/>
                                <field name="arguments" domain="table"/>
                            </method>
                            <method name="declare-ok" synchronous="1" index="11">
                                <chassis name="client" implement="MUST"/>
                            </method>
                            <method name="delete" synchronous="1" index="20">
                                <chassis name="server" implement="MUST"/>
                                <response name="delete-ok"/>
                                <field name="reserved-1" type="short" reserved="1"/>
                                <field name="exchange" domain="exchange-name">
                                    <assert check="notnull"/>
                                </field>
                                <field name="if-unused" domain="bit"/>
                                <field name="no-wait" domain="no-wait"/>
                            </method>
                            <method name="delete-ok" synchronous="1" index="21">
                                <chassis name="client" implement="MUST"/>
                            </method>
                        </class>
                        <class name="queue" handler="channel" index="50">
                            <chassis name="server" implement="MUST"/>
                            <chassis name="client" implement="MUST"/>
                            <method name="declare" synchronous="1" index="10">
                                <chassis name="server" implement="MUST"/>
                                <response name="declare-ok"/>
                                <field name="reserved-1" type="short" reserved="1"/>
                                <field name="queue" domain="queue-name"/>
                                <field name="passive" domain="bit"/>
                                <field name="durable" domain="bit"/>
                                <field name="exclusive" domain="bit"/>
                                <field name="auto-delete" domain="bit"/>
                                <field name="no-wait" domain="no-wait"/>
                                <field name="arguments" domain="table"/>
                            </method>
                            <method name="declare-ok" synchronous="1" index="11">
                                <chassis name="client" implement="MUST"/>
                                <field name="queue" domain="queue-name">
                                    <assert check="notnull"/>
                                </field>
                                <field name="message-count" domain="message-count"/>
                                <field name="consumer-count" domain="long"/>
                            </method>
                            <method name="bind" synchronous="1" index="20">
                                <chassis name="server" implement="MUST"/>
                                <response name="bind-ok"/>
                                <field name="reserved-1" type="short" reserved="1"/>
                                <field name="queue" domain="queue-name"/>
                                <field name="exchange" domain="exchange-name"/>
                                <field name="routing-key" domain="shortstr"/>
                                <field name="no-wait" domain="no-wait"/>
                                <field name="arguments" domain="table"/>
                            </method>
                            <method name="bind-ok" synchronous="1" index="21">
                                <chassis name="client" implement="MUST"/>
                            </method>
                            <method name="unbind" synchronous="1" index="50">
                                <chassis name="server" implement="MUST"/>
                                <response name="unbind-ok"/>
                                <field name="reserved-1" type="short" reserved="1"/>
                                <field name="queue" domain="queue-name"/>
                                <field name="exchange" domain="exchange-name"/>
                                <field name="routing-key" domain="shortstr"/>
                                <field name="arguments" domain="table"/>
                            </method>
                            <method name="unbind-ok" synchronous="1" index="51">
                                <chassis name="client" implement="MUST"/>
                            </method>
                            <method name="purge" synchronous="1" index="30">
                                <chassis name="server" implement="MUST"/>
                                <response name="purge-ok"/>
                                <field name="reserved-1" type="short" reserved="1"/>
                                <field name="queue" domain="queue-name"/>
                                <field name="no-wait" domain="no-wait"/>
                            </method>
                            <method name="purge-ok" synchronous="1" index="31">
                                <chassis name="client" implement="MUST"/>
                                <field name="message-count" domain="message-count"/>
                            </method>
                            <method name="delete" synchronous="1" index="40">
                                <chassis name="server" implement="MUST"/>
                                <response name="delete-ok"/>
                                <field name="reserved-1" type="short" reserved="1"/>
                                <field name="queue" domain="queue-name"/>
                                <field name="if-unused" domain="bit"/>
                                <field name="if-empty" domain="bit"/>
                                <field name="no-wait" domain="no-wait"/>
                            </method>
                            <method name="delete-ok" synchronous="1" index="41">
                                <chassis name="client" implement="MUST"/>
                                <field name="message-count" domain="message-count"/>
                            </method>
                        </class>
                        <class name="basic" handler="channel" index="60">
                            <chassis name="server" implement="MUST"/>
                            <chassis name="client" implement="MAY"/>
                            <field name="content-type" domain="shortstr"/>
                            <field name="content-encoding" domain="shortstr"/>
                            <field name="headers" domain="table"/>
                            <field name="delivery-mode" domain="octet"/>
                            <field name="priority" domain="octet"/>
                            <field name="correlation-id" domain="shortstr"/>
                            <field name="reply-to" domain="shortstr"/>
                            <field name="expiration" domain="shortstr"/>
                            <field name="message-id" domain="shortstr"/>
                            <field name="timestamp" domain="timestamp"/>
                            <field name="type" domain="shortstr"/>
                            <field name="user-id" domain="shortstr"/>
                            <field name="app-id" domain="shortstr"/>
                            <field name="reserved" domain="shortstr"/>
                            <method name="qos" synchronous="1" index="10">
                                <chassis name="server" implement="MUST"/>
                                <response name="qos-ok"/>
                                <field name="prefetch-size" domain="long"/>
                                <field name="prefetch-count" domain="short"/>
                                <field name="global" domain="bit"/>
                            </method>
                            <method name="qos-ok" synchronous="1" index="11">
                                <chassis name="client" implement="MUST"/>
                            </method>
                            <method name="consume" synchronous="1" index="20">
                                <chassis name="server" implement="MUST"/>
                                <response name="consume-ok"/>
                                <field name="reserved-1" type="short" reserved="1"/>
                                <field name="queue" domain="queue-name"/>
                                <field name="consumer-tag" domain="consumer-tag"/>
                                <field name="no-local" domain="no-local"/>
                                <field name="no-ack" domain="no-ack"/>
                                <field name="exclusive" domain="bit"/>
                                <field name="no-wait" domain="no-wait"/>
                                <field name="arguments" domain="table"/>
                            </method>
                            <method name="consume-ok" synchronous="1" index="21">
                                <chassis name="client" implement="MUST"/>
                                <field name="consumer-tag" domain="consumer-tag"/>
                            </method>
                            <method name="cancel" synchronous="1" index="30">
                                <chassis name="server" implement="MUST"/>
                                <response name="cancel-ok"/>
                                <field name="consumer-tag" domain="consumer-tag"/>
                                <field name="no-wait" domain="no-wait"/>
                            </method>
                            <method name="cancel-ok" synchronous="1" index="31">
                                <chassis name="client" implement="MUST"/>
                                <field name="consumer-tag" domain="consumer-tag"/>
                            </method>
                            <method name="publish" content="1" index="40">
                                <chassis name="server" implement="MUST"/>
                                <field name="reserved-1" type="short" reserved="1"/>
                                <field name="exchange" domain="exchange-name"/>
                                <field name="routing-key" domain="shortstr"/>
                                <field name="mandatory" domain="bit"/>
                                <field name="immediate" domain="bit"/>
                            </method>
                            <method name="return" content="1" index="50">
                                <chassis name="client" implement="MUST"/>
                                <field name="reply-code" domain="reply-code"/>
                                <field name="reply-text" domain="reply-text"/>
                                <field name="exchange" domain="exchange-name"/>
                                <field name="routing-key" domain="shortstr"/>
                            </method>
                            <method name="deliver" content="1" index="60">
                                <chassis name="client" implement="MUST"/>
                                <field name="consumer-tag" domain="consumer-tag"/>
                                <field name="delivery-tag" domain="delivery-tag"/>
                                <field name="redelivered" domain="redelivered"/>
                                <field name="exchange" domain="exchange-name"/>
                                <field name="routing-key" domain="shortstr"/>
                            </method>
                            <method name="get" synchronous="1" index="70">
                                <response name="get-ok"/>
                                <response name="get-empty"/>
                                <chassis name="server" implement="MUST"/>
                                <field name="reserved-1" type="short" reserved="1"/>
                                <field name="queue" domain="queue-name"/>
                                <field name="no-ack" domain="no-ack"/>
                            </method>
                            <method name="get-ok" synchronous="1" content="1" index="71">
                                <chassis name="client" implement="MAY"/>
                                <field name="delivery-tag" domain="delivery-tag"/>
                                <field name="redelivered" domain="redelivered"/>
                                <field name="exchange" domain="exchange-name"/>
                                <field name="routing-key" domain="shortstr"/>
                                <field name="message-count" domain="message-count"/>
                            </method>
                            <method name="get-empty" synchronous="1" index="72">
                                <chassis name="client" implement="MAY"/>
                                <field name="reserved-1" type="shortstr" reserved="1"/>
                            </method>
                            <method name="ack" index="80">
                                <chassis name="server" implement="MUST"/>
                                <field name="delivery-tag" domain="delivery-tag"/>
                                <field name="multiple" domain="bit"/>
                            </method>
                            <method name="reject" index="90">
                                <chassis name="server" implement="MUST"/>
                                <field name="delivery-tag" domain="delivery-tag"/>
                                <field name="requeue" domain="bit"/>
                            </method>
                            <method name="recover-async" index="100" deprecated="1">
                                <chassis name="server" implement="MAY"/>
                                <field name="requeue" domain="bit"/>
                            </method>
                            <method name="recover" index="110">
                                <chassis name="server" implement="MUST"/>
                                <field name="requeue" domain="bit"/>
                            </method>
                            <method name="recover-ok" synchronous="1" index="111">
                                <chassis name="client" implement="MUST"/>
                            </method>
                        </class>
                        <class name="tx" handler="channel" index="90">
                            <chassis name="server" implement="SHOULD"/>
                            <chassis name="client" implement="MAY"/>
                            <method name="select" synchronous="1" index="10">
                                <chassis name="server" implement="MUST"/>
                                <response name="select-ok"/>
                            </method>
                            <method name="select-ok" synchronous="1" index="11">
                                <chassis name="client" implement="MUST"/>
                            </method>
                            <method name="commit" synchronous="1" index="20">
                                <chassis name="server" implement="MUST"/>
                                <response name="commit-ok"/>
                            </method>
                            <method name="commit-ok" synchronous="1" index="21">
                                <chassis name="client" implement="MUST"/>
                            </method>
                            <method name="rollback" synchronous="1" index="30">
                                <chassis name="server" implement="MUST"/>
                                <response name="rollback-ok"/>
                            </method>
                            <method name="rollback-ok" synchronous="1" index="31">
                                <chassis name="client" implement="MUST"/>
                            </method>
                        </class>
                    </amqp>
            ;
}
}
