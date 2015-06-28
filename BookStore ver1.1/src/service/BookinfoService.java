package service;

import dao.AllDao;
import dao.BookinfoDao;
import dao.UserinfoDao;
import entity.Bookinfo;

import java.util.ArrayList;

public class BookinfoService {
	private AllDao allDao;
	
	public AllDao getAllDao() {
		return allDao;
	}

	public void setAllDao(AllDao allDao) {
		this.allDao = allDao;
	}
	
	public ArrayList<Bookinfo> getAllBookAboutName(String bookname){
		BookinfoDao bookinfoDao = this.getAllDao().getBookinfoDao();
		ArrayList<Bookinfo> bookList = bookinfoDao.getAllBookAboutName(bookname);
		return bookList;
	}

	public boolean createBook(Bookinfo book){
		BookinfoDao bookinfoDao = this.getAllDao().getBookinfoDao();
		if(bookinfoDao.createBook(book) == true)
			return true;
		return false;
	}
	
	public boolean deleteBookById(String id){
		BookinfoDao bookinfoDao = this.getAllDao().getBookinfoDao();
		if(bookinfoDao.deleteBookById(id) == true)
			return true;
		return false;
	}

	public boolean updateBook(Bookinfo book){
		BookinfoDao bookinfoDao = this.getAllDao().getBookinfoDao();
		if(bookinfoDao.updateBook(book) == true)
			return true;
		return false;
	}
	
	
	public Bookinfo findBookByIsbn(String Isbn){
		BookinfoDao bookinfoDao = this.getAllDao().getBookinfoDao();
		Bookinfo book = bookinfoDao.findBookByIsbn(Isbn);
		return book;
	}
	
	public Bookinfo findBookById(String bookid){
		BookinfoDao bookinfoDao = this.getAllDao().getBookinfoDao();
		Bookinfo book = bookinfoDao.findBookById(bookid);
		return book;
	}
	
	public ArrayList<Bookinfo> findBookByName(String bookname){
		BookinfoDao bookinfoDao = this.getAllDao().getBookinfoDao();
		ArrayList<Bookinfo> bookList = bookinfoDao.findBookByName(bookname);
		return bookList;
	}
	
	public ArrayList<Bookinfo> getAllBook()
	{
		BookinfoDao bookinfoDao = this.getAllDao().getBookinfoDao();
		ArrayList<Bookinfo> bookList = bookinfoDao.getAllBook();
		return bookList;
	}
	
	public ArrayList<String> getAllCategory()
	{
		BookinfoDao bookinfoDao = this.getAllDao().getBookinfoDao();
		ArrayList<String> categoryList = bookinfoDao.getAllCategory();
		return categoryList;
	}
	
	public String getBookNameById(int bid){
		BookinfoDao bookinfoDao = this.getAllDao().getBookinfoDao();
		return bookinfoDao.getBookNameById(bid);
	}
}
