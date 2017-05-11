import oracle.kv.*;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;
import java.util.Scanner;

/**
 * Created by nwd3 on 5/9/2017.
 * GetMovieActors - Get the actors if any, who are cast in a given movie. Sample execution:

 Movie ID: 92616
 427460	George C. Scott	Gen. 'Buck' Turgidson
 429719	Peter Sellers	Dr. Strangelove
 429719	Peter Sellers	Group Capt. Lionel Mandrake
 429719	Peter Sellers	President Merkin Muffley
 Note this works
 @author Nathanael Dick
  * @version Spring, 2017
 */
public class GetMovieActors {
    public static void main(String[] args) throws SQLException {
        //user program
        Scanner de = new Scanner(System.in);
        System.out.println("please enter the movie id\n");
        String getMovieId=de.nextLine();

        KVStore store3 = KVStoreFactory.getStore( new KVStoreConfig("kvstore", "localhost:5000"));

    //big help here from http://www.uow.edu.au/~jrg/235/HOMEWORK/e11-2-A7-frame.html
        System.out.println("Movie ID: "+getMovieId);
    Key majorKeyPathOnly333 = Key.createKey(Arrays.asList("role","movieID",getMovieId));

    Map<Key, ValueVersion> roleFields = store3.multiGet(majorKeyPathOnly333, null, null);
        for (Map.Entry<Key, ValueVersion> roleFieldsIterator : roleFields.entrySet()) {
            //after I get the movie values now I can get the actor values this works well
            Key majorKeyPathOnly33348 = Key.createKey(Arrays.asList("actor",roleFieldsIterator.getKey().getMinorPath().get(1)));
            Map<Key, ValueVersion> actorFields = store3.multiGet(majorKeyPathOnly33348, null, null);
            for (Map.Entry<Key, ValueVersion> actorFieldsIterator : actorFields.entrySet()) {

                System.out.println("\t\t" +actorFieldsIterator.getKey().getMajorPath().get(1)+" "+actorFieldsIterator.getKey().getMinorPath().get(1)+" "
                        +actorFieldsIterator.getKey().getMinorPath().get(3)+" "
                +roleFieldsIterator.getKey().getMinorPath().get(3));
            }
    }
    }
}
