package test.util;

import java.util.ArrayList;

import dao.BookinfoDao;
import entity.Bookinfo;

public class testDao {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		BookinfoDao bookinfoDao = new BookinfoDao();
		int result = bookinfoDao.getAllCategory().size();
		System.out.println("result = " + result);
	}

}
