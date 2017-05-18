import oracle.kv.*;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;
import java.util.Scanner;

/*
*Evaluation of whether or not Oracles's KVLite key-value system is the best type of noSql database for my proj app:
* Without looking into other nosql technologies I believe a keybased approach is a good way to implement the dndb database in sql.  I 
* found it easy to map the current sql tables to the nosql key valued system quite intuitive.  Further for the things I might plan
* on doing for the database like simple joins and sorting the tables orcales nosql system provides all I need to implement
* a useful nosql database.
*
*Why information they provide is appropriate for a noSQL solution:
*This information uses the power of nosql's keys to join two tables together.  
* This allows the user to input an order number and it joins the employee table to get the first and last names so that
* You can see the order information Very useful if you forgot what employee number correspons to a given id and just to get
* useful information about an order
******************************************************************************/

/**
* This class runs a method that takes user input and gets valuable information about the employee
* like their name and the order number and displays that information.
*Reference:http://www.oracle.com/technetwork/articles/bigdata/oracle-nosqldb-appdev-1891870.html
https://commons.apache.org/proper/commons-collections/apidocs/org/apache/commons/collections4/map/MultiKeyMap.html
other reference I can't find the link but heavily used
* @author Nathanael Dick
* @version Spring, 2017
******************************************************************************/
public class JoinEmployeesAndOrders {
    public static void main(String[] args) throws SQLException {
        //user program
        Scanner de = new Scanner(System.in);
        System.out.println("please enter the orderNumber\n");
        String getOrderNumber=de.nextLine();
     
      //create the connection to the store
        KVStore store4 = KVStoreFactory.getStore( new KVStoreConfig("kvstore", "localhost:5000"));

     //big help here from http://www.uow.edu.au/~jrg/235/HOMEWORK/e11-2-A7-frame.html
     //print the ordernumber
        System.out.println("OrderNumber: "+getOrderNumber);
     
     //create the keys to access the orders key
        Key majorKeyPathOnly333 = Key.createKey(Arrays.asList("orders",getOrderNumber));
        Map<Key, ValueVersion> orderFields = store4.multiGet(majorKeyPathOnly333, null, null);
     
     //for loop iterates over the keys
        for (Map.Entry<Key, ValueVersion> orderFieldsIterator : orderFields.entrySet()) {
         
         //after I get the empnumber values now I can get the employee values this works well to be able to get the firstname and lastname of the meployees
            Key majorKeyPathOnly33348 = Key.createKey(Arrays.asList("employee",orderFieldsIterator.getKey().getMinorPath().get(1)));
            Map<Key, ValueVersion> actorFields = store4.multiGet(majorKeyPathOnly33348, null, null);
            //for loop drives the join values to be displayed
         for (Map.Entry<Key, ValueVersion> employeeFields : actorFields.entrySet()) {
                System.out.println("\t\t"+"Order Information "+ orderFieldsIterator.getKey().getMajorPath().get(1)+" employeeInformation: "+orderFieldsIterator.getKey().getMinorPath().get(1)+" "+employeeFields.getKey().getMinorPath().get(1)+" "+employeeFields.getKey().getMinorPath().get(3));
            }
        }
    }
}
