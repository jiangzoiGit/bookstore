package dao;

import java.util.Set;
import java.util.Iterator;
import org.hibernate.Session;
import test.util.HibernateUtil;
import entity.Bookinfo;
import entity.Userinfo;
import entity.Orderinfo;
import entity.OrderinfoItem;

public class OrderinfoDao {
	
	public boolean createOrder(Orderinfo order)
	{
		Session session = null;
		try{
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction();
	        
			int userid = order.getUserid();
			double total = order.getTotal();
			Userinfo user = (Userinfo)session.get(Userinfo.class, userid);
			if (total + 0.001 > user.getBalance()){
				System.out.print("[PayDao:]user:" + user.getUsername() 
     			       + "; balance:" + user.getBalance()
     			       + "; Total$: " + total + "\n"); 
				session.getTransaction().rollback();
		 		HibernateUtil.closeSession(session);
		 		return false;
			}
			user.setBalance(user.getBalance() - total);
	        session.update(user);
	        
	        Set<OrderinfoItem> bookList = order.getItemlist();
	        
	        for (Iterator<OrderinfoItem> it = bookList.iterator(); it.hasNext();)
	        {
	        	OrderinfoItem item = (OrderinfoItem)it.next();
	        	Bookinfo oldBook = (Bookinfo)session.get(Bookinfo.class, item.getBookid());
	        	if (oldBook.getBooknum() >= item.getBooknum()){
	        		oldBook.setBooknum(oldBook.getBooknum() - item.getBooknum());
		        	session.update(oldBook);
	        	}
	        	else{
	        		session.getTransaction().rollback();
	        		HibernateUtil.closeSession(session);
	        		return false;
	        	}
	        }

	        session.save(order);
			session.getTransaction().commit();
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		return true;
	}
}
