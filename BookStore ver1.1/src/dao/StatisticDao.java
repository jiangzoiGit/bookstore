package dao;

import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

import test.util.HibernateUtil;
import entity.Bookinfo;
import entity.Orderinfo;
import entity.OrderinfoItem;

public class StatisticDao {
	
	public Double searchOrderByUser(int uid, String start, String finish){
		Session session = null;
		double total = 0;
		try{
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction(); 
	        
	        
        	String hql = "FROM Orderinfo U WHERE U.userid = :uid";
	        Query query = session.createQuery(hql);
	        query.setParameter("uid", uid);
	        List resultSet = query.list();
	        for (Iterator it = resultSet.iterator(); it.hasNext(); )
	        {
	        	Orderinfo order = (Orderinfo) it.next();
	        	Date date = order.getOrdertime().getTime();
	        	SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
	        	String ordertime = df.format(date);
	        	if ((ordertime.compareTo(start) >= 0) && (ordertime.compareTo(finish) <=0)){
		        	total = total + order.getTotal();
	        	}
	        }
			session.getTransaction().commit();
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		return total;
	}
	
	public Double searchOrderByBook(int bid, String start, String finish){
		Session session = null;
		double total = 0;
		try{
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction(); 
	        
	        
	        String sql = "select sum(o2.totalprice) as sells "
	        		   + "from orderinfo as o1, orderinfoitem as o2 where o1.id=o2.orderid and o2.bookid = :bid "
	        		   + "and :start <= o1.ordertime and o1.ordertime <= :finish";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("bid", bid);
	        query.setParameter("start", start);
	        query.setParameter("finish", finish);

	        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	        
	        List data = query.list();
	        
			session.getTransaction().commit();
			
			for(Object object : data)
	         {
	            Map row = (Map)object;
	            if (row.get("sells") == null) continue;
	            total = ((Double)row.get("sells")).doubleValue();
	            System.out.println("Sells:" + row.get("sells")); 
	         } 
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		return total;
	}
	
	public double searchOrderByCategory(String category, String start, String finish){
		Session session = null;
		double total = 0;
		try{		
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction(); 
	        
	        String sql = "select sum(o.totalprice) as sells "
	        		   + "from bookinfo as b, orderinfoitem as o, orderinfo as o2 where b.id=o.bookid and category = :category and o2.id = o.orderid "
	        		   + "and :start <= o2.ordertime and o2.ordertime <= :finish";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("category", category);
	        query.setParameter("start", start);
	        query.setParameter("finish", finish);

	        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	        
	        List data = query.list();
	        
			session.getTransaction().commit();
			
			for(Object object : data)
	         {
	            Map row = (Map)object;
	            if (row.get("sells") instanceof Double){
	            	total = ((Double)row.get("sells")).doubleValue();
	            	System.out.println("Category:" + row.get("category") + " || " + "Sells:" + row.get("sells")); 
	            }
	         } 
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		return total;
	}
		
	public List searchOrderByYear(String start, String finish){
		Session session = null;
		List data = null;
		try{		
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction(); 
	        
	        String sql = "select year, sum(total) as cost, userid "
	        		   + "from (select year(ordertime) as year, total, userid from orderinfo where :start <= ordertime and ordertime <= :finish) as a "
	        		   + "group by year, userid;";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("start", start);
	        query.setParameter("finish", finish);
	        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	        
	        data = query.list();
	        
			session.getTransaction().commit();
			
			for(Object object : data)
	         {
	            Map row = (Map)object;
	            if (row.get("year") instanceof Integer){
	            	System.out.println("Year:" + row.get("year") + " || " + "Cost:" + row.get("cost") + " || " + "Userid:" + row.get("userid")); 
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
	
	public List searchOrderByMonth(String start, String finish){
		Session session = null;
		List data = null;
		try{		
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction(); 
	        
	        String sql = "select year, month, sum(total) as cost, userid "
	        		   + "from (select year(ordertime) as year, month(ordertime) as month, total, userid from orderinfo where :start <= ordertime and ordertime <= :finish) as a "
	        		   + "group by year, month, userid;";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("start", start);
	        query.setParameter("finish", finish);
	        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	        
	        data = query.list();
	        
			session.getTransaction().commit();
			
			for(Object object : data)
	         {
	            Map row = (Map)object;
	            if (row.get("month") instanceof Integer){
	            	System.out.println("Month:" + row.get("month") + " || " + "Cost:" + row.get("cost") + " || " + "Userid:" + row.get("userid")); 
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
	
	public List searchOrderByDay(String start, String finish){
		Session session = null;
		List data = null;
		try{		
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction(); 
	        
	        String sql = "select year, month, day, sum(total) as cost, userid "
	        		   + "from (select year(ordertime) as year, month(ordertime) as month, day(ordertime) as day, total, userid from orderinfo where :start <= ordertime and ordertime <= :finish) as a "
	        		   + "group by year, month, day, userid;";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("start", start);
	        query.setParameter("finish", finish);
	        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	        
	        data = query.list();
	        
			session.getTransaction().commit();
			
			for(Object object : data)
	         {
	            Map row = (Map)object;
	            if (row.get("day") instanceof Integer){
	            	System.out.println("Day:" + row.get("day") + " || " + "Cost:" + row.get("cost") + " || " + "Userid:" + row.get("userid")); 
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
	
	public List searchOrderItemByYear(String start, String finish){
		Session session = null;
		List data = null;
		try{		
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction(); 
	        
	        String sql = "select year, sum(totalprice) as sells, bookid "
	        		+ "from (select year(ordertime) as year, totalprice, bookid "
	        		+ "from orderinfo o1, orderinfoitem o2 where o1.id = o2.orderid and :start <= ordertime and ordertime <= :finish) "
	        		+ "as a group by year, bookid;";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("start", start);
	        query.setParameter("finish", finish);
	        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	        
	        data = query.list();
	        
			session.getTransaction().commit();
			
			for(Object object : data)
	         {
	            Map row = (Map)object;
	            if (row.get("year") instanceof Integer){
	            	System.out.println("Year:" + row.get("year") + " || " + "Sells:" + row.get("sells") + " || " + "Bookid:" + row.get("bookid")); 
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
	
	public List searchOrderItemByMonth(String start, String finish){
		Session session = null;
		List data = null;
		try{		
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction(); 
	        
	        String sql = "select year, month, sum(totalprice) as sells, bookid "
	        		+ "from (select year(ordertime) as year, month(ordertime) as month, totalprice, bookid "
	        		+ "from orderinfo o1, orderinfoitem o2 where o1.id = o2.orderid and :start <= ordertime and ordertime <= :finish) "
	        		+ "as a group by year, month, bookid;";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("start", start);
	        query.setParameter("finish", finish);
	        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	        
	        data = query.list();
	        
			session.getTransaction().commit();
			
			for(Object object : data)
	         {
	            Map row = (Map)object;
	            if (row.get("month") instanceof Integer){
	            	System.out.println("Month:" + row.get("month") + " || " + "Sells:" + row.get("sells") + " || " + "Bookid:" + row.get("bookid")); 
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
	
	public List searchOrderItemByDay(String start, String finish){
		Session session = null;
		List data = null;
		try{		
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction(); 
	        
	        String sql = "select year, month, day, sum(totalprice) as sells, bookid "
	        		+ "from (select year(ordertime) as year, month(ordertime) as month, day(ordertime) as day, totalprice, bookid "
	        		+ "from orderinfo o1, orderinfoitem o2 where o1.id = o2.orderid and :start <= ordertime and ordertime <= :finish) "
	        		+ "as a group by year, month, day, bookid;";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("start", start);
	        query.setParameter("finish", finish);
	        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	        
	        data = query.list();
	        
			session.getTransaction().commit();
			
			for(Object object : data)
	         {
	            Map row = (Map)object;
	            if (row.get("day") instanceof Integer){
	            	System.out.println("Day:" + row.get("day") + " || " + "Sells:" + row.get("sells") + " || " + "Bookid:" + row.get("bookid")); 
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
	
	public List searchCategoryByYear(String start, String finish){
		Session session = null;
		List data = null;
		try{		
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction(); 
	        
	        String sql = "select year, sum(totalprice) as sells, category "
	        		   + "from (select year(ordertime) as year,  totalprice, category "
	        		   + "from orderinfo o1, orderinfoitem o2, bookinfo b where o1.id = o2.orderid and o2.bookid = b.id "
	        		   + "and :start <= ordertime and ordertime <= :finish) as a group by year,   category;";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("start", start);
	        query.setParameter("finish", finish);
	        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	        
	        data = query.list();
	        
			session.getTransaction().commit();
			
			for(Object object : data)
	         {
	            Map row = (Map)object;
	            if (row.get("year") instanceof Integer){
	            	System.out.println("Year:" + row.get("year") + " || " + "Sells:" + row.get("sells") + " || " + "Category:" + row.get("category")); 
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
	
	public List searchCategoryByMonth(String start, String finish){
		Session session = null;
		List data = null;
		try{		
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction(); 
	        
	        String sql = "select year, month, sum(totalprice) as sells, category "
	        		   + "from (select year(ordertime) as year, month(ordertime) as month, totalprice, category "
	        		   + "from orderinfo o1, orderinfoitem o2, bookinfo b where o1.id = o2.orderid and o2.bookid = b.id "
	        		   + "and :start <= ordertime and ordertime <= :finish) as a group by year, month,  category;";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("start", start);
	        query.setParameter("finish", finish);
	        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	        
	        data = query.list();
	        
			session.getTransaction().commit();
			
			for(Object object : data)
	         {
	            Map row = (Map)object;
	            if (row.get("month") instanceof Integer){
	            	System.out.println("Month:" + row.get("month") + " || " + "Sells:" + row.get("sells") + " || " + "Category:" + row.get("category")); 
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
	
	public List searchCategoryByDay(String start, String finish){
		Session session = null;
		List data = null;
		try{		
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction(); 
	        
	        String sql = "select year, month, day, sum(totalprice) as sells, category "
	        		   + "from (select year(ordertime) as year, month(ordertime) as month, day(ordertime) as day, totalprice, category "
	        		   + "from orderinfo o1, orderinfoitem o2, bookinfo b where o1.id = o2.orderid and o2.bookid = b.id "
	        		   + "and :start <= ordertime and ordertime <= :finish) as a group by year, month, day, category;";
	        SQLQuery query = session.createSQLQuery(sql);
	        query.setParameter("start", start);
	        query.setParameter("finish", finish);
	        query.setResultTransformer(Criteria.ALIAS_TO_ENTITY_MAP);
	        
	        data = query.list();
	        
			session.getTransaction().commit();
			
			for(Object object : data)
	         {
	            Map row = (Map)object;
	            if (row.get("day") instanceof Integer){
	            	System.out.println("Day:" + row.get("day") + " || " + "Sells:" + row.get("sells") + " || " + "Category:" + row.get("category")); 
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
}
	
	