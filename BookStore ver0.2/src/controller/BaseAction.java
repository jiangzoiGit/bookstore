package controller;

import service.AllService;
import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends ActionSupport{
	private static final long serialVersionUID = 1L;
	private AllService allService;

	public AllService getAllService() {
		return allService;
	}

	public void setAllService(AllService allService) {
		this.allService = allService;
	}
	

}
