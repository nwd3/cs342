import java.sql.SQLException;
import java.util.Scanner;

import oracle.kv.Key;
import oracle.kv.ValueVersion;

import java.util.Arrays;
import java.util.Map;

import oracle.kv.*;
import java.sql.SQLException;
import java.util.*;
/**
 * Created by nwd3 on 5/9/2017.
 * GetMovieActorRoles - Get the roles, if any, for which a given actor is cast in a give movie. Sample execution:

 Movie ID: 92616
 Actor ID: 429719
 Dr. Strangelove
 Group Capt. Lionel Mandrake
 President Merkin Muffley
 Note this works
 * @author Nathanael Dick
 * @version Spring, 2017
 */
public class GetMovieActorRoles {
    public static void main(String[] args) throws SQLException {
        Scanner d = new Scanner(System.in);
        System.out.println("please enter the movie id\n");
        String getMovieId = d.nextLine();
        System.out.println("please enter the actor id\n");
        String getActorId = d.nextLine();
        KVStore store3 = KVStoreFactory.getStore( new KVStoreConfig("kvstore", "localhost:5000"));

        System.out.println("Movie ID: "+getMovieId);
        System.out.println("Actor ID: "+getActorId);
        //big help here from http://www.uow.edu.au/~jrg/235/HOMEWORK/e11-2-A7-frame.html
        Key majorKeyPathOnly2 = Key.createKey(Arrays.asList("role","movieID", getMovieId));
        Map<Key, ValueVersion> fields2 = store3.multiGet(majorKeyPathOnly2, null, null);

        for (Map.Entry<Key, ValueVersion> field2 : fields2.entrySet()) {
            if(field2.getKey().getMinorPath().get(1).equals(getActorId)) {
                System.out.println("\t\t " + field2.getKey().getMinorPath().get(3));
            }
        }
    }
}
