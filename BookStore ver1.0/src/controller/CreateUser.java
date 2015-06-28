package controller;

import java.util.Map;
import entity.Userinfo;
import com.opensymphony.xwork2.ActionContext;

 
public class CreateUser extends BaseAction {
    private static final long serialVersionUID = 1L;     
    private Userinfo userinfo;
    @Override
    public String execute() throws Exception {
       	if (this.getAllService().getUserinfoService().checkUserinfo(userinfo.getUsername()) == true){
       		ActionContext actionContext = ActionContext.getContext();
       		Map<String, Object> session = actionContext.getSession();
       		session.put("error_user_exist", "yes");
       		return "success";
       	}
       	userinfo.setPrivilege("1");
       	
       	System.out.print("user.privilege=" + userinfo.getPrivilege());
    	if (this.getAllService().getUserinfoService().createUser(userinfo) ==true)
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
