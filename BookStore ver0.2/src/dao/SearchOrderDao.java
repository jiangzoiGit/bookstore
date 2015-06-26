package dao;

import java.math.BigInteger;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

import test.util.HibernateUtil;
import entity.Bookinfo;

public class SearchOrderDao {
	public List searchOrderByCategory(){
		Session session = null;
		List data = null;
		try{		
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction(); 
	        
	        String sql = "select category, sum(o.booknum*b.price) as cost from bookinfo as b, orderinfoitem as o where b.id=o.bookid group by category";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	        
	        data = query.list();
	        
			session.getTransaction().commit();
			
			for(Object object : data)
	         {
	            Map row = (Map)object;
	            String category = (String)row.get("category");
	            double cost = (double)row.get("cost");
	            System.out.print("Category:" + row.get("category")); 
	            System.out.println(", Cost " + row.get("cost")); 
	         } 
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		return data;
	}
	
	public List searchOrderByYear(){
		Session session = null;
		List data = null;
		try{		
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction(); 
	        
	        String sql = "select year, sum(total) as cost from (select year(ordertime) as year, total from orderinfo) as a  group by year";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	        
	        data = query.list();
	        
			session.getTransaction().commit();
			
			for(Object object : data)
	         {
	            Map row = (Map)object;
//	            String year = ((Integer)row.get("year")).toString();
//	            double cost = (double)row.get("cost");
	            if (row.get("year") instanceof Integer){
	            	System.out.print("Year:" + row.get("year")); 
	            	System.out.println(", Cost " + row.get("cost")); 
	            }
	         } 
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		return data;
	}
	
	public List searchOrderByMonth(){
		Session session = null;
		List data = null;
		Calendar calendar =Calendar.getInstance();
		int year = calendar.get(Calendar.YEAR);
		try{		
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction(); 
	        
	        String sql = "select month, sum(total) as cost from (select month(ordertime) as month, total from orderinfo where year(ordertime)=:year) as a  group by month";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("year", year);
	        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	        
	        data = query.list();
	        
			session.getTransaction().commit();
			
			for(Object object : data)
	         {
	            Map row = (Map)object;
	            if (row.get("month") instanceof Integer){
	            	System.out.print("Month:" + row.get("month")); 
	            	System.out.println(", Cost " + row.get("cost")); 
	            }
	         } 
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		return data;
	}
	public List searchOrderByDay(){
		Session session = null;
		List data = null;
		Calendar calendar =Calendar.getInstance();
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		try{		
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction(); 
	        
	        String sql = "select day, sum(total) as cost from (select day(ordertime) as day, "
	        		+ " total from orderinfo where year(ordertime)=:year and month(ordertime)=:month) as a group by day";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("year", year);
	        query.setParameter("month", month);
	        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	        
	        data = query.list();
	        
			session.getTransaction().commit();
			
			for(Object object : data)
	         {
	            Map row = (Map)object;
	            if (row.get("day") instanceof Integer){
	            	System.out.print("Day:" + row.get("day")); 
	            	System.out.println(", Cost " + row.get("cost")); 
	            }
	         } 
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		return data;
	}
	
	public int searchOrderByMoney(double low, double high){
		Session session = null;
		List data = null;
		try{		
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction(); 
	        
	        String sql;
	        SQLQuery query;
	        if (high < 0){
	        	sql = "select count(*) as people from(select username, sum(total) as total "
		        		+ "from orderinfo as o, userinfo as u where o.userid=u.id group by username)"
		        		+ " a where :low <= total";
		        query = session.createSQLQuery(sql);
		        query.setParameter("low", low);
		        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	        }
	        else{
	        	sql = "select count(*) as people from(select username, sum(total) as total "
		        		+ "from orderinfo as o, userinfo as u where o.userid=u.id group by username)"
		        		+ " a where :low <= total and total < :high";
		        query = session.createSQLQuery(sql);
		        query.setParameter("low", low);
		        query.setParameter("high", high);
		        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	        }
	        
	        
	        data = query.list();
	        
			session.getTransaction().commit();
			
			for(Object object : data)
	         {
				
	            Map row = (Map)object;
	            if (row.get("people") instanceof BigInteger){
	            	System.out.println("People:" + row.get("people")); 
	            	return ((BigInteger)row.get("people")).intValue();
	            }
	         } 
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		return 0;
	}
}
