package test.util;

import org.hibernate.Session;
import org.hibernate.SessionFactory; 
import org.hibernate.cfg.Configuration; 

public class HibernateUtil { 
    private static final SessionFactory sessionFactory = buildSessionFactory(); 
    private static SessionFactory buildSessionFactory() { 
    	try { 
    		// Create the SessionFactory from hibernate.cfg.xml 
    		System.out.print("OK, initial SessionFactory creation.");
    		return new Configuration().configure().buildSessionFactory(); 
    	} 
    	catch (Throwable ex) { 
                       // Make sure you log the exception, as it might be 
    		System.err.println("Initial SessionFactory creation failed." + ex); 
                       	throw new ExceptionInInitializerError(ex); 
    	} 
    } 
    
    public static SessionFactory getSessionFactory() { 
    	return sessionFactory; 
    }
    
    public static Session getSession(){
    	return sessionFactory.openSession();
    }
    
    public static void closeSession(Session session){
    	if (session != null){
    		if (session.isOpen()){
    			session.close();
    		}
    	}
    }
    
}
