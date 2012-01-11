/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/3/12
 * Time: 5:15 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.core.utils {
import flash.utils.ByteArray;

public class DataUtils {
    static public function byteArrayToString(byteArray:ByteArray):String {
        return byteArray.readUTFBytes(byteArray.length);
    }
}
}
