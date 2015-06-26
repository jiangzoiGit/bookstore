package controller;

import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import entity.Userinfo;
import service.UserinfoService;

public class Logout extends ActionSupport{
	
	public String execute(){
		
		ActionContext actionContext = ActionContext.getContext();
		Map session = actionContext.getSession();
		System.out.print("user "+session.get("username") + " logout.\n");
		session.clear();
		
		return SUCCESS;
	}
}
