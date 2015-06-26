package controller;

import java.util.Map;

import org.hibernate.Session;

import entity.Userinfo;
import service.UserinfoService;
import test.util.HibernateUtil;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
 
public class CreateUser extends ActionSupport {
     
    private static final long serialVersionUID = 1L;     
    private Userinfo userinfo;
    @Override
    public String execute() throws Exception {
       	UserinfoService userinfoService = new UserinfoService();
       	if (userinfoService.checkUserinfo(userinfo.getUsername()) == true){
       		ActionContext actionContext = ActionContext.getContext();
       		Map session = actionContext.getSession();
       		session.put("error_user_exist", "yes");
       		return "success";
       	}
       	userinfo.setPrivilege("1");
       	//userinfo.setBalance(0);
       	
       	System.out.print("user.privilege=" + userinfo.getPrivilege());
    	if (userinfoService.createUser(userinfo) ==true)
    		return SUCCESS;
    	 
        return "error_create_user";
    }
	public Userinfo getUserinfo() {
		return userinfo;
	}
	public void setUserinfo(Userinfo userinfo) {
		this.userinfo = userinfo;
	}
    
	
 
}
