package controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;

import service.OrderinfoService;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;


public class Pay extends ActionSupport{
	
	public String execute(){
		
		OrderinfoService payService = new OrderinfoService();
		ActionContext actionContext = ActionContext.getContext();
		Map session = actionContext.getSession();
		ArrayList booklist = (ArrayList)session.get("cartContent");
		String userid = (String)session.get("userid");
		
		System.out.print("[Pay:]userid=" + userid + "\n");
		
		if ((booklist == null) || (userid == null)){
			System.out.print("[Pay:]booklist is null\n");
		}
		else{
			if (payService.pay(booklist, userid) == false){
				session.put("payFail", "yes");
				return "fail";
			}
			session.put("cartContent", null);
			session.put("paySuccess", "yes");
			return "success";
		}
		session.put("payFail", "yes");
		return "fail";
	}

}
