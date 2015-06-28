<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" import="controller.BookList, entity.Bookinfo, dao.UserinfoDao, entity.Userinfo" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="icon" href="http://v3.bootcss.com/favicon.ico">

        <title>Detail Display</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="css/dashboard.css" rel="stylesheet">
        

        <script src="js/ie-emulation-modes-warning.js"></script>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    	<script src="js/jquery.min.js"></script>
    	<script src="js/bootstrap.min.js"></script>
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
                    <a class="navbar-brand" href="<%=basePath%>BookList.action">BOOK STORE</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
						<li>
							<a href="<%=basePath %>Profile.jsp" id="showmoney"> Welcome, <%=session.getAttribute("username") %></a>
						</li>
						<li>
							<a href="<%=basePath%>ShoppingCart.jsp"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>My Cart</a>
						</li>
                        <li><a href="#" class="logout">Logout</a></li>
                        	
                        <% if (session.getAttribute("admin") != null){ %>
                        <li><a href="<%=basePath %>manageView.jsp" style="color:yellow">Manage Page</a></li>
                        <%} %>
                    </ul>
                </div>
            </div>
        </nav>		
        	

		<!--display category  -->
		<%
			
			Bookinfo book = (Bookinfo) session.getAttribute("book");
			if (book == null){
				String site = new String(basePath + "BookList.action");
    			response.setStatus(response.SC_MOVED_TEMPORARILY);
    			response.setHeader("Location", site);
			}
			
		%>
		
		<secton class="container-wrap">
			<div class="container">
				<div class="row">
					<div class="col-md-3 ">
						<span></span><br/>
						<span></span><br/>
						<span></span><br/>
						<span></span><br/>
						<span></span><br/>
						<td class="thumb"><img src="img/<%=book.getImage() %>" alt="Picture" class="img-rounded" onerror="this.src='book-default.jpg'"></td>
					</div>
					<div class="col-md-6">
						<h3><%=book.getBookname() %></h3>
                      		<hr>
                      		<span></span><br/>
                      		<span></span><br/>
                      		<span></span><br/>
                      		<span></span><br/>
                      		<p class="lead"><%=book.getDetail() %></p>
					</div>
					<div class="col-md-3">
						<span></span><br/>
						<span></span><br/>
						<span></span><br/>
						<span></span><br/>
						<span></span><br/>
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4>Add into Cart</h4>
							</div>
							<div class="panel-body">
								<div style="text-align:center;">
			                		<p class="lead">Price: <span id="price<%=book.getId() %>"><%=book.getPrice() %></span>$</p>
			                	</div>
			                	<br/>
			                	<div style="text-align:center;">
			                		<a class="btn btn-default" href="#" role="button" onclick="buyItem(<%=book.getId() %>)" >Buy it now</a>
								</div>
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</section>

        <div class="modal fade" id="successBuy" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        			<h3 class="lead">Pick up Book Successfully!</h3>
      			</div>
      			<div>
      				<span></span><br/>
      				<span></span><br/>
      				<p class="lead" style="text-align:center;">GO TO CART</p>
      				<p class="lead" style="text-align:center;">&</p>
      				<p class="lead" style="text-align:center;">ENJOY YOUR READING</p>
      				<span></span><br/>
      				<span></span><br/>
      			</div>
      			
      			<div class="modal-footer">
        			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
					$("#successBuy").modal("show");
				});
			}

		</script>
</html>
