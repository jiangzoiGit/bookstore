package dao;

public class AllDao {
	private UserinfoDao userinfoDao;
	private BookinfoDao bookinfoDao;
	private OrderinfoDao orderinfoDao;
	private StatisticDao statisticDao;
	private MongodbDao mongodbDao;

	public BookinfoDao getBookinfoDao() {
		return bookinfoDao;
	}

	public void setBookinfoDao(BookinfoDao bookinfoDao) {
		this.bookinfoDao = bookinfoDao;
	}

	public UserinfoDao getUserinfoDao() {
		return userinfoDao;
	}

	public void setUserinfoDao(UserinfoDao userinfoDao) {
		this.userinfoDao = userinfoDao;
	}

	public OrderinfoDao getOrderinfoDao() {
		return orderinfoDao;
	}

	public void setOrderinfoDao(OrderinfoDao orderinfoDao) {
		this.orderinfoDao = orderinfoDao;
	}

	public StatisticDao getStatisticDao() {
		return statisticDao;
	}

	public void setStatisticDao(StatisticDao statisticDao) {
		this.statisticDao = statisticDao;
	}

	public MongodbDao getMongodbDao() {
		return mongodbDao;
	}

	public void setMongodbDao(MongodbDao mongodbDao) {
		this.mongodbDao = mongodbDao;
	}
	
}
