<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<script type="text/javascript" src="js/jquery.min.js"></script>
</head>
<body>
	<%
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	%>
	<input type="submit" value="submit"> 
	<% %>
	
	
	
	<script type="text/javascript">
	  
		 $("input").click(function(){    
		 	$.ajax({  
		 		url:'<%=basePath%>test.action',  
		 		error:function(){  
		 		alert("this has errors!!");  
		 		},  
		 		success:function(data){  
		 			alert(data);  
		 		}  
		 	});  
		 });   
	</script>
</body>
</html>