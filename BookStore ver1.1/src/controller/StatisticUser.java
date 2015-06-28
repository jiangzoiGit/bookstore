package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;

import service.StatisticService;
import service.UserinfoService;

public class StatisticUser extends BaseAction{
	private static final long serialVersionUID = 1L;
	private ArrayList<Integer> ids;
	private String start;
	private String finish;
	public String execute() throws Exception{
		
		
		StatisticService statServ = this.getAllService().getStatisticService();
		UserinfoService userServ = this.getAllService().getUserinfoService();
		
		Map<String, Double> data = new HashMap<String, Double>();
		
		for (Iterator<Integer> it = ids.iterator(); it.hasNext();)
		{
			int uid = ((Integer)it.next()).intValue();
			Double value = Double.valueOf(statServ.statisticTotalConsumptionByUser(uid, start, finish));
			System.out.println(value);
			String username = userServ.getUserNameByID(uid);
			data.put(username, value);
		}
		
		
		
		
		List dataYear = statServ.statisticOrderByYear(start, finish);
		List dataMonth = statServ.statisticOrderByMonth(start, finish);
		List dataDay = statServ.statisticOrderByDay(start, finish);
		dataYear = filterIdsYear(dataYear);
		dataMonth = filterIdsMonth(dataMonth);
		dataDay = filterIdsDay(dataDay);

		
		ActionContext actionContext = ActionContext.getContext();
		Map<String, Object> session = actionContext.getSession();
		session.put("data", data);
		System.out.println("[Statistic:]" + ids.size());
		session.put("dataYear", dataYear);
		session.put("dataMonth", dataMonth);
		session.put("dataDay", dataDay);
		return null;
	}
	
	private boolean findUser(int value){
		for (Integer item : ids){
			if (item.intValue() == value)
				return true;
		}
		return false;
	}
	
	private boolean isUniqueYear(Map item, List newData){
		for (Object object :newData){
			Map<String, Object> oldItem = (Map<String, Object>) object;
			int yearOld = ((Integer)oldItem.get("year")).intValue();
			int yearNew = ((Integer)item.get("year")).intValue();
			if (yearOld == yearNew){
				double itemCost = ((Double)item.get("cost")).doubleValue();
				double oldCost = ((Double)oldItem.get("cost")).doubleValue();
				oldItem.put("cost", Double.valueOf(itemCost + oldCost));
				return false;
			}
		}
		return true;
	}
	
	private List filterIdsYear(List data){	
		List newData = new ArrayList();
		for (Iterator it = data.iterator(); it.hasNext();){
			Map item = (Map)(it.next());
			int userid = ((Integer)item.get("userid")).intValue();
			if (findUser(userid) ){
				if (isUniqueYear(item, newData))
				{
					newData.add(item);
				}
			}
		}
		return newData;
	}
	
	private boolean isUniqueMonth(Map item, List newData){
		for (Object object :newData){
			Map<String, Object> oldItem = (Map<String, Object>) object;
			int yearOld = ((Integer)oldItem.get("year")).intValue();
			int yearNew = ((Integer)item.get("year")).intValue();
			int monthOld = ((Integer)oldItem.get("month")).intValue();
			int monthNew = ((Integer)item.get("month")).intValue();
			if ((yearOld == yearNew) && (monthOld == monthNew)){
				double itemCost = ((Double)item.get("cost")).doubleValue();
				double oldCost = ((Double)oldItem.get("cost")).doubleValue();
				oldItem.put("cost", Double.valueOf(itemCost + oldCost));
				return false;
			}
		}
		return true;
	}
	
	private List filterIdsMonth(List data){	
		List newData = new ArrayList();
		for (Iterator it = data.iterator(); it.hasNext();){
			Map item = (Map)(it.next());
			int userid = ((Integer)item.get("userid")).intValue();
			if (findUser(userid) ){
				if (isUniqueMonth(item, newData))
				{
					newData.add(item);
				}
			}
		}
		return newData;
	}
	
	private boolean isUniqueDay(Map item, List newData){
		for (Object object :newData){
			Map<String, Object> oldItem = (Map<String, Object>) object;
			int yearOld = ((Integer)oldItem.get("year")).intValue();
			int yearNew = ((Integer)item.get("year")).intValue();
			int monthOld = ((Integer)oldItem.get("month")).intValue();
			int monthNew = ((Integer)item.get("month")).intValue();
			int dayOld = ((Integer)oldItem.get("day")).intValue();
			int dayNew = ((Integer)item.get("day")).intValue();
			if ((yearOld == yearNew) && (monthOld == monthNew) && (dayOld == dayNew)){
				double itemCost = ((Double)item.get("cost")).doubleValue();
				double oldCost = ((Double)oldItem.get("cost")).doubleValue();
				oldItem.put("cost", Double.valueOf(itemCost + oldCost));
				return false;
			}
		}
		return true;
	}
	
	private List filterIdsDay(List data){	
		List newData = new ArrayList();
		for (Iterator it = data.iterator(); it.hasNext();){
			Map item = (Map)(it.next());
			int userid = ((Integer)item.get("userid")).intValue();
			if (findUser(userid) ){
				if (isUniqueDay(item, newData))
				{
					newData.add(item);
				}
			}
		}
		return newData;
	}
	
	public ArrayList<Integer> getIds() {
		return ids;
	}
	public void setIds(ArrayList<Integer> ids) {
		this.ids = ids;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getFinish() {
		return finish;
	}
	public void setFinish(String finish) {
		this.finish = finish;
	}

}
