package dao;

import entity.Bookinfo;
import test.util.HibernateUtil;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

public class BookinfoDao {
	
	public ArrayList<String> getAllCategory()
	{
		Session session = null;
		ArrayList<String> categoryList = null;
		try{
			categoryList = new ArrayList<String>();
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction();
	       
	        List rawBookList = session.createQuery("SELECT B.category FROM Bookinfo B GROUP BY B.category").list();
	        if (rawBookList == null){
	        	System.out.print("[BookinfoDao: getAllCategory ]The result is empty\n");
	        	return null;
	        }
	        for (Iterator it = rawBookList.iterator(); it.hasNext();){
	        	String category = (String)it.next();
	        	categoryList.add(category);
	        }    
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		return categoryList;
	}
	
	public ArrayList<Bookinfo> getAllBookAboutName(String bookname){
		
		Session session = null;
		ArrayList<Bookinfo> bookList = null;
		
		try{
			bookList = new ArrayList<Bookinfo>();
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction();
	       
	        List rawBookList = session.createQuery("FROM Bookinfo").list();
	        if (rawBookList == null){
	        	System.out.print("The result is empty\n");
	        	return null;
	        }
	        for (Iterator it = rawBookList.iterator(); it.hasNext();){
	        	Bookinfo book = (Bookinfo)it.next();
	        	if (book.getBookname().contains(bookname)){
	        		bookList.add(book);
	        	}
	        }    
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		
		return bookList;
		
	}
	
	
	public boolean createBook(Bookinfo book) {
		Session session = null;
		session = HibernateUtil.getSessionFactory().getCurrentSession();
		session.beginTransaction();
			
		session.save(book);
	
		session.getTransaction().commit();
		HibernateUtil.closeSession(session);
		return true;
	}
	
	public boolean deleteBookById(String bookid){
		Session session = null;
		try{
			session = HibernateUtil.getSessionFactory().getCurrentSession();
			session.beginTransaction();
			Bookinfo bookinfo = findBookById(bookid);
			if (bookinfo != null)
				session.delete(bookinfo);
	    
			session.getTransaction().commit();
			HibernateUtil.closeSession(session);

			return true;
		} catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		return false;
	}
	
	public boolean updateBook(Bookinfo book)
	{
		Session session = null;
		try{
			session = HibernateUtil.getSessionFactory().getCurrentSession();
			session.beginTransaction();
			
			Bookinfo oldBook = (Bookinfo)session.get(Bookinfo.class, book.getId());
			oldBook = book;
			session.update(oldBook);
			
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
	
	public ArrayList<Bookinfo> findBookByName(String bookname)
	{
		Session session = null;
		ArrayList<Bookinfo> bookList = null;		
		try{
			bookList = new ArrayList<Bookinfo>();
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction();
	        
	        String hql="FROM Bookinfo B WHERE B.bookname = :bookname";
	        Query query = session.createQuery(hql);
	        query.setParameter("bookname", bookname);
	        List result = query.list();
      
			session.getTransaction().commit();
			
			if (result.size()==0){
				System.out.print("The result is empty\n");
				return null;
			}
			
			for (Iterator iter=result.iterator(); iter.hasNext();) {
				Bookinfo tempbook = (Bookinfo)iter.next();
				bookList.add(tempbook);
			}	    
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		
		return bookList;		
	}
	
	public Bookinfo findBookByIsbn(String isbn)
	{
		Session session = null;
		Bookinfo bookinfo = null;
		
		try{
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction();
	        
	        String hql="FROM Bookinfo B WHERE B.isbn = :isbn";
	        Query query = session.createQuery(hql);
	        query.setParameter("isbn", isbn);
	        List result = query.list();
      
			session.getTransaction().commit();
			
			if (result.size()==0){
				System.out.print("The result is empty\n");
				return null;
			}
			
			for (Iterator iter=result.iterator(); iter.hasNext();) {
				bookinfo = (Bookinfo)iter.next();
				break;
			}	    
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		
		return bookinfo;		
	}
	
	public Bookinfo findBookById(String bookid)
	{
		Session session = null;
		Bookinfo bookinfo = null;
		
		try{
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction();
	        
	        String hql="FROM Bookinfo B WHERE B.id = :bookid";
	        Query query = session.createQuery(hql);
	        query.setParameter("bookid", bookid);
	        List result = query.list();
      
			session.getTransaction().commit();
			
			if (result.size()==0){
				System.out.print("The result is empty\n");
				return null;
			}
			
			for (Iterator iter=result.iterator(); iter.hasNext();) {
				bookinfo = (Bookinfo)iter.next();
				break;
			}	    
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		
		return bookinfo;		
	}
	
	public ArrayList<Bookinfo> getAllBook()
	{
		Session session = null;
		ArrayList<Bookinfo> bookList = null;
		
		try{
			bookList = new ArrayList<Bookinfo>();
			session = HibernateUtil.getSessionFactory().getCurrentSession();
	        session.beginTransaction();
	        
	        String hql="FROM Bookinfo";
	        List result = session.createQuery(hql).list();
      
			session.getTransaction().commit();
			
			if (result.size()==0){
				System.out.print("The result is empty\n");
				return null;
			}
			
			for (Iterator iter=result.iterator(); iter.hasNext();) {
				Bookinfo tempbook = (Bookinfo)iter.next();
				bookList.add(tempbook);
			}	    
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
		}finally {
			HibernateUtil.closeSession(session);
		}
		
		return bookList;		
	}
}