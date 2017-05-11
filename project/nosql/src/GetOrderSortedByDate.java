import oracle.kv.*;

import java.sql.SQLException;
import java.util.Iterator;
import java.util.Map;

/**
 * Created by nwd3 on 5/11/2017.
 * This is a very useful method it gets all the orders the employee assigned, the customer number, and the order number
 * all sorted out by date.  Useful when listing what each employee needs to do by the date
 * @author Nathanael Dick
 * @version Spring, 2017
 */
public class GetOrderSortedByDate {
    public static void main(String[] args) throws SQLException {
        KVStore store4 = KVStoreFactory.getStore( new KVStoreConfig("kvstore", "localhost:5000"));
        //create the key to match the sorted Orders structure
        Key matchKey = Key.createKey("sortedOrders");
        KeyRange subRange = null;

        //map the key and then loop over everything printing out the necessary information
        Map<Key, ValueVersion> fields2 = store4.multiGet(matchKey, null,null);
        for (Map.Entry<Key, ValueVersion> field2 : fields2.entrySet()) {
            System.out.println(field2.getKey().getMinorPath().get(0)+"\t"+field2.getKey().getMinorPath().get(1)+
                    "\t"+field2.getKey().getMinorPath().get(2)+"\t"+field2.getKey().getMinorPath().get(3)+"\t"+field2.getKey().getMinorPath().get(4)
                    +"\t"+field2.getKey().getMinorPath().get(5)+"\t"+field2.getKey().getMinorPath().get(6));
        }
    }
}
