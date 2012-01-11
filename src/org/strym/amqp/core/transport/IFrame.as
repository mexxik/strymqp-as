/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/6/12
 * Time: 2:53 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.transport {
import flash.utils.ByteArray;
import flash.utils.IDataOutput;

import org.strym.amqp.core.io.IReadWritable;
import org.strym.amqp.core.protocol.definition.IDomainReaderWriter;

// TODO: are setters really required here?
public interface IFrame extends IReadWritable {
    function get isComplete():Boolean;

    function get isHeaderComplete():Boolean;

    function get type():uint;

    function get channel():int;

    function get payloadSize():int;

    function get payload():ByteArray;
}
}
