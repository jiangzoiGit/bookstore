package controller;

import entity.Bookinfo;
 
public class CreateBook extends BaseAction {   
    private static final long serialVersionUID = 1L;     
    private Bookinfo bookinfo;
    @Override
    public String execute() throws Exception {
    	if (this.getAllService().getBookinfoService().createBook(bookinfo) == true)
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
