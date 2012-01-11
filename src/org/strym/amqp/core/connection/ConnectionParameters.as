/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 2:12 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.connection {
import org.strym.amqp.core.protocol.IProtocol;
import org.strym.amqp.core.protocol.Protocol;
import org.strym.amqp.core.protocol.v091.Protocol091;

public class ConnectionParameters {
    private var _protocol:IProtocol = Protocol.getProtocol(Protocol.VERSION_0_9_1);

    static public const DEFAULT_PORT:int = 5672;

    private var _username:String;
    private var _password:String;

    private var _host:String;
    private var _port:int = DEFAULT_PORT;


    public function get protocol():IProtocol {
        return _protocol;
    }

    public function set protocol(value:IProtocol):void {
        _protocol = value;
    }

    public function get username():String {
        return _username;
    }

    public function set username(value:String):void {
        _username = value;
    }

    public function get password():String {
        return _password;
    }

    public function set password(value:String):void {
        _password = value;
    }

    public function get host():String {
        return _host;
    }

    public function set host(value:String):void {
        _host = value;
    }

    public function get port():int {
        return _port;
    }

    public function set port(value:int):void {
        _port = value;
    }
}
}
