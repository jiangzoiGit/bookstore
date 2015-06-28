package controller;

import java.util.ArrayList;
import java.util.Map;
import com.opensymphony.xwork2.ActionContext;

import entity.Bookinfo;

public class RetrieveBook extends BaseAction{
	private static final long serialVersionUID = 1L;
	private String bookname = null;

	public String execute(){
		ActionContext actionContext = ActionContext.getContext();
		Map<String, Object> session = actionContext.getSession();
		ArrayList<Bookinfo> bookList = this.getAllService().getBookinfoService().getAllBookAboutName(bookname);
		System.out.println(bookList.size());
		session.put("bookList", bookList);
		return "success";
	}
	
	public String getBookname() {
		return bookname;
	}

	public void setBookname(String bookname) {
		this.bookname = bookname;
	}
	

}
