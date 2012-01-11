/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 2:30 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.connection {
public interface IConnectionFactory {
    function get connection():IConnection;
}
}
