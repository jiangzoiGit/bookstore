package controller;


import java.util.Map;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import entity.Orderinfo;
import entity.OrderinfoItem;

public class DeleteCartItem extends ActionSupport{
	private static final long serialVersionUID = 1L;
	private OrderinfoItem newItem;
	
public boolean deleteCartItemById(OrderinfoItem newItem){
		
		System.out.print("DeleteBook: [bookid]=" + newItem.getBookid() 
						 + " [booknum]=" + newItem.getBooknum() + "\n");
		
		
		ActionContext actionContext = ActionContext.getContext();
		Map<String, Object> session = actionContext.getSession();
		
		Orderinfo order = (Orderinfo)session.get("cart");
		if (order != null){
			order.deleteItem(newItem);
		}
		else{
			return false;
		}
		
		session.put("cart", order);
		return true;
	}
	
	public String execute(){
		if (deleteCartItemById(newItem) == false)
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
