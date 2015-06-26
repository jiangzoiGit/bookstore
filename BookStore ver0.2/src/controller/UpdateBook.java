package controller;

import org.hibernate.Session;

import entity.Bookinfo;
import service.BookinfoService;
import test.util.HibernateUtil;

import com.opensymphony.xwork2.ActionSupport;
 
public class UpdateBook extends ActionSupport {
     
    private static final long serialVersionUID = 1L;     
    private Bookinfo bookinfo;
    private String bookid = "";
    @Override
    public String execute() throws Exception {
       	BookinfoService bookinfoService = new BookinfoService();
       	bookinfo.setId(bookid);
       	System.out.print("bookid = " + bookid + "\n");
       	System.out.print("bookinfo id="+bookinfo.getId()+"\n");
       	System.out.print("bookinfo name="+bookinfo.getBookname()+"\n");
       	
    	if (bookinfoService.updateBook(bookinfo) ==true)
    		return SUCCESS;
    	 
        return "error_create_book";
    }
    
	public Bookinfo getBookinfo() {
		return bookinfo;
	}
	public void setBookinfo(Bookinfo bookinfo) {
		this.bookinfo = bookinfo;
	}
	
	public String getBookid() {
		return bookid;
	}
	public void setBookid(String bookid) {
		this.bookid = bookid;
	}
 
}
