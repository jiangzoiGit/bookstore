<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" import="entity.Orderinfo, entity.OrderinfoItem, entity.Userinfo, dao.BookinfoDao, entity.Bookinfo" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="http://v3.bootcss.com/favicon.ico">

        <title>Shopping Cart</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="css/dashboard.css" rel="stylesheet">
        <link href="css/myStyle.css" rel="stylesheet">

        <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
        <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
        <script src="js/ie-emulation-modes-warning.js"></script>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    	<script src="js/jquery.min.js"></script>
    	<script src="js/bootstrap.min.js"></script>
    	
    	<style>
            .table th, .table td { 
				text-align: center;
				vertical-align: middle; 
				height:38px;
			}
        </style>
    <body>
    
    <!--get base path  -->
    <%
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	%>
	
    <%
    		//set the decimal format
    		java.text.DecimalFormat df = new java.text.DecimalFormat("#.00");
    		if (session.getAttribute("username") == null){
    			String site = new String(basePath + "index.jsp");
    			response.setStatus(response.SC_MOVED_TEMPORARILY);
    			response.setHeader("Location", site);
    		}
    %>
    	
	<!--Navigation bar on the top of page  -->
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="<%=basePath%>bookList.jsp">BOOK STORE</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
						<li>
							<a href="#" id="showmoney"> Welcome, <%=session.getAttribute("username") %></a>
						</li>
						<li>
							<a href="<%=basePath%>ShoppingCart.jsp"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true">My Cart</span></a>
						</li>
                        <li><a href="#" class="logout">Logout</a></li>
                        	
                        <% if (session.getAttribute("admin") != null){ %>
                        <li><a href="<%=basePath %>manageView.jsp" style="color:yellow">Manage Page</a></li>
                        <%} %>
                    </ul>
                    <form class="navbar-form navbar-right">
                        <input type="text" name="bookname"  class="class java.util.HashMap form-control" placeholder="Search...">
                    </form>
                </div>
            </div>
        </nav>			
        
        <!--Shopping Cart  -->
        <%
        	Orderinfo order = (Orderinfo)session.getAttribute("cart");
        	if (order == null){
        		order = new Orderinfo();
        	}
        	order.calcTotal();
        %>
		<div class="container theme-showcase" role="main">
			<div class="jumbotron">
        				<div>
				            	<h2 class="title">Shopping cart</h2>
				            
				            	<table class="table">
				              	<tbody id="shoppingTable">
				              	<tr>
				                  <th>Book name</th>
				                  <th>Book price</th>
				                  <th>Book number</th>
				                  <th>Total</th>
				                  <th></th>
				                </tr>
				                
				                <%
				                	
				                	Set<OrderinfoItem> itemList = (Set<OrderinfoItem>)order.getItemlist();
				                	BookinfoDao bookinfoDao = new BookinfoDao();
				                
				                	if (itemList == null){
				                	}
				                	else{
				                		for (Iterator<OrderinfoItem> it = itemList.iterator(); it.hasNext();){
				                			OrderinfoItem item = (OrderinfoItem)it.next();
				                			item.calcPrice();
				                %>
				                <!--Item-->
				                <tr class="item first">
				                  <td class="bookname" style="vertical-align: middle;"><%=bookinfoDao.findBookById(String.valueOf(item.getBookid())).getBookname() %></td>
				                  <td style="vertical-align: middle;"><span class="price"><%=item.getSinglePrice() %></span> $</td>
				                  <td class="booknum" style="vertical-align: middle;"><%=item.getBooknum() %></td>
				                  <td style="vertical-align: middle;"><span class="total"><%=df.format(item.getTotalPrice()) %></span> $</td>
				                  <td style="vertical-align: middle;">
				                  	<button type="button" class="btn btn-default modifyItem" aria-label="Left Align">
				                  		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
				                  		<span style="visibility: hidden"><%=item.getBookid() %></span>
									</button>
								  	<button type="button" class="btn btn-default deleteItem" aria-label="Left Align">
				                  		<span class="glyphicon glyphicon-remove-circle" aria-hidden="true"></span>
				                  		<span style="visibility: hidden"><%=item.getBookid() %></span>
									</button>
								  </td>
				                </tr>
				                <%
				                		}
				                	}
				                %>
				              	</tbody>
				              </table>
				            </div>
				            <div>
				            	<s:form role="form" action="Pay">
									<input class="btn btn-primary" type="submit" value="Pay">	
								</s:form>			            
				            </div>
      		</div>
		</div>
		
	<div>
		<div class="modal fade" id="updateForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        			<h4 class="modal-title" id="myModalLabel">Update Cart Form</h4>
      			</div>
      			<div class="modal-body">
        			<table class="table">
        				<tbody>
        					<tr>
				                  <th>Book name</th>
				                  <th>Book price</th>
				                  <th>Book number</th>
				                  <th>Total</th>
				            </tr>
        					<tr>
        						<td style="vertical-align: middle;" id="updateFormBookName"></td>
				                <td style="vertical-align: middle;" id="updateFormBookPrice"></td>
				                <td class="qnt-count" style="vertical-align: middle;">
				                    <a class="incr-btn" href="#">-</a>
				                    <input id="updateFormBookNum" class="quantity" type="text" value="0"/>
				                    <a class="incr-btn" href="#">+</a>
				                </td>
				                <td style="vertical-align: middle;" id="updateFormTotal"></td>
				                <td style="visibility: hidden;" id="updateFormId"></td>
        					<tr>
        				</tbody>
        			</table>
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        			<button type="button" class="btn btn-primary" onclick="submitUpdateForm()">Confirm</button>
      			</div>
    		</div>
  		</div>
  	</div>
        
		<script>
			$(".logout").on("click",function(e){
				var tempForm = document.createElement("form");
				tempForm.method = "POST";
				tempForm.action = "<%=basePath%>logout.action";
				tempForm.submit();
			});
			
			$(".incr-btn").on("click", function(e) {
				var $button = $(this);
				var oldValue = $button.parent().find("input").val();
				if ($button.text() == "+") {
					var newVal = parseFloat(oldValue) + 1;
				} else {
				 // Don't allow decrementing below 1
					if (oldValue > 1) {
						var newVal = parseFloat(oldValue) - 1;
					} else {
						newVal = 1;
					}
				}
				$button.parent().find("input").val(newVal);
				var price = $("#updateFormBookPrice").text() * 1.0 * newVal;
				$("#updateFormTotal").html(price.toFixed(2));
				
				e.preventDefault();
			});
			
			$(".modifyItem").on("click", function(e){
				var $button = $(this);
				var bookName = $button.parent().parent().find("td").eq(0).text();
				var price = $button.parent().parent().find("td").eq(1).find("span").text();
				var booknum = $button.parent().parent().find("td").eq(2).text();
				var total = $button.parent().parent().find("td").eq(3).find("span").text();
				var id = $button.find("span").eq(1).text();
				$("#updateFormId").html(id);
				$("#updateFormBookName").html(bookName);
				$("#updateFormBookPrice").html((price * 1.0).toFixed(2));
				$("#updateFormBookNum").val(booknum);
				$("#updateFormTotal").html((total * 1.0).toFixed(2));
				
				$("#updateForm").modal('show');
				
			});
			
			$(".deleteItem").on("click", function(e){
				var $button = $(this);
				var id = $button.find("span").eq(1).text();
				var tempForm = document.createElement("form");
				tempForm.method = "POST";
				tempForm.id = "deleteBookItem";
				tempForm.name = "deleteBookItem";
				
				var input = document.createElement("input");
				input.class = "class java.util.HashMap";
				input.type = "text";
				input.name = "newItem.bookid";
				input.value = id;
				tempForm.appendChild(input);
				
				tempForm.action = "<%=basePath%>DeleteCartItem.action";
				tempForm.submit();
			});
			
			function submitUpdateForm(){
				var tempForm = document.createElement("form");
				tempForm.method = "POST";
				tempForm.id = "updateBookItem";
				tempForm.name = "updateBookItem";
				
				var input = document.createElement("input");
				input.class = "class java.util.HashMap";
				input.type = "text";
				input.name = "newItem.bookid";
				input.value = $("#updateFormId").text();
				tempForm.appendChild(input);
				
				input = document.createElement("input");
				input.class = "class java.util.HashMap";
				input.type = "text";
				input.name = "newItem.booknum";
				input.value = $("#updateFormBookNum").val();
				tempForm.appendChild(input);
				tempForm.action = "<%=basePath%>UpdateCartItem.action";
				tempForm.submit();
			}
		</script>
</html>
