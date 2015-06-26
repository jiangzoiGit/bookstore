package controller;

import java.util.ArrayList;
import java.util.Map;

import service.UserinfoService;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class UserList extends ActionSupport{
	
	private static final long serialVersionUID = 1L;
	private ArrayList userList = null;
	
	public String execute(){
		UserinfoService userService = new UserinfoService();
		userList = userService.getAllUser();
		
		return "bookList";
	}

	public ArrayList getUserList() {
		return userList;
	}

	public void setUserList(ArrayList userList) {
		this.userList = userList;
	}

	
}
