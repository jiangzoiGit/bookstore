package controller;

import entity.Bookinfo;

public class UpdateBook extends BaseAction {
     
    private static final long serialVersionUID = 1L;     
    private Bookinfo bookinfo;    @Override
    public String execute() throws Exception {
       	System.out.print("bookinfo id="+bookinfo.getId()+"\n");
       	System.out.print("bookinfo name="+bookinfo.getBookname()+"\n");
       	
    	if (this.getAllService().getBookinfoService().updateBook(bookinfo) == true)
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
