package controller;

import java.util.Calendar;
import java.util.Map;
import com.opensymphony.xwork2.ActionContext;
import entity.Orderinfo;

public class Pay extends BaseAction{
	private static final long serialVersionUID = 1L;

	@Override
	public String execute(){
		
		ActionContext actionContext = ActionContext.getContext();
		Map<String, Object> session = actionContext.getSession();
		Orderinfo order = (Orderinfo)session.get("cart");
		if (order == null){
			return "fail";
		}
		
		System.out.print("[Pay:]userid=" + order.getUserid() + "\n");
		
		order.calcTotal();
		order.setOrdertime(Calendar.getInstance());
		if (this.getAllService().getOrderinfoService().createOrder(order) == false){
			session.put("payStatus", "fail");
			return "fail";
		}
		session.put("cart", null);
		session.put("payStatus", "success");
		return "success";
	}
}
