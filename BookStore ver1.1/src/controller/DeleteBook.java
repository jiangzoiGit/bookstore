package controller;
 
public class DeleteBook extends BaseAction {
     
    private static final long serialVersionUID = 1L;     
    private String bookid = "";
    @Override
    public String execute() throws Exception {    	
    	if (this.getAllService().getBookinfoService().deleteBookById(bookid) == true)
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
