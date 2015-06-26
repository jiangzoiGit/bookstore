package controller;

import java.util.Map;
import entity.Userinfo;
import service.UserinfoService;
import com.opensymphony.xwork2.ActionContext;

public class Login extends BaseAction{
	private static final long serialVersionUID = 1L;
	
	private Userinfo userinfo;
	
	public Userinfo getUserinfo() {
        return userinfo;
    }
     
    public void setUserinfo(Userinfo User) {
        userinfo = User;    
    }
	
    @Override
	public String execute(){
    	//get session
		UserinfoService usRef = this.getAllService().getUserinfoService();
		ActionContext actionContext = ActionContext.getContext();
		Map<String, Object> session = actionContext.getSession();
		
		//assistant info for debug
		System.out.print("[LoginAction:]user:" 
				 	   + userinfo.getUsername()
				 	   + "\n");
		
		//user should goto BookList, admin should goto manageView
		if (usRef.login(userinfo.getUsername(), userinfo.getPassword())){
			session.put("username",userinfo.getUsername());
			userinfo = usRef.getUserByName(userinfo.getUsername());
			session.put("userid", userinfo.getId());
			if (usRef.checkAdmin(userinfo.getUsername(), userinfo.getPassword())){
				//if the account belongs to admin
				session.put("admin", "yes");
				return "manageView";
			}
			return "bookList";
		}
		else{
			session.put("error_login", "login_wrong");
			return "login_error";
		}
	}
}
