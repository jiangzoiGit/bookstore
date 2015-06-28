package controller;

import java.util.Map;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;

import entity.Userinfo;

public class ModifyProfile extends BaseAction{

	private static final long serialVersionUID = 1L;
	private String detail = null;
	private String photo = null;
	
	public String execute() throws Exception
	{
		ActionContext actionContext = ActionContext.getContext();
		Map<String, Object> session = actionContext.getSession();
		if (detail != null){
			System.out.println("[Detail:]" + detail);
			
			String username = (String) session.get("username");
			if (username != null){
				Userinfo user = this.getAllService().getUserinfoService().getUserByName(username);
				this.getAllService().getUserinfoService().insertDetail(user.getId(), detail);
			}
			detail = null;
		}
		if (photo != null){
			System.out.println("[Photo:]" + photo);
			
			String username = (String) session.get("username");
			if (username != null){
				Userinfo user = this.getAllService().getUserinfoService().getUserByName(username);
				this.getAllService().getUserinfoService().insertPhoto(user.getId(), photo);
			}
			photo = null;
		}
		
		ServletActionContext.getResponse().setContentType("text/html");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		ServletActionContext.getResponse().getWriter().printf("success");
		ServletActionContext.getResponse().getWriter().flush();
		ServletActionContext.getResponse().getWriter().close();
		return null;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

}
