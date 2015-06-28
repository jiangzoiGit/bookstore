package service;

import java.util.ArrayList;

import entity.Userinfo;
import dao.AllDao;
import dao.MongodbDao;
import dao.UserinfoDao;

public class UserinfoService {
	private AllDao allDao;
	
	public AllDao getAllDao() {
		return allDao;
	}

	public void setAllDao(AllDao allDao) {
		this.allDao = allDao;
	}

	public ArrayList<Userinfo> getAllUser(){
		UserinfoDao userinfoDao = this.getAllDao().getUserinfoDao();
		ArrayList<Userinfo> userList = userinfoDao.getAllUser();
		return userList;
	}
	
	public Userinfo getUserByName(String username){
		UserinfoDao userinfoDao = new UserinfoDao();	
		Userinfo userinfo = userinfoDao.findUserinfoByName(username);
		return userinfo;
	}
	
	public boolean updateUser(Userinfo user){
		UserinfoDao userinfoDao = new UserinfoDao();
		if (userinfoDao.updateUser(user) == true)
			return true;
		return false;
		
	}
	
	public boolean createUser(Userinfo user){
		UserinfoDao userinfoDao = this.getAllDao().getUserinfoDao();
		if(userinfoDao.createUser(user) == true)
			return true;
		return false;
	}
	
	public boolean deleteUserById(String id){
		UserinfoDao userinfoDao = new UserinfoDao();
		if(userinfoDao.deleteUserById(id) == true)
			return true;
		return false;
	}
	
	
	public boolean checkAdmin(String username, String password){
	//check if the account belongs to admin
		UserinfoDao userinfoDao = this.getAllDao().getUserinfoDao();
		Userinfo userinfo = null;
		userinfo = userinfoDao.findUserinfoByName(username);			
		if (userinfo == null) {
			return false;
		} 
		else {
			if (userinfo.getPrivilege().equals("0")){
				return true;
			}
			return false;
		}
	}
	
	public boolean login(String username, String password)
	//check if the username and password correct
	{
		UserinfoDao userinfoDao = this.getAllDao().getUserinfoDao();
		Userinfo userinfo = null;
		userinfo = userinfoDao.findUserinfoByName(username);
		if (userinfo == null) {
			return false;
		} else {
			if (userinfo.getPassword().equals(password)){
				return true;
			}
			
			return false;
		}
	}
	
	public boolean checkUserinfo(String username){
		UserinfoDao userinfoDao = this.getAllDao().getUserinfoDao();
		return userinfoDao.checkUserinfo(username);
	}
	
	public String getUserNameByID(int uid){
		UserinfoDao userinfoDao = this.getAllDao().getUserinfoDao();
		return userinfoDao.getUserNameByID(uid);
	}
	
	public String findPhoto(String userid) throws Exception{
		MongodbDao mongodbDao = this.getAllDao().getMongodbDao();
		return mongodbDao.findPhoto(userid);
	}
	
	public void insertPhoto(String userid, String photo) throws Exception{
		MongodbDao mongodbDao = this.getAllDao().getMongodbDao();
		if (mongodbDao.findPhoto(userid) != null)
		{
			mongodbDao.updatePhoto(userid, photo);
		}
		else
		{
			mongodbDao.insertPhoto(userid, photo);
		}
	}
	
	public String findDetail(String userid) throws Exception{
		MongodbDao mongodbDao = this.getAllDao().getMongodbDao();
		return mongodbDao.findDetail(userid);
	}
	
	public void insertDetail(String userid, String detail) throws Exception{
		MongodbDao mongodbDao = this.getAllDao().getMongodbDao();
		if (mongodbDao.findDetail(userid) != null)
		{
			mongodbDao.updateDetail(userid, detail);
		}
		else
		{
			mongodbDao.insertDetail(userid, detail);
		}
	}
}
