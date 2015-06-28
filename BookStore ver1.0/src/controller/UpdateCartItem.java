package controller;


import java.util.Map;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import entity.Orderinfo;
import entity.OrderinfoItem;

public class UpdateCartItem extends ActionSupport{
	private static final long serialVersionUID = 1L;
	private OrderinfoItem newItem;
	
	public boolean updateCartItemById(OrderinfoItem newItem){
		
		System.out.print("UpdateBook: [bookid]=" + newItem.getBookid() 
						 + " [booknum]=" + newItem.getBooknum() + "\n");
		
		
		ActionContext actionContext = ActionContext.getContext();
		Map<String, Object> session = actionContext.getSession();
		
		Orderinfo order = (Orderinfo)session.get("cart");
		if (order != null){
			order.updateItem(newItem);
		}
		else{
			return false;
		}
		
		session.put("cart", order);
		return true;
	}
	
	public String execute(){
		if (updateCartItemById(newItem) == false)
			return "fail";
		return "success";
	}

	public OrderinfoItem getNewItem() {
		return newItem;
	}

	public void setNewItem(OrderinfoItem newItem) {
		this.newItem = newItem;
	}

	
}
