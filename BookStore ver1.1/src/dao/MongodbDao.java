package dao;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.Mongo;
import com.mongodb.DBCollection;
public class MongodbDao {
	private Mongo mongo;
	private DB db;
	private void initial() throws Exception{
		mongo = new Mongo("localhost", 27017);
		db = mongo.getDB("test");
		if(db.authenticate("test", "123".toCharArray())){
            System.out.println("mongodb init success");;
        }
        else System.out.println("mongodb init fail");
	}
	
	protected void closeFunc() {
		mongo.close();
	}
	
	
	public String findPhoto(String userid) throws Exception{
		initial();
		DBCollection userDBCollection = db.getCollection("User");
		DBCursor dbCursor = userDBCollection.find();
		while (dbCursor.hasNext()){
			DBObject object = dbCursor.next();
			String tempid = (String) object.get("userid");
			if (tempid == null) continue;
			if (tempid.equals(userid)){
				closeFunc();
				return (String) object.get("photo");
			}
		}
		closeFunc();
		return null;
	}
	public void insertPhoto(String userid, String photo) throws Exception {
		initial();
		DBCollection userDBCollection = db.getCollection("User");
		DBObject userDBObject = new BasicDBObject();
		userDBObject.put("userid", userid);
		userDBObject.put("photo", photo);
		userDBCollection.insert(userDBObject);
		closeFunc();
	}
	
	public void deletePhoto(String userid) throws Exception{
		initial();
		DBCollection userDBCollection = db.getCollection("User");
		DBObject userDBObject = new BasicDBObject();
		userDBObject.put("userid", userid);
		userDBCollection.remove(userDBObject);
		closeFunc();
	}
	
	public void updatePhoto(String userid, String photo) throws Exception{
		deletePhoto(userid);
		insertPhoto(userid, photo);
	}
	
	public String findDetail(String userid) throws Exception{
		initial();
		DBCollection userDBCollection = db.getCollection("User");
		DBCursor dbCursor = userDBCollection.find();
		while (dbCursor.hasNext()){
			DBObject object = dbCursor.next();
			String tempid = (String) object.get("useridDetail");
			if (tempid == null) continue;
			if (tempid.equals(userid)){
				closeFunc();
				return (String) object.get("detail");
			}
		}
		closeFunc();
		return null;
	}
	
	public void insertDetail(String userid, String detail) throws Exception{
		initial();
		DBCollection userDBCollection = db.getCollection("User");
		DBObject userDBObject = new BasicDBObject();
		userDBObject.put("useridDetail", userid);
		userDBObject.put("detail", detail);
		userDBCollection.insert(userDBObject);
		closeFunc();
	}
	
	public void deleteDetail(String userid) throws Exception{
		initial();
		DBCollection userDBCollection = db.getCollection("User");
		DBObject userDBObject = new BasicDBObject();
		userDBObject.put("useridDetail", userid);
		userDBCollection.remove(userDBObject);
		closeFunc();
	}
	public void updateDetail(String userid, String detail) throws Exception{
		deleteDetail(userid);
		insertDetail(userid, detail);
	}
}
