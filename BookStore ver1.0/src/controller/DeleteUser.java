package controller;
 
public class DeleteUser extends BaseAction {
     
    private static final long serialVersionUID = 1L;     
    private String userid = "";
    @Override
    public String execute() throws Exception {
    	if (this.getAllService().getUserinfoService().deleteUserById(userid) == true)
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
