package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionContext;
import service.BookinfoService;
import service.StatisticService;

public class StatisticCategory extends BaseAction{
	private static final long serialVersionUID = 1L;
	private ArrayList<String> ids;
	private String start;
	private String finish;
	public String execute() throws Exception{
		
		
		StatisticService statServ = this.getAllService().getStatisticService();
		
		Map<String, Double> data = new HashMap<String, Double>();
		
		for (Iterator<String> it = ids.iterator(); it.hasNext();)
		{
			String category = (String)it.next();
			Double value = Double.valueOf(statServ.statisticTotalConsumptionByCategory(category, start, finish));
			data.put(category, value);
		}
		
		List dataYear = statServ.statisticCategoryByYear(start, finish);
		List dataMonth = statServ.statisticCategoryByMonth(start, finish);
		List dataDay = statServ.statisticCategoryByDay(start, finish);
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
	
	private boolean findCategory(String value){
		for (String item : ids){
			if (item.equals(value))
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
				double itemSells = ((Double)item.get("sells")).doubleValue();
				double oldSells = ((Double)oldItem.get("sells")).doubleValue();
				oldItem.put("sells", Double.valueOf(itemSells + oldSells));
				return false;
			}
		}
		return true;
	}
	
	private List filterIdsYear(List data){	
		List newData = new ArrayList();
		for (Iterator it = data.iterator(); it.hasNext();){
			Map item = (Map)(it.next());
			String category = (String)item.get("category");
			if (findCategory(category) ){
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
				double itemSells = ((Double)item.get("sells")).doubleValue();
				double oldSells = ((Double)oldItem.get("sells")).doubleValue();
				oldItem.put("sells", Double.valueOf(itemSells + oldSells));
				return false;
			}
		}
		return true;
	}
	
	private List filterIdsMonth(List data){	
		List newData = new ArrayList();
		for (Iterator it = data.iterator(); it.hasNext();){
			Map item = (Map)(it.next());
			String category = (String)item.get("category");
			if (findCategory(category) ){
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
				double itemSells = ((Double)item.get("sells")).doubleValue();
				double oldSells = ((Double)oldItem.get("sells")).doubleValue();
				oldItem.put("sells", Double.valueOf(itemSells + oldSells));
				return false;
			}
		}
		return true;
	}
	
	private List filterIdsDay(List data){	
		List newData = new ArrayList();
		for (Iterator it = data.iterator(); it.hasNext();){
			Map item = (Map)(it.next());
			String category = (String)item.get("category");
			if (findCategory(category) ){
				if (isUniqueDay(item, newData))
				{
					newData.add(item);
				}
			}
		}
		return newData;
	}
	
	public ArrayList<String> getIds() {
		return ids;
	}
	public void setIds(ArrayList<String> ids) {
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
