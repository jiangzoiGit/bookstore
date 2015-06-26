package controller;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import entity.Bookinfo;

public class AddBookItem extends ActionSupport{
	private ArrayList itemList = null;
	private Bookinfo newBook;
	
	public boolean addBookItemById(Bookinfo newBook){
		
		System.out.print("NewBook: [bookid]=" + newBook.getId() + " [bookname]=" + newBook.getBookname() 
						 + " [booknum]=" + newBook.getBooknum() + " [bookprice]=" + newBook.getPrice() 
						 + " [image]" + newBook.getImage() + "\n");
		
		
		ActionContext actionContext = ActionContext.getContext();
		Map session = actionContext.getSession();
		
		itemList = (ArrayList)session.get("cartContent");
		
		boolean existInCart = false;
		if (itemList != null){
			for (Iterator it = itemList.iterator(); it.hasNext();){
				//check if this book item is existed in Cart
				Bookinfo book = (Bookinfo)it.next();
				if (book.getId().equals(newBook.getId())){
					existInCart = true;
					book.setBooknum(book.getBooknum() + newBook.getBooknum());
					break;
				}
			}
		}
		else{
			itemList = new ArrayList();
		}
		
		if (existInCart == false){
			itemList.add(newBook);
		}
		
		session.put("cartContent", itemList);
		return true;
	}
	
	public String execute(){
		if (addBookItemById(newBook) == false)
			return "fail";
		return "success";
	}

	public Bookinfo getNewBook() {
		return newBook;
	}

	public void setNewBook(Bookinfo newBook) {
		this.newBook = newBook;
	}
}
