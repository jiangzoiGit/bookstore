package entity;

public class OrderinfoItem {
	private int id;
	private int bookid;
	private int booknum;
	private double singlePrice;
	private double totalPrice;
	private Orderinfo orderinfo;
	
	public Orderinfo getOrderinfo() {
		return orderinfo;
	}
	public void setOrderinfo(Orderinfo orderinfo) {
		this.orderinfo = orderinfo;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getBookid() {
		return bookid;
	}
	public void setBookid(int bookid) {
		this.bookid = bookid;
	}
	public int getBooknum() {
		return booknum;
	}
	public void setBooknum(int booknum) {
		this.booknum = booknum;
	}
	
	public double getSinglePrice() {
		return singlePrice;
	}
	public void setSinglePrice(double singlePrice) {
		this.singlePrice = singlePrice;
	}
	public double getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}
	public double calcPrice(){
		this.totalPrice = this.singlePrice * this.booknum;
		return this.totalPrice;
	}
}
