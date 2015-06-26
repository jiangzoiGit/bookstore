package controller;

import java.util.Map;

import service.BookinfoService;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class RetrieveBook extends ActionSupport{
	private String bookname = null;

	public String execute(){
		ActionContext actionContext = ActionContext.getContext();
		Map session = actionContext.getSession();
		session.put("searchBookName", bookname);
		return "success";
	}
	
	public String getBookname() {
		return bookname;
	}

	public void setBookname(String bookname) {
		this.bookname = bookname;
	}
	

}
