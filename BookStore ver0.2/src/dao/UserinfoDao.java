package dao;

import entity.Userinfo;
import test.util.HibernateUtil;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

public class UserinfoDao {
	
	public boolean createUser(Userinfo userinfo){
		Session session = null;
		session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
			
		session.save(userinfo);
	
		session.getTransaction().commit();
		HibernateUtil.closeSession(session);
		return true;
	}
	
	public boolean deleteUserById(String id){
		Session session = null;
		try{
			session = HibernateUtil.getSessionFactory().getCurrentSession();
			session.beginTransaction();
			
			Userinfo userinfo = findUserinfoById(id);
			if (userinfo != null){
				session.delete(userinfo);
			}
			
			session.getTransaction().commit();
			HibernateUtil.closeSession(session);
			return true;
		} catch (Exception e){
			e.printStackTrace();
			session.getTransaction().rollback();
		} finally{
			HibernateUtil.closeSession(session);
		}
		return false;
	}
	
	public boolean updateUser(Userinfo userinfo)
	{
		Session session = null;
		try{
			session = HibernateUtil.getSessionFactory().getCurrentSession();
			session.beginTransaction();
			
			Userinfo oldUser = (Userinfo)session.get(Userinfo.class, userinfo.getId());
			oldUser.setUsername(userinfo.getUsername());
			oldUser.setPassword(userinfo.getPassword());
			oldUser.setBalance(userinfo.getBalance());
			session.update(oldUser);
			
			session.getTransaction().commit();
			HibernateUtil.closeSession(session);

			return true;
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		return false;
	}
	
	
	public ArrayList<Userinfo> getAllUser(){
		Session session = null;
		ArrayList<Userinfo> userList = null;
		
		try{
			userList = new ArrayList<Userinfo>();
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction();
	        String hql = "FROM Userinfo";
	        Query query = session.createQuery(hql);
	        List result = query.list();
	        
	        if (result.size() == 0){
	        	System.out.print("The result is empty\n");
				return null;
	        }
	        
	        for (Iterator iter=result.iterator(); iter.hasNext();) {
				Userinfo tempuser = (Userinfo)iter.next();
				userList.add(tempuser);
			}
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		return userList;
		
	}
	
	public Userinfo findUserinfoByName(String username) {
		Session session = null;
		
		Userinfo result = null;
		try{
			//System.out.print("Username: " + username + "; Password: "+ password + "\n");
			
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction(); 
	        
	        String hql = "FROM Userinfo U WHERE U.username = :username";
	        Query query = session.createQuery(hql);
	        query.setParameter("username", username);
	        List resultSet = query.list();
	        
			session.getTransaction().commit();
			
			if (resultSet.size()==0){
				return null;
			}
			
			for (Iterator iter=resultSet.iterator(); iter.hasNext();) {
				result = (Userinfo)iter.next();
				break;
			}
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		return result;		
	}
	
	public Userinfo findUserinfoById(String userid) {
		Session session = null;
		
		Userinfo result = null;
		try{
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction(); 
	        
	        String hql = "FROM Userinfo U WHERE U.id = :id";
	        Query query = session.createQuery(hql);
	        query.setParameter("id", userid);
	        List resultSet = query.list();
	        
			session.getTransaction().commit();
			
			if (resultSet.size()==0){
				return null;
			}
			
			for (Iterator iter=resultSet.iterator(); iter.hasNext();) {
				result = (Userinfo)iter.next();
				break;
			}
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		return result;		
	}
	
	public boolean checkUserinfo(String username) {
		Userinfo user = findUserinfoByName(username);
		if (user == null)
			return false;
		return true;		
	}
	
	public void modifyBalanceById(String userid, String balance){
		Userinfo user = findUserinfoById(userid);
		user.setBalance(Double.valueOf(balance));
		updateUser(user);
	}
	
	public void modifyBalanceByName(String username, String balance){
		Userinfo user = findUserinfoByName(username);
		user.setBalance(Double.valueOf(balance));
		updateUser(user);
	}
}

