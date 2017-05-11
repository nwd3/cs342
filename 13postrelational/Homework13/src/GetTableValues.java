

import oracle.kv.Key;
import oracle.kv.ValueVersion;

import java.util.Arrays;
import java.util.Map;

import oracle.kv.*;
import java.sql.SQLException;
import java.util.*;
/**
 * Created by nwd3 on 5/9/2017.
 * This GetTableValues - Get the basic field values from the Movie table. The output should look something like this.

 Table: movie
 ID: 92616
 Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb
 1964
 8.7
 Note this works
 *  @author Nathanael Dick
 * @version Spring, 2017
 */
public class GetTableValues {

    public static void main(String[] args) throws SQLException {
        Scanner d = new Scanner(System.in);
        System.out.println("please enter the table name\n");
        String getTable=d.nextLine();
        System.out.println("please enter the movie id\n");
        String getMovieId=d.nextLine();
        KVStore store3 = KVStoreFactory.getStore( new KVStoreConfig("kvstore", "localhost:5000"));
        try {
            Key majorKeyPathOnly888888 = Key.createKey(Arrays.asList(getTable, getMovieId));
            Map<Key, ValueVersion> fields = store3.multiGet(majorKeyPathOnly888888, null, null);
            for (Map.Entry<Key, ValueVersion> field455 : fields.entrySet()) {
            //here I set up my variables
                String mfieldName = field455.getKey().getMajorPath().get(0);
                String mfieldName2 = field455.getKey().getMajorPath().get(1);
                String fieldName = field455.getKey().getMinorPath().get(0);
                String fieldValue = new String(field455.getValue().getValue().getValue());

                //here I print everything out
                        System.out.println("Table:\t"+getTable);
                System.out.println("ID: " + mfieldName2);
                System.out.println("\t\t" + field455.getKey().getMinorPath().get(1));
                System.out.println("\t\t" + field455.getKey().getMinorPath().get(3));
                System.out.println("\t\t" + field455.getKey().getMinorPath().get(5));
            }
        }  catch(Exception e) {
            System.err.print(e);
        }
    }
}
