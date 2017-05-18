import jdk.internal.org.objectweb.asm.tree.analysis.Value;
import oracle.kv.*;
import java.sql.*;
import java.util.*;
import static jdk.internal.org.objectweb.asm.tree.analysis.Value.*;

/*
*Notes here added doc before class
*Evaluation of whether or not Oracles's KVLite key-value system is the best type of noSql database for my proj app:
* Without looking into other nosql technologies I believe a keybased approach is a good way to implement the dndb database in sql.  I 
* found it easy to map the current sql tables to the nosql key valued system quite intuitive.  Further for the things I might plan
* on doing for the database like simple joins and sorting the tables orcales nosql system provides all I need to implement
* a useful nosql database.
*
*Explanation of your use of noSQL:
* I used noSql to be able to create keys to sort the orders and to join a table.  This noSQL implemenation allows me to create some simple 
* methods to use in noSQL.
*************************************************************************************************/


 /**
 * This program used JDBC to query all the orders, and employees from the DNDB orders and employees tables.
 * I included ojdbc6.jar (from the J2EE library) in the system path to support the JDBC functions.
 *
 *These are my key structures which I create:
 * employeeKey:
 *   /employee/$employeeid -/firstname,$firstname/lastname : $lastname
 * OrderKey:
 *   /orders/$order_num/ -/empnum/$empnum/custnum/$custnum/exShipDate:  $expectedShipdate
 * SortedKey:
 *   /sortedOrders/ -/$expectedShipdate/empnum/$employeenumber/custnum/$custnumber/ordernum  : $ordernumber
 *
 *
 * @author Nathanael Dick
 * @version Spring, 2017
 ************************************************************************************************/
public class LoadDB {
  
    public static void main(String[] args) throws SQLException {

        KVStore store4 = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        Key SortedKey = null;
        Key employeeKey=null;
        Key OrderKey = null;
//connection made
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "dndb", "gh");
        Statement jdbcStatement = jdbcConnection.createStatement();
        Statement jdbcStatement2 = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT employee_number, firstname, lastname FROM employees");
        ResultSet resultSet2 = jdbcStatement2.executeQuery("SELECT order_num, employee_number,cust_num,exp_ship_date, act_ship_date,quantity, total_order_value FROM orders");

//this loads the keys from the employee table
        while (resultSet.next()) {

            //loads the values
            int idR= resultSet.getInt(1);
            String idRe =Integer.toString(idR);
            String get;
            String id = "id", valueString = idRe;
            String name = "firstname", firstNameString = resultSet.getString(2);
            String year = "lastname", lastnameString = resultSet.getString(3);

//create the employee key
        //  /employee/$employeeid -/firstname,$firstname/lastname : $lastname
            employeeKey = Key.createKey(Arrays.asList("employee",valueString),Arrays.asList("firstname",firstNameString,"lastname",lastnameString));

            // create the values for the key
            oracle.kv.Value value2 = oracle.kv.Value.createValue(valueString.getBytes());
            store4.put(employeeKey,value2);

            oracle.kv.Value value3 = oracle.kv.Value.createValue(firstNameString.getBytes());
            store4.put(employeeKey,value3);

            oracle.kv.Value value4 = oracle.kv.Value.createValue(lastnameString.getBytes());
            store4.put(employeeKey,value4);
        }

        //this loads the keys from the order table
        while (resultSet2.next()) {

            //reads the values in
            int idR= resultSet2.getInt(1);
            String idRe =Integer.toString(idR);
            int idR2= resultSet2.getInt(2);
            String idRe2 =Integer.toString(idR2);
            int idR3= resultSet2.getInt(3);
            String idRe3 =Integer.toString(idR3);
            String id = "onum", valueString = idRe;
            String id2 = "empnum", valueString2 = idRe2;
            String id3 = "custnum", custnum = idRe3;
            String name = "exShipDate", exShipDate = resultSet2.getString(4);

//creates the key
         //key structure: /orders/$order_num/ -/empnum/$empnum/custnum/$custnum/exShipDate:  $expectedShipdate
            OrderKey = Key.createKey(Arrays.asList("orders",valueString),Arrays.asList("empnum",valueString2,"custnum",custnum,"exShipDate",exShipDate));
                                           
// /sorted key access orders by date see getordersortedbydate.java for implementation usage;
         //key structure: /sortedOrders/ -/$expectedShipdate/empnum/$employeenumber/custnum/$custnumber/ordernum  : $ordernumber
            SortedKey = Key.createKey(Arrays.asList("sortedOrders"),Arrays.asList(exShipDate,"empnum",valueString2,"custnum",custnum,"ordernum",valueString));
  
                                                 
            //   put the key values
            oracle.kv.Value value9 = oracle.kv.Value.createValue(custnum.getBytes());
            store4.put(SortedKey,value9);
            store4.put(OrderKey,value9);
            oracle.kv.Value value2 = oracle.kv.Value.createValue(valueString.getBytes());
            store4.put(SortedKey,value2);
            store4.put(OrderKey,value2);
            oracle.kv.Value value8 = oracle.kv.Value.createValue(valueString2.getBytes());
            store4.put(SortedKey,value8);
            store4.put(OrderKey,value8);
            oracle.kv.Value value3 = oracle.kv.Value.createValue(exShipDate.getBytes());
            store4.put(SortedKey,value3);
            store4.put(OrderKey,value3);
        }
//close everything
        resultSet2.close();
        resultSet.close();
        jdbcStatement.close();
        jdbcStatement2.close();
        jdbcConnection.close();
    }

}
