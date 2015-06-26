<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" import="controller.BookList, entity.Bookinfo, dao.UserinfoDao, entity.Userinfo" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="http://v3.bootcss.com/favicon.ico">

        <title>ENJOY BOOKS!</title>

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

		<!--display category  -->
		<%
			ArrayList<String> categoryList = (ArrayList<String>) session.getAttribute("categoryList");
			ArrayList<Bookinfo> bookList = (ArrayList<Bookinfo>) session.getAttribute("bookList");
		%>
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-3 col-md-2 sidebar">
                    <ul class="nav nav-sidebar">
                    	<%
                    		boolean flag = false;
                    		int count = 0;
                    		for (Iterator<String> it = categoryList.iterator(); it.hasNext();){
                    			count++;
                    			if (flag == false){
                    	%>
                    				<li id="<%=count%>" class="nav_category active"><a herf="#" ><%=(String)it.next() %><span class="sr-only">(current)</span></a>
                    	<%
                    				flag = true;
                    			}else{
                    	%>
                    				<li id="<%=count%>" class="nav_category"><a herf="#"><%=(String)it.next() %><span class="sr-only">(current)</span></a>
                    	<%
                    			}
                    		}
                    	%>
                        <%-- <li class="active"><a href="#">Overview <span class="sr-only">(current)</span></a></li> --%>
                    </ul>
                </div>
                
                
                <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                    <h2 class="sub-header">Enjoy yourself</h2>
                    <div class="container">
                        <%
                  			if (bookList == null){
                  		%>
                  		<h1>There is no book to sell~</h1>
                  		<hr>
                  		<%
                  			}
                  			else{
                  				count = 0;
                  				int colunmCount;
                  				for (Iterator<String> categoryIt = categoryList.iterator(); categoryIt.hasNext();){
                  					String categoryName = (String) categoryIt.next();
                  					count++;
                  					colunmCount = 0;
                  					%>
                  					<div class="col-md-12" id="tab<%=count %>" style="display:none;">
                  						<ul class="inline">
                  						
                  					<%
                  					for (Iterator<Bookinfo> it = bookList.iterator(); it.hasNext();){
                  						Bookinfo bookBean = (Bookinfo) it.next();
                  						if (categoryName.equals(bookBean.getCategory())){
                  							colunmCount++;
                  							if (colunmCount % 5 == 1){
                  								%>
                  								</ul>
                  								<ul class="inline">
                  								<%
                  							}
                  							%>
                  							<li>
                  								<h3><span id="bookname<%=bookBean.getId() %>"><%=bookBean.getBookname() %></span></h3>
                        						<img class="img-thumbnail" alt="200x200" src="img/<%=bookBean.getImage() %>" data-holder-rendered="true">
                        						<p id="<%="image" + bookBean.getId()%>"
													style="visibility: hidden"><%=bookBean.getImage()%></p>
                        						<%-- <p><%=bookBean.getDetail() %></p><br> --%>
                        						<p>Stock: <span id="booknum<%=bookBean.getId() %>"><%=bookBean.getBooknum() %></span></p>
                        						<p>Price: <span id="price<%=bookBean.getId() %>"><%=bookBean.getPrice() %></span>$</p>
                        						<p>Category: <span id="category<%=bookBean.getCategory() %>"><%=bookBean.getCategory() %></span><p><br>
                        						<a class="btn btn-default" href="#" role="button" onclick="buyItem(<%=bookBean.getId() %>)">Add into Cart!</a>
                  							</li>	
                  							<%
                  						}
                  					}
                  					%>
                  						</ul>
                  					</div>
                  					<%                  					                  					
                  				}
                  			}
                  		%>
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
			
			var lastTab = "#tab1";
			$("#tab1").show();
			
			$(".nav_category").on("click", function(e){
				$(lastTab).hide();
				$("#" + "tab" + this.id).show();
				lastTab = "#" + "tab" + this.id;
				$(".active").removeClass("active");
				$(this).addClass("active");
			});
			function item(bookid, booknum, singlePrice){
				this.bookid = bookid;
				this.booknum = booknum;
				this.singlePrice = singlePrice;
			}
			
			
			function buyItem(id){
				var bookid = id;
				var booknum = "1";
				var singlePrice = $("#price"+id).text();
				var JSONString = JSON.stringify(new item(bookid, booknum, singlePrice));
				
				$.get("AddCart.action", "transferString=" + JSONString, function(data){
					alert(data);
				});
			}
			
		</script>
</html>
