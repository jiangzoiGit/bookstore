package service;

import dao.AllDao;
import entity.Orderinfo;

public class OrderinfoService {
	private AllDao allDao;

	public boolean createOrder(Orderinfo order){
		return this.getAllDao().getOrderinfoDao().createOrder(order);
	}
	
	public AllDao getAllDao() {
		return allDao;
	}

	public void setAllDao(AllDao allDao) {
		this.allDao = allDao;
	} 

}
