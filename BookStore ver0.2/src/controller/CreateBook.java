package controller;

import org.hibernate.Session;

import entity.Bookinfo;
import service.BookinfoService;
import test.util.HibernateUtil;

import com.opensymphony.xwork2.ActionSupport;
 
public class CreateBook extends ActionSupport {
     
    private static final long serialVersionUID = 1L;     
    private Bookinfo bookinfo;
    @Override
    public String execute() throws Exception {
       	BookinfoService bookinfoService = new BookinfoService();
    	if (bookinfoService.createBook(bookinfo) == true)
    		return SUCCESS;
    	 
        return "error_create_book";
    }
    
	public Bookinfo getBookinfo() {
		return bookinfo;
	}
	public void setBookinfo(Bookinfo bookinfo) {
		this.bookinfo = bookinfo;
	}
 
}
