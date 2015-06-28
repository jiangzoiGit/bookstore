package controller;

import java.util.Map;

import com.opensymphony.xwork2.ActionContext;

import entity.Userinfo;
 
public class UpdateUser extends BaseAction {
     
    private static final long serialVersionUID = 1L;     
    private Userinfo userinfo;
    @Override
    public String execute() throws Exception {
       	System.out.print("[Update user:]userid=" + userinfo.getId() 
       			 		+ "; username=" + userinfo.getUsername()
       			 		+ "; password=" + userinfo.getPassword()
       			 		+ "\n");
       	if (this.getAllService().getUserinfoService().checkUserinfo(userinfo.getUsername()) == true){
       		ActionContext actionContext = ActionContext.getContext();
       		Map<String, Object> session = actionContext.getSession();
       		session.put("error_user_exist", "yes");
       		return "success";
       	}
       	
    	if (this.getAllService().getUserinfoService().updateUser(userinfo) ==true)
    		return SUCCESS;
    	 
        return "error_create_book";
    }
    
	public Userinfo getUserinfo() {
		return userinfo;
	}
	public void setUserinfo(Userinfo userinfo) {
		this.userinfo = userinfo;
	}
}
