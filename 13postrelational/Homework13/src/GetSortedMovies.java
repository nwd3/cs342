import oracle.kv.*;
import oracle.kv.impl.fault.SystemFaultException;

import java.sql.SQLException;
import java.util.*;

/**
 * GetSortedMovies - List all the movies in order of year. Sample output:

 1960	238071	Ocean's 11
 1964	92616	Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb
 1972	130128	Godfather, The
 1977	313459	Star Wars
 …Note this works
 * Created by nwd3 on 5/9/2017.
 * @author Nathanael Dick
 * @version Spring, 2017
 */
public class GetSortedMovies {
    public static void main(String[] args) throws SQLException {

        KVStore store3 = KVStoreFactory.getStore( new KVStoreConfig("kvstore", "localhost:5000"));
        Key matchKey = Key.createKey("SortedMovies");
        KeyRange subRange = null;
        Iterator<Key> it = store3.multiGetKeysIterator(Direction.REVERSE,
                0, matchKey, subRange, null);
        Map<Key, ValueVersion> fields2 = store3.multiGet(matchKey, null,null);
        for (Map.Entry<Key, ValueVersion> field2 : fields2.entrySet()) {
        System.out.println(field2.getKey().getMinorPath().get(0)+"\t"+field2.getKey().getMinorPath().get(1)+"\t"+field2.getKey().getMinorPath().get(2));
        }
    }
}





