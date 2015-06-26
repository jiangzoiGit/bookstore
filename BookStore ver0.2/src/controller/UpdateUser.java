package controller;

import org.hibernate.Session;

import entity.Userinfo;
import service.UserinfoService;
import test.util.HibernateUtil;

import com.opensymphony.xwork2.ActionSupport;
 
public class UpdateUser extends ActionSupport {
     
    private static final long serialVersionUID = 1L;     
    private Userinfo userinfo;
    private String userid = "";
    @Override
    public String execute() throws Exception {
       	UserinfoService userinfoService = new UserinfoService();
       	userinfo.setId(userid);
       	System.out.print("[Update user:]userid=" + userid 
       			 		+ "; username=" + userinfo.getUsername()
       			 		+ "; password=" + userinfo.getPassword()
       			 		+ "\n");
       	
    	if (userinfoService.updateUser(userinfo) ==true)
    		return SUCCESS;
    	 
        return "error_create_book";
    }
    
	public Userinfo getUserinfo() {
		return userinfo;
	}
	public void setUserinfo(Userinfo userinfo) {
		this.userinfo = userinfo;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
  
 
}
