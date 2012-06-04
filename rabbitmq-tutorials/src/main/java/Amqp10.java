import com.swiftmq.amqp.AMQPContext;
import com.swiftmq.amqp.v100.client.AuthenticationException;
import com.swiftmq.amqp.v100.client.Connection;
import com.swiftmq.amqp.v100.client.ConnectionClosedException;
import com.swiftmq.amqp.v100.client.UnsupportedProtocolVersionException;

import java.io.IOException;

/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 2/6/12
 * Time: 2:12 PM
 * To change this template use File | Settings | File Templates.
 */
public class Amqp10 {
    public static void main(String[] args) {
        AMQPContext context = new AMQPContext(AMQPContext.CLIENT);

        Connection connection = new Connection(context, "localhost", 5672, false);
        try {
            connection.connect();
        } catch (IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        } catch (UnsupportedProtocolVersionException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        } catch (AuthenticationException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        } catch (ConnectionClosedException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
    }
}
