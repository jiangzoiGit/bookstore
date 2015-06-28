package test.util;

import java.util.ArrayList;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import dao.BookinfoDao;
import dao.MongodbDao;
import dao.StatisticDao;
import entity.Bookinfo;
import controller.*;

public class testDao {

	public static void main(String[] args) throws Exception{
		AbstractApplicationContext apc = new ClassPathXmlApplicationContext("applicationContext.xml");
		MongodbDao mongodbDao = (MongodbDao)apc.getBean("mongodbDao");
		apc.close();
		mongodbDao.deletePhoto("1");
		System.out.println(mongodbDao.findPhoto("1"));
	}

}
