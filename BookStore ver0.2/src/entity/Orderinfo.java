package entity;

import java.util.Calendar;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

public class Orderinfo {
	private int id;
	private int userid;
	private Calendar ordertime;
	private double total;
	private Set<OrderinfoItem> itemlist = new HashSet<OrderinfoItem>();
	
	public Set<OrderinfoItem> getItemlist() {
		return itemlist;
	}
	public void setItemlist(Set<OrderinfoItem> itemlist) {
		this.itemlist = itemlist;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public Calendar getOrdertime() {
		return ordertime;
	}
	public void setOrdertime(Calendar ordertime) {
		this.ordertime = ordertime;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	
	public void addItem(OrderinfoItem item){
		boolean flag = false;
		for (Iterator<OrderinfoItem> it = this.itemlist.iterator();it.hasNext();){
			OrderinfoItem oldItem = (OrderinfoItem)it.next();
			if (oldItem.getBookid() == item.getBookid()){
				oldItem.setBooknum(oldItem.getBooknum() + item.getBooknum());
				flag = true;
				break;
			}
		}
		if (flag == false){
			this.itemlist.add(item);
		}
	}
	
	public void updateItem(OrderinfoItem item){
		for (Iterator<OrderinfoItem> it = this.itemlist.iterator();it.hasNext();){
			OrderinfoItem oldItem = (OrderinfoItem)it.next();
			if (oldItem.getBookid() == item.getBookid()){
				oldItem.setBooknum(item.getBooknum());
				oldItem.calcPrice();
				break;
			}
		}
	}
	
	public void deleteItem(OrderinfoItem item){
		for (Iterator<OrderinfoItem> it = this.itemlist.iterator();it.hasNext();){
			OrderinfoItem oldItem = (OrderinfoItem)it.next();
			if (oldItem.getBookid() == item.getBookid()){
				this.itemlist.remove(oldItem);
				break;
			}
		}
	}
	
	public void calcTotal(){
		this.total = 0;
		if (this.itemlist == null) return;
		for (Iterator<OrderinfoItem> it = this.itemlist.iterator();it.hasNext();){
			OrderinfoItem item = (OrderinfoItem)it.next();
			item.calcPrice();
			this.total = this.total + item.getTotalPrice();
		}
	}
	
 
}
