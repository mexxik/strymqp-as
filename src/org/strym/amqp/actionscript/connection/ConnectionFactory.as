/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 12/26/11
 * Time: 2:32 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.connection {
import org.strym.amqp.actionscript.converters.StringConverter;
import org.strym.amqp.actionscript.protocol.Protocol;

public class ConnectionFactory implements IConnectionFactory {

    private var _connectionParameters:ConnectionParameters;

    private var _connection:IConnection = null;

    public function ConnectionFactory(connectionParameters:ConnectionParameters) {
        _connectionParameters = connectionParameters;
    }

    public function get connection():IConnection {
        if (!_connection) {
            if (_connectionParameters) {
                switch (_connectionParameters.protocol.version) {
                    case Protocol.VERSION_0_9_1:
                        _connection = new Connection(_connectionParameters);
                            _connection.messageConverter = new StringConverter();
                        break;
                }
            }
            else {
            }
        }

        return _connection;
    }
}
}
