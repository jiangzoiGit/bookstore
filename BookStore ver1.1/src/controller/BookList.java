package controller;

import java.util.ArrayList;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;

import service.BookinfoService;
import entity.Bookinfo;

public class BookList extends BaseAction{
	
	private static final long serialVersionUID = 1L;
	
	public String execute()
	{	
		ActionContext actionContext = ActionContext.getContext();
		Map<String, Object> session = actionContext.getSession();
		
		BookinfoService bookService = this.getAllService().getBookinfoService();
		ArrayList<Bookinfo> bookList = bookService.getAllBook();
		ArrayList<String> categoryList = bookService.getAllCategory();
		session.put("bookList", bookList);
		session.put("categoryList", categoryList);
		
		return "bookList";
	}
}
