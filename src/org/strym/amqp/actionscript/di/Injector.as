/**
 * Created by IntelliJ IDEA.
 * User: mexxik
 * Date: 1/8/12
 * Time: 3:22 PM
 * To change this template use File | Settings | File Templates.
 */
package org.strym.amqp.actionscript.di {
import org.as3commons.collections.Map;

public class Injector {
    static private var _objects:Map = new Map();
    
    static public function addObject(name:String, object:*):void {
        _objects.add(name, object);
    }

    static public function getObject(name:String):* {
        return _objects.itemFor(name);
    }
}
}
