import jdk.internal.org.objectweb.asm.tree.analysis.Value;

import oracle.kv.*;

import java.sql.*;
import java.util.*;

import static jdk.internal.org.objectweb.asm.tree.analysis.Value.*;

/**
 * This program used JDBC to query all the movies, actor, and role from the IMDB Movies tables.
 * Include ojdbc6.jar (from the J2EE library) in the system path to support the JDBC functions.
 * Note this program succesfully loads all the required tables
 *
 * @author Nathanael Dick
 * @version Spring, 2017
 */
public class LoadDB {
//public KVStore store3;
    public static void main(String[] args) throws SQLException {

    KVStore store3 = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        Key key = null;
        Key RoleKey = null;
        Key key2223 = null;
        Key keySort = null;
        Key keyActorIdJoin=null;
        Key keyRoleIdJoin=null;
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");
        Statement jdbcStatement = jdbcConnection.createStatement();
        Statement jdbcStatement2 = jdbcConnection.createStatement();
        Statement jdbcStatement3 = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, name, year, rank, year FROM Movie");
        ResultSet resultSet3 = jdbcStatement2.executeQuery("SELECT actorId, movieId, role FROM Role");
        ResultSet resultSet4 = jdbcStatement3.executeQuery("SELECT id, firstname, lastname FROM Actor");

        while (resultSet.next()) {
            int idR= resultSet.getInt(1);
            String idRe =Integer.toString(idR);
            String get;
            String id = "id", valueString = idRe;
            String name = "name", valueString2 = resultSet.getString(2);
            String year = "year", yearString = resultSet.getString(3);
            if(resultSet.getString(4)!=null) {
                get=resultSet.getString(4);
            }else{
                get="";
            }
            String rating = "rating", valueString4 = get;

            //normal movie table
            key = Key.createKey(Arrays.asList("movie",valueString),Arrays.asList("name",valueString2,"year",yearString,"rating",valueString4));

          //yearString for sorted table
            keySort =Key.createKey(Arrays.asList("SortedMovies"), Arrays.asList(yearString,valueString,valueString2));


            //   Here I put all the key values
            oracle.kv.Value value2 = oracle.kv.Value.createValue(valueString.getBytes());
            store3.put(key,value2);
            oracle.kv.Value value3 = oracle.kv.Value.createValue(valueString2.getBytes());
            store3.put(key,value3);
            oracle.kv.Value value4 = oracle.kv.Value.createValue(yearString.getBytes());
            store3.put(key,value4);
            store3.put(keySort,value4);
            oracle.kv.Value value5 = oracle.kv.Value.createValue(valueString4.getBytes());
            store3.put(key,value5);
            store3.put(keySort,value5);
        }
        while (resultSet3.next()) {

            int idR= resultSet3.getInt(1);
            String idRe =Integer.toString(idR);
            String get;
            int movieIdr=resultSet3.getInt(2);
            String movieIdR=Integer.toString(movieIdr);
            String actorId = "actorId", actorIdstring = idRe;
            String movieId = "movieId", movieIdString = movieIdR;
            String role = "role", roleString = resultSet3.getString(3);

            //here I set up my role key
            RoleKey = Key.createKey(Arrays.asList("role","movieID",movieIdString),Arrays.asList("actorId",actorIdstring,"role",roleString));

//here i put the values
            oracle.kv.Value value2 = oracle.kv.Value.createValue(actorIdstring.getBytes());
            store3.put(RoleKey,value2);
            oracle.kv.Value value3 = oracle.kv.Value.createValue(movieIdString.getBytes());
            store3.put(RoleKey,value3);
            oracle.kv.Value value4 = oracle.kv.Value.createValue(roleString.getBytes());
            store3.put(RoleKey,value4);
        }
        while (resultSet4.next()) {
//here I set up my keys from sql input
            int idR= resultSet4.getInt(1);
            String idRe =Integer.toString(idR);
            String get;
            String actorId = "id", actorIdString = idRe;
            String firstname = "firstname", valueString2 = resultSet4.getString(2);
            String lastname = "lastname", valueString3 = resultSet4.getString(3);

            //here I create the key and the actor join key
            key2223 = Key.createKey(Arrays.asList("actor",actorIdString),Arrays.asList("firstname",valueString2,"lastname",valueString3));
           //i never actually used the key below
            keyActorIdJoin = Key.createKey(Arrays.asList("actorJoin",idRe),Arrays.asList("firstname",valueString2,"lastname",valueString3));

            //here I put my values
            oracle.kv.Value value2 = oracle.kv.Value.createValue(actorIdString.getBytes());
            store3.put(key2223,value2);
            store3.put(keyActorIdJoin,value2);
            oracle.kv.Value value3 = oracle.kv.Value.createValue(valueString2.getBytes());
            store3.put(key2223,value3);
            store3.put(keyActorIdJoin,value3);
            oracle.kv.Value value4 = oracle.kv.Value.createValue(valueString3.getBytes());
            store3.put(key2223,value4);
            store3.put(keyActorIdJoin,value4);

        }


        resultSet.close();
        resultSet3.close();
        resultSet4.close();
        jdbcStatement.close();
        jdbcStatement2.close();
        jdbcStatement3.close();
        jdbcConnection.close();
    }

}
