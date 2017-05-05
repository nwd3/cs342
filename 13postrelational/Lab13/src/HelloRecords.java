import oracle.kv.*;

import java.util.Arrays;
import java.util.Map;

/**
 * Created by nwd3 on 5/5/2017.
 *
 * @student nwd3
 * @Nathanael Dick
 * @date 5/5/2017
 */
public class HelloRecords {

    public static void main(String[] args) {

        KVStore store2 = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        String id = "id", valueString = "9216";
        String name = "name", valueString2 = "Dr. Strangelove";
        String year = "year", valueString3 = "1964";
        String rating = "rating", valueString4 = "8.7";

//I prefer to create the keys this way but they could be hardcoded as show below
        Key key = Key.createKey(Arrays.asList("movie", valueString), Arrays.asList(name));
        Key key2 = Key.createKey(Arrays.asList("movie", valueString), Arrays.asList(year));
        Key key3 = Key.createKey(Arrays.asList("movie", valueString), Arrays.asList(rating));

        //or I could hardcode it like this
//        Key key6 = Key.createKey(Arrays.asList("movie","9216"),Arrays.asList("name","Dr. Strangelove"));
//        Key key4 = Key.createKey(Arrays.asList("movie","9216"),Arrays.asList("year","1964"));
//        Key key5  = Key.createKey(Arrays.asList("movie","9216"),Arrays.asList("rating","8.7"));


        //  create the values
        Value value2 = Value.createValue(valueString2.getBytes());
        Value value3 = Value.createValue(valueString3.getBytes());
        Value value4 = Value.createValue(valueString4.getBytes());

        //put the keys
        store2.put(key, value2);
        store2.put(key2, value3);
        store2.put(key3, value4);

        //exercise 13.2 output
        String result = new String(store2.get(key).getValue().getValue());
        System.out.println(key.toString() + " : " + result);
        String result2 = new String(store2.get(key2).getValue().getValue());
        System.out.println(key2.toString() + " : " + result2);
        String result3 = new String(store2.get(key3).getValue().getValue());
        System.out.println(key3.toString() + " : " + result3);

        //Exercise 13.3 output
        //note value string is the id number of the desired movie
        Key majorKeyPathOnly = Key.createKey(Arrays.asList("movie", valueString));
        Map<Key, ValueVersion> fields = store2.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {

            String mfieldName = field.getKey().getMajorPath().get(0);
            String mfieldName2 = field.getKey().getMajorPath().get(1);

            String fieldName = field.getKey().getMinorPath().get(0);

            String fieldValue = new String(field.getValue().getValue().getValue());

            System.out.println(mfieldName + "/" + mfieldName2 + "/" + "-" + fieldName + "\t: " + fieldValue);
        }

        store2.delete(key);
        store2.delete(key2);
        store2.delete(key3);
//        store2.delete(key6);
//        store2.delete(key4);
//        store2.delete(key5);
        store2.close();


    }


}
