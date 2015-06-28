package controller;

import java.util.Map;
import com.opensymphony.xwork2.ActionContext;
import entity.Bookinfo;

public class DetailDisplay extends BaseAction{
	private static final long serialVersionUID = 1L;
	private String bookid;
	public String execute() throws Exception{
		Bookinfo book = this.getAllService().getBookinfoService().findBookById(bookid);
		ActionContext actionContext = ActionContext.getContext();
		Map<String, Object> session = actionContext.getSession();
		session.put("book", book);
		return SUCCESS;
	}
	public String getBookid() {
		return bookid;
	}
	public void setBookid(String bookid) {
		this.bookid = bookid;
	}

}
