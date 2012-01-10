/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/10/12
 * Time: 8:17 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.domain {
public class Message {

    private var _body:*;

    public function Message() {
    }

    public function get body():* {
        return _body;
    }

    public function set body(value:*):void {
        _body = value;
    }
}
}
