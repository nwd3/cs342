import oracle.kv.*;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;
import java.util.Scanner;

/**
*Evaluation of whether or not Oracles's KVLite key-value system is the best type of noSql database for my proj app:
 Without looking into other nosql technologies I believe a keybased approach is a good way to implement the dndb database in sql.  I 
 found it easy to map the current sql tables to the nosql key valued system quite intuitive.  Further for the things I might plan
 on doing for the database like simple joins and sorting the tables orcales nosql system provides all I need to implement
 a useful nosql database.
 * Created by nwd3 on 5/11/2017.
 Why information they provide is appropriate for a noSQL solution:
 This information uses the power of nosql's keys to join two tables together.  
 * This allows the user to input an order number and it joins the employee table to get the first and last names so that
 * You can see the order information Very useful if you forgot what employee number correspons to a given id and just to get
 * useful information about an order
 * @author Nathanael Dick
 * @version Spring, 2017
 */
public class JoinEmployeesAndOrders {
    public static void main(String[] args) throws SQLException {
        //user program
        Scanner de = new Scanner(System.in);
        System.out.println("please enter the orderNumber\n");
        String getOrderNumber=de.nextLine();

        KVStore store4 = KVStoreFactory.getStore( new KVStoreConfig("kvstore", "localhost:5000"));

        //big help here from http://www.uow.edu.au/~jrg/235/HOMEWORK/e11-2-A7-frame.html
        System.out.println("OrderNumber: "+getOrderNumber);
        Key majorKeyPathOnly333 = Key.createKey(Arrays.asList("orders",getOrderNumber));

        Map<Key, ValueVersion> roleFields = store4.multiGet(majorKeyPathOnly333, null, null);
        for (Map.Entry<Key, ValueVersion> roleFieldsIterator : roleFields.entrySet()) {
            //after I get the empnumber values now I can get the employee values this works well to be able to get the firstname and lastname of the meployees
            Key majorKeyPathOnly33348 = Key.createKey(Arrays.asList("employee",roleFieldsIterator.getKey().getMinorPath().get(1)));
            Map<Key, ValueVersion> actorFields = store4.multiGet(majorKeyPathOnly33348, null, null);
            for (Map.Entry<Key, ValueVersion> actorFieldsIterator : actorFields.entrySet()) {
                System.out.println("\t\t"+"Order Information "+ roleFieldsIterator.getKey().getMajorPath().get(1)+" employeeInformation: "+roleFieldsIterator.getKey().getMinorPath().get(1)+" "+actorFieldsIterator.getKey().getMinorPath().get(1)+" "+actorFieldsIterator.getKey().getMinorPath().get(3));
            }
        }
    }
}
