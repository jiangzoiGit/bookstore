package test.util;


import com.mongodb.DB;//加载MongoDB的java驱动
import com.mongodb.Mongo;
 
public class MongoDBUtil {
    public static void main(String[] args) throws Exception {
        Mongo m = new Mongo("localhost", 27017);
        DB db = m.getDB("testdb");
        if(db.authenticate("test", "123".toCharArray())){
            System.out.println("success");;
        }
        else System.out.println("false");
    }
}  

