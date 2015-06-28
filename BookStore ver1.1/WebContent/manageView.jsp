<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page language="java" import="dao.BookinfoDao, dao.UserinfoDao, org.springframework.context.support.AbstractApplicationContext, 
org.springframework.context.support.ClassPathXmlApplicationContext, entity.Bookinfo, entity.Userinfo" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="http://v3.bootcss.com/favicon.ico">

        <title>Manage View</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="css/dashboard.css" rel="stylesheet">

        <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
        <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
        <script src="js/ie-emulation-modes-warning.js"></script>
        <script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
      <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <body>
    
    	<!--get base path  -->
    	<%
			String path = request.getContextPath();
			String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		%>
		
    	<%
    		if (session.getAttribute("error_user_exist") != null){
    	%>
    	<div class="alert alert-warning alert-dismissible fade in" role="alert">
      		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
      		<strong>The user you want to create is existed!</strong> Best check yourself.
    	</div>
    	<%
    			session.setAttribute("error_user_exist", null);
    		}
    	%>
    	
    	<%
    	if(session.getAttribute("admin") == null){
    			String site = new String(basePath + "BookList.action");
    			response.setStatus(response.SC_MOVED_TEMPORARILY);
    			response.setHeader("Location", site);     	
    	}
    	%>

        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="<%=basePath %>manageView.jsp">Book Store Manage</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="<%=basePath %>Profile.jsp">Welcome, <%=session.getAttribute("username") %><span class=""></a></li>
                        <li><a href="#" class="logout">Logout</a></li>
                        <% if (session.getAttribute("admin") != null){ %>
                        <li><a href="<%=basePath %>BookList.action" style="color:yellow">Customer Page</a></li>
                        <%} %>
                    </ul>
                </div>
            </div>
        </nav>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-9 col-sm-offset-2 col-md-10 col-md-offset-1 main">
				<h1 class="page-header">Operation</h1>
				<ul class="nav nav-tabs" role="tablist" id="myTab">
					<li role="presentation" class="active"><a href="#bookManage"
						aria-controls="bookManage" role="tab" data-toggle="tab">Book
							Manage</a></li>
					<li role="presentation"><a href="#userManage"
						aria-controls="userManage" role="tab" data-toggle="tab">User
							Manage</a></li>
				</ul>
				<div class="row placeholders"></div>
				<div class="tab-content">
					<!-- Book manage part -->
					<div role="tabpanel" class="tab-pane active" id="bookManage">
						<div class="container">
							<table>
								<tr>
									<td>
										<button type="button" class="btn btn-primary"
										data-toggle="modal" data-target="#createBookForm">Add Book
										</button>
										<a type="button" href="<%=basePath %>statistic.jsp" class="btn btn-primary"
										data-toggle="modal">Statistic
										</a>
									</td>
									<td>
										<form id="retrieveBook" name="retrieveBook"class="navbar-form" action="<%=basePath %>retrieveBook.action" method="post" role="form">
                        					<input type="text" name="bookname" class="class java.util.HashMap form-control" placeholder="Search...">
                    					</form>
									</td>
								</tr>
							</table>
							
							<h1></h1>
							<%
								AbstractApplicationContext apc = new ClassPathXmlApplicationContext("applicationContext.xml");
								BookinfoDao bookinfoDao = (BookinfoDao)apc.getBean("bookinfoDao");	
								ArrayList<Bookinfo> bookList = bookinfoDao.getAllBook();
								
								if (bookList == null) {
							%>
							<h1>There is no book to display</h1>
							<hr>
							<%
								} else {
									for (Iterator<Bookinfo> it = bookList.iterator(); it.hasNext();) {
										Bookinfo bookBean = (Bookinfo) it.next();
							%>
							<div class="col-md-4">
								<h3 id="<%="bookname" + bookBean.getId()%>"><%=bookBean.getBookname()%></h3>
								<img class="img-responsive" alt="200x200"
									src="img/<%=bookBean.getImage()%>" data-holder-rendered="true">
								<p id="<%="image" + bookBean.getId()%>"
									style="visibility: hidden"><%=bookBean.getImage()%></p>
								<div style="display:none;"><p id="<%="abstractInfo" + bookBean.getId()%>" style="display:none;"><%=bookBean.getAbstractInfo()%></p></div>
								<div style="display:none;"><p id="<%="detail" + bookBean.getId()%>" ><%=bookBean.getDetail()%></p></div>
								<br> 
								<p>ISBN:<span id="<%="ISBN" + bookBean.getId()%>"><%=bookBean.getIsbn()%></span></p>
								<p>Stock:<span id="<%="booknum" + bookBean.getId()%>"><%=bookBean.getBooknum()%></span></p>
								<p>Price:<span id="<%="price" + bookBean.getId()%>"><%=bookBean.getPrice()%></span></p>
								<p>Category:<span id="<%="category" + bookBean.getId() %>"><%=bookBean.getCategory() %></span></p>
								<br>
								<a class="btn btn-default" href="#" role="button"
									onclick="deleteBookFunc(<%=bookBean.getId()%>)">Delete</a> <a
									class="btn btn-default" href="#" role="button"
									onclick="updateBookFunc(<%=bookBean.getId()%>)">Update</a>
								<hr>
							</div>
							<%
									}
								}
							%>
						</div>
					</div>
					<!-- User manage part -->
					<div role="tabpanel" class="tab-pane" id="userManage">
						<div class="container">
							<button type="button" class="btn btn-primary"
								data-toggle="modal" data-target="#createUserForm">Add User
							</button>
							<h1></h1>
							<%
								UserinfoDao userinfoDao = (UserinfoDao)apc.getBean("userinfoDao");
								ArrayList<Userinfo> userList = userinfoDao.getAllUser();
								apc.close();
								if (userList == null) {
							%>
							<h1>There is no user~</h1>
							<hr>
							<%
								} else {
									
							%>
							<table class="table table-hover">
								<thead>
							        <tr>
							          <th>ID</th>
							          <th>Username</th>
							          <th>Password</th>
							          <th>Balance</th>
							          <th>Action</th>
							        </tr>
							      </thead>
							      <tbody>
							<%
									java.text.DecimalFormat df = new java.text.DecimalFormat("#.00");
									for (Iterator<Userinfo> it = userList.iterator(); it.hasNext();) {
										Userinfo userBean = (Userinfo) it.next();
										if (userBean.getPrivilege().equals("0"))
											continue;
							%>
							        <tr>
							          <th id="<%="id" + userBean.getId()%>"><%=userBean.getId()%></th>
							          <td id="<%="username" + userBean.getId()%>"><%=userBean.getUsername()%></td>
							          <td id="<%="password" + userBean.getId()%>"><%=userBean.getPassword()%></td>
							          <td id="<%="balance" + userBean.getId() %>"><%=df.format(userBean.getBalance()) %></td> 
							          <td>
							          	<a class="btn btn-default" href="#" role="button"
										onclick="deleteUserFunc(<%=userBean.getId()%>)">Delete</a>
										<a class="btn btn-default" href="#" role="button"
										onclick="updateUserFunc(<%=userBean.getId()%>)">Update</a>
							          </td>
							        </tr>
							<%
									}
								}
							%>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- Create Book Form -->
	<div class="modal fade" id="createBookForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        			<h4 class="modal-title" id="myModalLabel">Add Book Form</h4>
      			</div>
      			<div class="modal-body">
        			<s:form role="form" action="createBook">
						<label class="control-label">Bookname:</label>
						<input type="text" name="bookinfo.bookname" id="createBook_bookinfo_bookname" placeholder="Bookname" class="class java.util.HashMap form-control"/>
						<label class="control-label">Img Path:</label>	    				
	    				<input type="text" name="bookinfo.image" id="createBook_bookinfo_image" placeholder="Image Path" class="class java.util.HashMap form-control"/>
	    				<label class="control-label">AbstractInfo:</label>	    				
	    				<input type="text" name="bookinfo.abstractInfo" id="createBook_bookinfo_detail" placeholder="AbstractDetail" class="class java.util.HashMap form-control"/>
	    				<label class="control-label">Detail:</label>	    				
	    				<input type="text" name="bookinfo.detail" id="createBook_bookinfo_detail" placeholder="Detail" class="class java.util.HashMap form-control"/>
	    				<label class="control-label">ISBN:</label>	    				
	    				<input type="text" name="bookinfo.isbn" id="createBook_bookinfo_ISBN" placeholder="ISBN" class="class java.util.HashMap form-control"/>
	    				<label class="control-label">Booknum:</label>	    				
	    				<input type="text" name="bookinfo.booknum" id="createBook_bookinfo_booknum" placeholder="Booknum" class="class java.util.HashMap form-control"/>
	    				<label class="control-label">Price:</label>	    				
	    				<input type="text" name="bookinfo.price" id="createBook_bookinfo_price" placeholder="price" class="class java.util.HashMap form-control"/>
	    				<label class="control-label">Category:</label>	    				
	    				<input type="text" name="bookinfo.category" id="createBook_bookinfo_category" placeholder="category" class="class java.util.HashMap form-control"/>
					</s:form> 
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        			<button type="button" class="btn btn-primary" onclick="submitCreateBookForm()">Confirm</button>
      			</div>
    		</div>
  		</div>
	</div>
	
	<!-- Create User Form -->
	<div class="modal fade" id="createUserForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        			<h4 class="modal-title" id="myModalLabel">Add User Form</h4>
      			</div>
      			<div class="modal-body">
        			<s:form role="form" action="createUser">
						<label class="control-label">Username:</label>
						<input type="text" name="userinfo.username" id="createBook_userinfo_username" placeholder="Username" class="class java.util.HashMap form-control"/>
	    				<label class="control-label">Password:</label>	    				
	    				<input type="text" name="userinfo.password" id="createBook_userinfo_password" placeholder="Password" class="class java.util.HashMap form-control"/>
						<label class="control-label">Balance:</label>	    				
	    				<input type="text" name="userinfo.balance" id="createBook_userinfo_balance" placeholder="Balance" class="class java.util.HashMap form-control"/>
					</s:form> 
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        			<button type="button" class="btn btn-primary" onclick="submitCreateUserForm()">Confirm</button>
      			</div>
    		</div>
  		</div>
	</div>
	
	<div class="modal fade" id="deleteConfirmForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        			<h4 class="modal-title" id="myModalLabel">Delete Confirm Form</h4>
      			</div>
      			<div class="modal-body">
      				<p>Are you sure to delete it?</p>
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-default" data-dismiss="modal" onclick="cancelSubmitForm()" >Close</button>
        			<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="submitForm()" >Confirm</button>
      			</div>
    		</div>
  		</div>
	</div>
	
	<div class="modal fade" id="updateForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        			<h4 class="modal-title" id="myModalLabel">Update Book Form</h4>
      			</div>
      			<div class="modal-body">
        			<s:form role="form" action="updateBook">
        				<label class="control-label">Bookid:</label>
						<input type="text" name="bookinfo.id" id="updateBook_bookinfo_id" placeholder="Bookid" class="class java.util.HashMap form-control" readonly/>
						<label class="control-label">Bookname:</label>
						<input type="text" name="bookinfo.bookname" id="updateBook_bookinfo_bookname" placeholder="Bookname" class="class java.util.HashMap form-control"/>
						<label class="control-label">Img Path:</label>	    				
	    				<input type="text" name="bookinfo.image" id="updateBook_bookinfo_image" placeholder="Image Path" class="class java.util.HashMap form-control"/>
	    				<label class="control-label">AbstractInfo:</label>	    				
	    				<input type="text" name="bookinfo.abstractInfo" id="updateBook_bookinfo_abstractInfo" placeholder="AbstractInfo" class="class java.util.HashMap form-control"/>
	    				<label class="control-label">Detail:</label>	    				
	    				<input type="text" name="bookinfo.detail" id="updateBook_bookinfo_detail" placeholder="Detail" class="class java.util.HashMap form-control"/>
	    				<label class="control-label">ISBN:</label>	    				
	    				<input type="text" name="bookinfo.isbn" id="updateBook_bookinfo_ISBN" placeholder="ISBN" class="class java.util.HashMap form-control"/>
	    				<label class="control-label">Booknum:</label>	    				
	    				<input type="text" name="bookinfo.booknum" id="updateBook_bookinfo_booknum" placeholder="Booknum" class="class java.util.HashMap form-control"/>
	    				<label class="control-label">Price:</label>	    				
	    				<input type="text" name="bookinfo.price" id="updateBook_bookinfo_price" placeholder="price" class="class java.util.HashMap form-control"/>
	    				<label class="control-label">Category:</label>	    				
	    				<input type="text" name="bookinfo.category" id="updateBook_bookinfo_category" placeholder="category" class="class java.util.HashMap form-control"/>
					</s:form> 
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        			<button type="button" class="btn btn-primary" onclick="submitUpdateBookForm()">Confirm</button>
      			</div>
    		</div>
  		</div>
	</div>
	
	<div class="modal fade" id="updateUserForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        			<h4 class="modal-title" id="myModalLabel">Update User Form</h4>
      			</div>
      			<div class="modal-body">
        			<s:form role="form" action="updateUser">
        				<label class="control-label">Userid:</label>
						<input type="text" name="userinfo.id" id="updateUser_userinfo_id" placeholder="Userid" class="class java.util.HashMap form-control" readonly/>
						<label class="control-label">Username:</label>
						<input type="text" name="userinfo.username" id="updateUser_userinfo_username" placeholder="Username" class="class java.util.HashMap form-control"/ readonly>
						<label class="control-label">Password:</label>	    				
	    				<input type="text" name="userinfo.password" id="updateUser_userinfo_password" placeholder="Password" class="class java.util.HashMap form-control"/>
	    				<label class="control-label">Balance:</label>	    				
	    				<input type="text" name="userinfo.balance" id="updateUser_userinfo_balance" placeholder="Balance" class="class java.util.HashMap form-control"/>
					</s:form> 
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        			<button type="button" class="btn btn-primary" onclick="submitUpdateUserForm()">Confirm</button>
      			</div>
    		</div>
  		</div>
	</div>

        
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="js/ie10-viewport-bug-workaround.js"></script>
    <svg xmlns="http://www.w3.org/2000/svg" width="200" height="200" viewBox="0 0 200 200" preserveAspectRatio="none" style="visibility: hidden; position: absolute; top: -100%; left: -100%;"><defs></defs><text x="0" y="10" style="font-weight:bold;font-size:10pt;font-family:Arial, Helvetica, Open Sans, sans-serif;dominant-baseline:middle">200x200</text></svg></body>
	
	
	<script type="text/javascript" >
		
	  	$('#myTab a').click(function (e) {
	  	  e.preventDefault()
	  	  $(this).tab('show')
	  	})
	
		var tempForm;
		
		function submitCreateBookForm(){
			$("#createBook").submit();
		}
		
		function submitCreateUserForm(){
			$("#createUser").submit();
		}
		
		function submitUpdateBookForm(){
			$("#updateBook").submit();
		}
		
		function submitUpdateUserForm(){
			$("#updateUser").submit();
		}
		
		function deleteBookFunc(id){
			
			tempForm = document.createElement("form");
			tempForm.id = "deleteBook";
			tempForm.name = "deleteBook";
			document.body.appendChild(tempForm);
			var input = document.createElement("input");
			input.type = "text";
			input.name = "bookid";
			input.value = id;
			tempForm.appendChild(input);
			tempForm.method = "POST";
			tempForm.action = "<%=basePath%>deleteBook.action";
			
			$("#deleteConfirmForm").modal('show');
		}
		
		function deleteUserFunc(id){
			
			tempForm = document.createElement("form");
			tempForm.id = "deleteUser";
			tempForm.name = "deleteUser";
			document.body.appendChild(tempForm);
			var input = document.createElement("input");
			input.type = "text";
			input.name = "userid";
			input.value = id;
			tempForm.appendChild(input);
			tempForm.method = "POST";
			tempForm.action = "<%=basePath%>deleteUser.action";
			
			$("#deleteConfirmForm").modal('show');
		}
		
		function submitForm(){
			tempForm.submit();
			document.body.removeChild(tempForm);
		}
		
		function cancelSubmitForm(){
			
			document.body.removeChild(tempForm);
		}
		
		function updateBookFunc(id){
			var input = document.getElementById("updateBook_bookinfo_id");
			input.value = id; 
			input = document.getElementById("updateBook_bookinfo_bookname");
			input.value = $("#bookname"+id).text();
			input = document.getElementById("updateBook_bookinfo_image");
			input.value = $("#image"+id).text();
			input = document.getElementById("updateBook_bookinfo_abstractInfo");
			input.value = $("#abstractInfo"+id).text();
			input = document.getElementById("updateBook_bookinfo_detail");
			input.value = $("#detail"+id).text();
			input = document.getElementById("updateBook_bookinfo_ISBN");
			input.value = $("#ISBN"+id).text();
			input = document.getElementById("updateBook_bookinfo_booknum");
			input.value = $("#booknum"+id).text();
			input = document.getElementById("updateBook_bookinfo_price");
			input.value = $("#price"+id).text();
			input = document.getElementById("updateBook_bookinfo_category");
			input.value = $("#category"+id).text();
			
			$("#updateForm").modal('show');
		}
		
		function updateUserFunc(id){
			var input = document.getElementById("updateUser_userinfo_id");
			input.value = id; 
			input = document.getElementById("updateUser_userinfo_username");
			input.value = $("#username"+id).text();
			input = document.getElementById("updateUser_userinfo_password");
			input.value = $("#password"+id).text();
			input = document.getElementById("updateUser_userinfo_balance");
			input.value = $("#balance"+id).text();
			
			$("#updateUserForm").modal('show');
		}
		
		$(".logout").on("click",function(e){
			var tempForm = document.createElement("form");
			tempForm.method = "POST";
			tempForm.action = "<%=basePath%>logout.action";
			tempForm.submit();
		});
		
		
	</script>

</html>
