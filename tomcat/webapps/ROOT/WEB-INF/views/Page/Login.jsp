<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html style="height: 100%">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>로그인</title>
    <!-- Bootstrap -->
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom style -->
    <link rel="stylesheet" href="/resources/css/style.css" media="screen" title="no title" charset="utf-8">
    <script src="/resources/js/jquery.min.js"></script>
    <script src="/resources/js/jquery-3.2.1.slim.min.js"></script>
    <script src="/resources/js/popper.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <!-- <script src="js/bootstrap.min.js"></script> -->
    
</head>
<script>   
	function setDateData(){
        var date = new Date(); 
        var year = date.getFullYear(); 
        var month = new String(date.getMonth()+1); 
        var day = new String(date.getDate()); 

        // 한자리수일 경우 0을 채워준다. 
        if(month.length == 1){ 
          month = "0" + month; 
        } 
        if(day.length == 1){ 
          day = "0" + day; 
        } 

        return year + "-" + month + "-" + day;
   }
	
	function login(){
		var id = $("#usrid").val();
		var pw = $("#passwd").val();
		
		if(id == "" || (id =="" && pw != "")){
			alert("ID를 입력해주세요.");
			$("#usrid").focus();
			return false;
		}else if(id != "" && pw ==""){
			alert("PW를 입력해주세요.");
			$("#passwd").focus();
			return false;
		}
		document.form1.submit();
	}
	
	$(document).ready(function(e) {
			
		/* $('#login-submit').on('click',function(){
			var id = $("#usrid").val();
			var pw = $("#passwd").val();
			
			if(id == "" || (id =="" && pw != "")){
				alert("ID를 입력해주세요.");
				$("#usrid").focus();
				return;
			}else if(id != "" && pw ==""){
				alert("PW를 입력해주세요.");
				$("#passwd").focus();
				return;
			}
			console.log("리턴안되냐");
			document.form1.submit();
		}); */
		
		$('#usrid').keyup(function(event){
			  if(event.keyCode == '13'){
				  $("#passwd").focus();
			  } 
		});
		$('#passwd').keyup(function(event){
			  if(event.keyCode == '13'){
				  login();
			  } 
		});
	});

</script>
<body style="background-color: black;height: 100%">
<div style="width: 100%;height: 100%;position: relative;">
    <div class="login-box well" style="width: 300px;height: 220px;position: absolute;left: 50%;top: 50%;margin-left: -150px;margin-top: -110px;">
        <form accept-charset="UTF-8" role="form" method="POST" action="LoginCheck" id="check" name="form1">
            <legend>대지검수프로그램</legend>
             <div class="input-group">
                 <span class="input-group-addon"><i class="fa fa-user"></i></span>
                 	<input type="text" id="usrid" name = "usrid" value="${login.usrid}" placeholder="ID를 입력하세요" class="form-control" />
             </div>
             <div class="input-group">
                 <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                 <input type="password" id="passwd" name = "passwd" value="${login.passwd}" placeholder="비밀번호를 입력하세요" class="form-control" />
             </div>
 				<input type="hidden" id="j_date" name="j_date" value="">
            <button type="button" id="login-submit" class="btn btn-default btn-block" onclick="login();">로그인</button>
            <input type="checkbox" name="chkbox" checked="checked"><label>아이디저장</label>
        </form>
    </div>
</div>
</body>
</html>