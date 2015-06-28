package controller;

import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class Logout extends ActionSupport{
	private static final long serialVersionUID = 1L;

	public String execute(){
		
		ActionContext actionContext = ActionContext.getContext();
		Map<String, Object> session = actionContext.getSession();
		System.out.print("user "+session.get("username") + " logout.\n");
		session.clear();
		
		return SUCCESS;
	}
}
