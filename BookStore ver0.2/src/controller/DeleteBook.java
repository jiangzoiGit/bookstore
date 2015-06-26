package controller;

import org.hibernate.Session;

import entity.Bookinfo;
import service.BookinfoService;
import test.util.HibernateUtil;

import com.opensymphony.xwork2.ActionSupport;
 
public class DeleteBook extends ActionSupport {
     
    private static final long serialVersionUID = 1L;     
    private String bookid = "";
    @Override
    public String execute() throws Exception {
    	BookinfoService bookinfoService = new BookinfoService();
    	
    	if (bookinfoService.deleteBookById(bookid) == true)
    		return SUCCESS;
    	 
        return "error_remove_book";
              
        
    }
    
	public String getBookid() {
		return bookid;
	}
	public void setBookid(String bookid) {
		this.bookid = bookid;
	}
 
}
