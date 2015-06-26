package controller;

import org.hibernate.Session;

import entity.Userinfo;
import service.UserinfoService;
import test.util.HibernateUtil;

import com.opensymphony.xwork2.ActionSupport;
 
public class DeleteUser extends ActionSupport {
     
    private static final long serialVersionUID = 1L;     
    private String userid = "";
    @Override
    public String execute() throws Exception {
    	UserinfoService userinfoService = new UserinfoService();
    	
    	if (userinfoService.deleteUserById(userid) == true)
    		return SUCCESS;
    	 
        return "error_remove_user";
              
        
    }
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
}
