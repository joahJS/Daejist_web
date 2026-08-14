<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>검수목록</title>
        <!-- Bootstrap -->
        <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom style -->
        <link rel="stylesheet" href="/resources/css/style.css" media="screen" title="no title" charset="utf-8">
        <script src="/resources/js/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <!-- <script src="js/bootstrap.min.js"></script> -->
        <style type="text/css">
        	#InspectionGrid .table_row:hover{
        		background-color: white;
        		color:black;
        	}
        	.selected {
        		background-color: white;
        		color:black;
        	}
        	.btn-default:hover{
        		background-color: black;
        		color:white;
        		border: solid 1px white;
        	}
        	/* input[type="text"]{
        		outline-style: none;
        		cursor:default;
        	} */
        	td {
        		cursor:default;
        	}
        </style>
        <script>
        var doact = {
        		userCd : "",
        		userNm : ""
        }
        
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
        
        function getList(){
        	var today = setDateData();
        	
        	$.ajax({
                url : "<c:url value='/checkDtlRefInfo.do'/>",
                type : "POST",
                dataType : "text",
                data : today,
                success : function(result) {
                   if (result == "F") {
                      alert(chkSubCd + '\r\n해당 항목코드는 이미 등록되었습니다.\r\n다른 코드값을 입력하세요.');
                      $('#DtlSubCd').focus();
                      $('#DtlSubCd').val('');
                      return;
                   }
                }
             })
        }
        
        function getSessionInfo(){
           	$.ajax({
                   url : "/Page/getSessionInfo",
                   type : "POST",
                   dataType : "json",
                   data : "",
                   async:false,
                   success : function(data) {
                      doact.userCd = data["usrCd"];
                      doact.userNm = data["usrNm"];
                   }
                })
        }

        $(document).ready(function() {
        	getSessionInfo();
        	var gumsu = '<c:out value="${login.insano}"/>';
        	$("#InspectionGrid").attr("data-usrcd", gumsu);
        	var insa = gumsu;
        	if(insa == "" && doact.userCd == ""){
        		alert("로그인정보가 없습니다.\r\n다시 로그인하세요.");
        		location.href = "/Page/Login"
        	} 
        	
        	var user_name = '<c:out value="${login.usrnm}"/>';
        	if(user_name == ""){
        		$("#info_user").text("안녕하세요." + doact.userNm + "님");
        	}
        	else{
        		$("#info_user").text("안녕하세요." + user_name + "님");
        	}
        	
			$('#InspectionGrid').on('click', '.table_row', function () {
				
				if($(this).hasClass('selected')){
					$(this).removeClass('selected');
				}else{
					if ( $('.table_row').hasClass('selected') ) {
			            $('.table_row').removeClass('selected');
			        }
			        $(this).addClass('selected');
				}
				
				var a = $('#InspectionGrid >thead td').length;
				var arr = [];
				var data = {};
				for(var i=1; i < a; i++){
					arr.push($(this).find("td:eq("+i+")").html().trim());
				}
				arr.push($(this).attr('name'));
				
				$('#car_no').val(arr[0]);
				$('#weight').val(arr[1]);
				$('#dealer').val(arr[2]);
				$('#deal_gb').val(arr[3]);
				$('#junpyoid').val(arr[4]);
				
				rowDbClickForm.submit();
            });
            
           /*  $('#InspectionGrid').on('dblclick', '.table_row', function () {
				
            	var a = $('#InspectionGrid >thead td').length;
				var arr = [];
				var data = {};
				for(var i=1; i < a; i++){
					arr.push($(this).find("td:eq("+i+")").html().trim());
				}
				arr.push($(this).attr('name'));
				
				$('#car_no').val(arr[0]);
				$('#weight').val(arr[1]);
				$('#dealer').val(arr[2]);
				$('#deal_gb').val(arr[3]);
				$('#junpyoid').val(arr[4]);
				
				rowDbClickForm.submit();
            }); */
            
         });
        
        
        </script>
    </head>
    
    <body style="background-color: black; color: white;">
    	<div style="width: 95%; margin:auto; margin-top: 15px; " >
    	<div style='float:right'>
			<span style="display:inline-block;" id="info_user">안녕하세요. ${login.usrnm}님</span>
			<button type='button' class='btn btn-default' onClick='location.href="/Page/Logout"' >로그아웃</button>
		</div>
		<br>
		<br>
         <div>
			<table class="table" id="InspectionGrid" data-usrcd="">
				<thead>
				<tr style="text-align: center;">
					<td>
						<label> 사업장 </label>
					</td>
					<td>
						<label> 차량 </label>
					</td>
					<td>
						<label> 중량 </label>
					</td>
					<td>
						<label> 업체명 </label>
					</td>
					<td>
						<label> 구분 </label>
					</td>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="mesuring" items="${list }">
						<tr class="table_row" name="${mesuring.junpyoid }" style="text-align: center;">
							<td>
								<label> 본사 </label>
							</td>
							<td>${mesuring.car_no }
								<%-- <input type="text" name="car_no" value="${mesuring.car_no }" style="background-color: transparent; text-align: center; border: none;" readonly> --%>
							</td>
							<td><fmt:formatNumber value="${mesuring.weight }" pattern="#,###"/>
								<%-- <input type="text" name="weight" value="${mesuring.weight }" style="background-color: transparent; text-align: center; border: none;" readonly> --%>
							</td>
							<td>${mesuring.dealer }
								<%-- <input type="text" id="dealer" name="dealer" value="${mesuring.dealer }" style="background-color: transparent; text-align: center; border: none;" readonly> --%>
	<%-- <a id="btn" href="Inspection?car_no=${mesuring.car_no}&weight=${mesuring.weight}&junpyoid=${mesuring.junpyoid}&deal_gb=${mesuring.deal_gb }&dealer=${mesuring.dealer}">${mesuring.dealer } </a> --%>
							</td>
							<td>${mesuring.deal_gb }
								<%-- <input type="text" name="deal_gb" value="${mesuring.deal_gb }" style="background-color: transparent; text-align: center; border: none;" readonly> --%>
							</td>
						</tr>
						<input type="hidden" name="junpyoid" value="${mesuring.junpyoid }" style="background-color: transparent; text-align: center; border: none;" readonly>
				</c:forEach>
				</tbody>
			</table>
			<form id="rowDbClickForm" action="/Page/Inspection" style="display: none" method="post">
				<input type="hidden" name = "car_no" id = "car_no">
				<input type="hidden" name = "weight" id = "weight">
				<input type="hidden" name = "dealer" id = "dealer">
				<input type="hidden" name = "deal_gb" id = "deal_gb">
				<input type="hidden" name = "junpyoid" id = "junpyoid">
			</form>
		 </div>
		</div>
    </body>
</html>