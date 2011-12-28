/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 2:13 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.io {
import flash.net.Socket;

import org.strym.amqp.actionscript.connection.ConnectionParameters;

public class SocketDelegate extends Socket implements IODelegate {
    public function SocketDelegate() {
    }


    public function open(connectionParameters:ConnectionParameters):void {
        connect(connectionParameters.host, connectionParameters.port);
    }

    override public function get connected():Boolean {
        return super.connected;
    }

    override public function flush():void {
        super.flush();
    }

}
}
