package controller;

import java.util.Map;
import entity.Userinfo;
import service.UserinfoService;
import com.opensymphony.xwork2.ActionContext; 
public class Register extends BaseAction {    
	private static final long serialVersionUID = 1L;
    private Userinfo userinfo;
     
    @Override
    public String execute() throws Exception {
         
        //get session
        ActionContext actionContext = ActionContext.getContext();
    	Map<String, Object> mySession = actionContext.getSession();
        
    	//get service
		UserinfoService usRef = this.getAllService().getUserinfoService();
		
		if (userinfo == null) {
			//if userinfo is null, the it is illegal
			mySession.put("error_register","reg_exist");
			return "reg_error";
		}
		if (userinfo.getUsername().length() < 5 || userinfo.getPassword().length() < 5){
			//username and password length should not be less than 5
			mySession.put("error_register","reg_wrong");
			return "reg_error";
		}
		//make the privilege as user
		userinfo.setPrivilege("1");
		//set the balance as 0.00$
		userinfo.setBalance(1000);
        if (usRef.checkUserinfo(userinfo.getUsername()) == true){
            mySession.put("error_register","reg_exist");
        	return "reg_error";
        }
        
        mySession.put("username",userinfo.getUsername());
        usRef.createUser(userinfo);
    	
    	
        return SUCCESS;
         
    }
     
    public Userinfo getUserinfo() {
        return userinfo;
    }
     
    public void setUserinfo(Userinfo User) {
        userinfo = User;
    }
}
