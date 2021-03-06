import oracle.kv.*;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.Map;

/*
*Notes for project see class doc before class definition
*Evaluation of whether or not Oracles's KVLite key-value system is the best type of noSql database for my proj app:
* Without looking into other nosql technologies I believe a keybased approach is a good way to implement the dndb database in sql.  I 
*found it easy to map the current sql tables to the nosql key valued system quite intuitive.  Further for the things I might plan
*on doing for the database like simple joins and sorting the tables orcales nosql system provides all I need to implement
*a useful nosql database.
*
*Why information they provide is appropriate for a noSQL solution:
*    The information is appropriate because it efficiently maps to keys that can be sorted by their value.  The information shows the usefulness
*  of keys and how keys can be sorted by their values.
* This is a very useful method it gets all the orders the employee assigned, the customer number, and the order number
* all sorted out by date.  Useful when listing what each employee needs to do by the date
***************************************************************************************************/

/**
 *Class: GetOrderSortedByDate
 * Prints out the orders by the order date.  This is useful for helping sorting out orders by their
 * date which can help sort the orders.
 **Reference:http://www.oracle.com/technetwork/articles/bigdata/oracle-nosqldb-appdev-1891870.html
https://commons.apache.org/proper/commons-collections/apidocs/org/apache/commons/collections4/map/MultiKeyMap.html
other reference I can't find the link but heavily used
 * @author Nathanael Dick
 * @version Spring, 2017
 ************************************************************************************************/
public class GetOrderSortedByDate {
    public static void main(String[] args) throws SQLException {
     
     //connects to the store 
        KVStore store4 = KVStoreFactory.getStore( new KVStoreConfig("kvstore", "localhost:5000"));
        
     //create the key to match the sorted Orders structure
        Key matchKey = Key.createKey("sortedOrders");
        KeyRange subRange = null;

        //map the key and then loop over everything printing out the necessary information
        Map<Key, ValueVersion> fields2 = store4.multiGet(matchKey, null,null);
        for (Map.Entry<Key, ValueVersion> field2 : fields2.entrySet()) {
         //print out the important information
            System.out.println(field2.getKey().getMinorPath().get(0)+"\t"+field2.getKey().getMinorPath().get(1)+
                    "\t"+field2.getKey().getMinorPath().get(2)+"\t"+field2.getKey().getMinorPath().get(3)+"\t"+field2.getKey().getMinorPath().get(4)
                    +"\t"+field2.getKey().getMinorPath().get(5)+"\t"+field2.getKey().getMinorPath().get(6));
        }
    }
}
