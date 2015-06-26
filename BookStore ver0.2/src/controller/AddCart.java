package controller;

import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.opensymphony.xwork2.ActionContext;

import entity.Orderinfo;
import entity.OrderinfoItem;
import net.sf.json.JSONObject;

public class AddCart extends BaseAction{
	private static final long serialVersionUID = 1L;
	private OrderinfoItem item;
	private String transferString;

	@Override
	public String execute() throws Exception{
		AbstractApplicationContext apc = new ClassPathXmlApplicationContext("applicationContext.xml");
		JSONObject jsonobject = JSONObject.fromObject(transferString);

		item = new OrderinfoItem();

		item.setBookid((int)jsonobject.get("bookid"));
		item.setBooknum(Integer.valueOf((String)jsonobject.get("booknum")));
		item.setSinglePrice(Double.valueOf((String)jsonobject.get("singlePrice")));
		
		ActionContext actionContext = ActionContext.getContext();
		Map<String, Object> session = actionContext.getSession();
		Orderinfo order = (Orderinfo)session.get("cart");
		String userid = (String)session.get("userid");
		if (order == null){
			order = (Orderinfo)apc.getBean("orderinfo");
			order.setUserid(Integer.valueOf(userid));
		}
		
		item.calcPrice();
		order.addItem(item);
		session.put("cart", order);
		
		ServletActionContext.getResponse().setContentType("text/html");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		ServletActionContext.getResponse().getWriter().printf("add cart success");
		ServletActionContext.getResponse().getWriter().flush();
		ServletActionContext.getResponse().getWriter().close();
		apc.close();
		return null;
	}
	public OrderinfoItem getItem() {
		return item;
	}

	public void setItem(OrderinfoItem item) {
		this.item = item;
	}
	
	public String getTransferString() {
		return transferString;
	}

	public void setTransferString(String transferString) {
		this.transferString = transferString;
	}
}
