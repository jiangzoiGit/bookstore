package service;

import java.util.List;
import dao.AllDao;

public class StatisticService {
	private AllDao allDao;
	
	public double statisticTotalConsumptionByUser(int uid, String start, String finish){
		return this.allDao.getStatisticDao().searchOrderByUser(uid, start, finish);
	}
	
	public double statisticTotalConsumptionByBook(int bookid, String start, String finish){
		return this.allDao.getStatisticDao().searchOrderByBook(bookid, start, finish);
	}
	
	public double statisticTotalConsumptionByCategory(String category, String start, String finish){
		return this.allDao.getStatisticDao().searchOrderByCategory(category, start, finish);
	}
	
	public List statisticOrderByYear(String start, String finish){
		return this.allDao.getStatisticDao().searchOrderByYear(start, finish);
	}
	
	public List statisticOrderByMonth(String start, String finish){
		return this.allDao.getStatisticDao().searchOrderByMonth(start, finish);
	}
	
	public List statisticOrderByDay(String start, String finish){
		return this.allDao.getStatisticDao().searchOrderByDay(start, finish);
	}
	
	public List statisticOrderItemByDay(String start, String finish){
		return this.allDao.getStatisticDao().searchOrderItemByDay(start, finish);
	}
	
	public List statisticOrderItemByMonth(String start, String finish){
		return this.allDao.getStatisticDao().searchOrderItemByMonth(start, finish);
	}
	
	public List statisticOrderItemByYear(String start, String finish){
		return this.allDao.getStatisticDao().searchOrderItemByYear(start, finish);
	}
	
	public List statisticCategoryByYear(String start, String finish){
		return this.allDao.getStatisticDao().searchCategoryByYear(start, finish);
	}
	
	public List statisticCategoryByMonth(String start, String finish){
		return this.allDao.getStatisticDao().searchCategoryByMonth(start, finish);
	}
	
	public List statisticCategoryByDay(String start, String finish){
		return this.allDao.getStatisticDao().searchCategoryByDay(start, finish);
	}
	
	public AllDao getAllDao() {
		return allDao;
	}

	public void setAllDao(AllDao allDao) {
		this.allDao = allDao;
	} 
}
