<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html style="height: 100%;">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>검수</title>
    <!-- Bootstrap -->
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom style -->
    <link rel="stylesheet" href="/resources/css/style.css" media="screen" title="no title" charset="utf-8">
    <script src="/resources/js/jquery.min.js"></script>
    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://code.jquery.com/jquery-1.11.1.min.js" type="text/javascript"></script> -->
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <!-- <script src="js/bootstrap.min.js"></script> -->
    
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <!-- <script src="js/bootstrap.min.js"></script> -->
    
    
    
    <style type="text/css">
    	.btn-default:hover{
    		background-color: black;
    		color:white;
    		border: solid 1px white;
    	}
    	
    	.dropdown {
		    position: relative;
		    display: inline-block;
		    background-color: white;
		    color: black;
		    width: 98%;
		}
		
		.dropdown-content {
			color:black;
			list-style:none;
		    background-color: white;
		    overflow: auto;
		    z-index: 1;
		    width: 98%;
		    height: 100px;
		    text-align: left;
		}
		
		.dropdown-content li:hover {background-color: #ddd;}
		
		.clickDropDown {
			display:none;
		}
		
		.font_normal{
			font-weight: normal;
		}
		
		.drop_selBox{
			position: absolute;
		    display: none;
		    background-color: white;
		    color: black;
		    width: 92%;
	        height: 100px;
		    padding: 0 0;
	        margin-left: 0.8%;
    		overflow: auto;
   		    z-index: 1;
		}
		
		.drop_selBox li{
			color:black;
			list-style:none;
		    background-color: white;
		    overflow: auto;
		    width: 98%;
		    text-align: left;
		}
		
		.drop_selBox li:hover{
			background-color: #ddd;
		}
		
		.pro_sel_box{
			width: 98%;
			/* position: relative; */
			color: black;
		}
    </style>
    
</head>

<script>

var doact = {
		userCd : "",
		userNm : ""
}

function setBoundData(param, valueID, gb){
	var tagName = $('#' + valueID)[0].tagName;
	
	   var value = param;
	   var data = {};
	   data["sVal"] = value;
	   data["sGb"] = gb;
	   
	   $.ajax({
	      url: "getInboundData.do",
	      type: "POST",
	      //contentType : "application/text; charset=utf-8",
	      //dataType: "JSON",
	      data: {"data":JSON.stringify(data)},
	      success: function(data){
	         var cvtData = data.data;
	         var jsonArrObj = $.parseJSON('[' + JSON.stringify(cvtData) + ']');
	         var id = valueID;
	         
	         if(tagName == "SELECT"){
		         if(jsonArrObj.length > 0){
		            $('#' + id).find("option").remove().end().append("<option value=>선택</option>");
		            $.each(jsonArrObj, function(index, item){
		               $(item).each(function (key, value) {
		                  $('#' + id).append("<option value='" + value.CD +"'>"+value.NM + "</option>");
		               })
		            })
		         }
		         else{
		            $('#' + id).find("option").remove().end().append("<option value=>No Data</option>");
		            return;
		         }
	         } else if(tagName == "UL"){
	        	 if(jsonArrObj.length > 0){
		            $('#' + id).find("li").remove().end();
		            $.each(jsonArrObj, function(index, item){
		               $(item).each(function (key, value) {
		                  $('#' + id).append("<li data-cd='" + value.CD +"'>"+value.NM + "</li>");
		               })
		            })
		         }
		         else{
		            $('#' + id).find("li").remove().end().append("<li data-cd=''>No Data</li>");
		            return;
		         }
	         }
	      },
	      error:function(request, status, error){
	         alert(error);
	      }
	   })
	}
	
	function saveEditModal(){
		var userCD = "";
		var gumsu = '<c:out value="${login.insano}"/>';
		if(gumsu == ""){
			userCD = doact.userCd;
		}
		else {
			userCD = gumsu;
		}
		
    	if(gumsu == "" && (doact.userCd == "" || doact.userCd == undefined)){
    		alert("로그인정보가 없습니다.\r\n다시 로그인하세요.");
    		location.href = "/Page/Login";
    		return;
    	}
    	
		/* if(userCD == ""){
			alert("로그인정보가 없습니다.\r\n다시 로그인하세요.");
			location.href = "/Page/Login"
		} */
		
		var txtAera = $('#chagamResn').val().split('/');
		var chagamResn = [];
		for(var i=0;i<txtAera.length;i++){
			if(txtAera[i] != ''){
				chagamResn.push(txtAera[i]);
			}
		}
		
		var jpId = $('#junpyoId').val(); 
	    var keratype = $('#keraType').text(); 
	    var grade = $('#SltGrade').attr("data-cd");//등급코드
	    var gradeNm = $("#SltGrade").val();//등급명
	    var gumsubigo = $('#isptRmk').val();//검수비고
	    var chagam = $('#lossWeight').val();//감량중량
	    chagam = uncomma(chagam);
	    var jState = chagamResn;
	    
	    /* if($('#lossCause').val() == 'writeResn'){
	    	jState = $('#inputResn').val();
	    }else{
	    	jState = $('#lossCause').val();//감량사유
	    } */
	    
	    if(jpId == null || jpId == ''){
	    	alert('전표번호가 없습니다. 다시 로그인 하세요.');
	    	return;
	    }
	    
	    /* else if(chagam > 0 && (jState == null || jState.length == 0)){
	    	alert('감량사유를 선택하세요');
	    	return;
	    }
	    else if(chagam == 0 && (jState != null || jState.length > 0)){
	    	alert('감량중량을 입력하세요');
	    	return;
	    } */
	    
	    //2021-01-12주석처리
	    /* if(grade == null || grade == '' || gradeNm == null || gradeNm == ''){
	    	alert('등급을 선택하세요');
	    	return;
	    } */
	   
	   /*2023-01-30 등급 여러개 중 비율이 제일 높은거로 저장*/
	   var MaxGradeCd = $("#info_user").attr("data-grade");
	   var MaxGradeNm = $("#info_user").attr("data-gradeNm");
	   
	   //var MaxGradeCd = $("#SltGrade_inpt").attr("data-cd");
	   //var MaxGradeNm = $("#SltGrade_inpt").val();
	   
	    
	    var data = {};
	    
	    data["junpyoId"] = jpId; //전표 ID 추가!!!!
	    /* data["carNo"] = $('#carNum').val();
	    data["weight"] = $('#CstSbjt').val();
	    data["compNm"] = $('#CstStt').val(); */
	    data["keraType"] = keratype; 
	    
	    if(MaxGradeCd == ""){
	    	if(grade == null || grade == '' || gradeNm == null || gradeNm == ''){
		    	alert('등급을 선택하세요');
		    	return;
		    }
	    	
	    	data["j_Serial"] = grade;//등급코드
		    data["gubun1"] = gradeNm;//등급명
	    }
	    else{
	    	data["j_Serial"] = MaxGradeCd;//등급코드
		    data["gubun1"] = MaxGradeNm;//등급명
	    }
	    
	    //data["j_state"] = jState;//감량사유
	    data["stateList"] = jState;//감량사유
	    
	    data["gumsubigo"] = gumsubigo;//검수비고
	    data["chagam"] = chagam;//감량중량
	    data["insano"] = userCD;
	    
	    $.ajax({
	       url: "/Page/saveInspectionInfo.do",
	       type: "POST",
	       dataType: "json",
	       data: data,
	       success: function(result){
	          alert('저장이 완료되었습니다.');
	          goPage();
	       }
	    })
	 }
	
	function goPage(){
		location.href = "InspectionGrid"
	}
	
	function getChagamReason(){
		$.ajax({
			url: "/Page/getChagamReason",
			type: "POST",
			success: function(data){
				data = data.data;
				
				for(var i=0;i<data.length;i++){
					$('#dropCont').append('<li><label class="font_normal"><input type="checkbox" name="chkReason" value="'+data[i]['REASON']+'">'+data[i]['REASON']+'</label></li>');
				}
				
			}
		});
	}
	
	function dropDown(){
		
		$('#dropCont').toggleClass('clickDropDown');
		
		if($('#dropCont').hasClass('clickDropDown')){
			$('#dropdowntxt').text('선택');
		}else{
			$('#dropdowntxt').text('완료');
		}
	}
	
	function chkReason(){
		
		if($('#dropdowntxt').text() == '선택'){
			$("input:checkbox[name='chkReason']:checked").each(function() {
				var chkval = $(this).val();
				var chagamResnval = $('#chagamResn').val();
				$('#chagamResn').val(chagamResnval + chkval + '/');
			});
			$("input:checkbox[name='chkReason']").prop("checked", false);
		}else{
			$('#chagamResn').val('');
		}
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

$(document).on("click",".pro_sel_box", function(){
	var width = $(this).css("width");
	var droplist = $(this).next('ul.drop_selBox');
	var display = $(droplist).css("display");
	
	$(droplist).css("width", width);
	
	if(display == "none"){
		$(droplist).css("display","block");
	}else{
		$(droplist).css("display","none");
	}
	
	$(document).find('ul.drop_selBox').not(droplist).css("display","none");
})	

$(document).on("click", "ul.drop_selBox li", function(){
	var val = $(this).attr("data-cd");
	var name = $(this).text();
	var target = $(this).parent('ul.drop_selBox').prev('.pro_sel_box');
	
	$(target[0]).attr("data-cd",val);
	$(target[0]).val(name);
	$(this).parent('ul.drop_selBox').css("display","none");
	
	if($(target).attr("id") == "SltDaeGrade_inpt"){
		setBoundData(name,'SltGrade','title');
		$("#SltGrade").find("li").remove();
		$("#SltGrade_inpt").val("");
		$("#sltItem").find("li").remove();
		$("#sltItem_inpt").val("");
	}else if($(target).attr("id") == "SltGrade_inpt"){
		setBoundData(name, 'sltItem','l1');
		$("#sltItem_inpt").val("");
	}
})

/* $(document).on("input","#SltDaeGrade_inpt",function(){
	var title = $(this).val();
	setBoundData(title,'SltGrade','title');
})
	
$(document).on("input",'#SltGrade_inpt',function(){
     var gradeNm = $(this).val();
     setBoundData(gradeNm, 'sltItem','l1');
}); */
	
$(document).ready(function(){
///////JavaScript 데이터 바운드//////////
	getSessionInfo();
	var gumsu = '<c:out value="${login.insano}"/>';
	if(gumsu == "" && doact.userCd == ""){
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
	
	setBoundData('','SltDaeGrade','model');
	
	getChagamReason();
	
	   $("#AddIsptRmk").on("click", function () { //검수내역 추가
	      var gradeNm = $("#SltGrade_inpt").val();
	      
	      if(gradeNm == ""){
	    	  alert("등급을 선택해주세요.");
	    	  return;
	      }
	      
	      var itemNm = $("#sltItem_inpt").val();
	      var rate = $("#selectRate option:checked").text();
	      if(gradeNm == "선택"){
	    	  gradeNm = "";
	      }
	      if(itemNm == "선택"){
	    	  itemNm = "";
	      }
	      var input = "";
	      var val = $("#isptRmk").val();
	      if(val.length == 0 || val == null){
	    	  if(itemNm == ""){
	    		  input = gradeNm + rate;
	    	  }
	    	  else{
	    		  input = gradeNm + rate + "," + itemNm;
	    	  }
	    	  
	    	  $("#isptRmk").val(input);
	    	  
	    	  var gradeCd = $("#SltGrade_inpt").attr("data-cd");
    		  $("#info_user").attr("data-grade", gradeCd);
    		  $("#info_user").attr("data-gradeNm", gradeNm);
    		  $("#info_user").attr("data-rate", rate);
    		  
    		  console.log("1:"+gradeCd);
    		  console.log("1:"+gradeNm);
    		  console.log("1:"+rate);
	      }
	      else{
	    	  if(itemNm == ""){
	    		  input = gradeNm + rate;
	    	  }
	    	  else{
	    		  input = gradeNm + rate + "," + itemNm;
	    	  }
	    	  var prv_grade = $("#info_user").attr("data-grade");
	    	  var prv_rate = $("#info_user").attr("data-rate");
	    	  
	    	  const parsedPrvRate = Number(prv_rate);
	    	  const parsedRate = Number(rate);
	    	  
	    	  if(parsedRate > parsedPrvRate){
	    		  var gradeCd = $("#SltGrade_inpt").attr("data-cd");
	    		  $("#info_user").attr("data-grade", gradeCd);
	    		  $("#info_user").attr("data-gradeNm", $("#SltGrade_inpt").val());
	    		  $("#info_user").attr("data-rate", parsedRate);
	    	  }
	    	  
	    	  $("#isptRmk").val(val + ";" + input);
	    	  
	    	  console.log("2:"+gradeCd);
    		  console.log("2:"+$("#SltGrade_inpt").val());
    		  console.log("2:"+parsedRate);
	      }
	      
	   });
	   
	   $("#CancleIsptRmk").on("click", function () { //검수내역 취소
	      $("#isptRmk").val("");
	      $("#info_user").attr("data-grade", "");
	      $("#info_user").attr("data-gradeNm", "");
	      $("#info_user").attr("data-rate", "0");
	   });
	   
	   $("#AddDtlItem").on("click", function () { //상세품목 추가
	      var itemNm = $("#sltItem_inpt").val();
	      if(itemNm == "선택"){
	    	  itemNm = "";
	      }
	      var val = $("#isptRmk").val();
	      if(val.length == 0 || val == null){
	    	  $("#isptRmk").val(itemNm);
	      }
	      else{
	    	  $("#isptRmk").val(val + ";" + itemNm);
	      }
	      
	   });
});

//숫자콤마
function comma(str) {
        str = String(str);
        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

//숫자콤마해제
function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
} 

//숫자만사용+콤마
function inputNumberFormat(obj) {
    obj.value = comma(uncomma(obj.value));
}

//숫자만사용+콤마x
function inputOnlyNumberFormat(obj) {
    obj.value = onlynumber(uncomma(obj.value));
}

//숫자만사용
function onlynumber(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g,'$1');
}
    
</script>

    <style>
    	th{
    		text-align: center;
    	}
    	
    	td{
    		padding: 1%;
    		height: 45px;
    		min-height: 45px;
    		position: relative;
    	}
    </style>
<body style="background-color: black; color: white; ">
<div style="width: 95%;margin: auto; margin-top: 15px;height: 95%;">
   <div style='float:right;margin-bottom: 5px;'>
      <p style="display:inline-block;" id="info_user" data-grade="" data-gradeNm="" data-rate="0">안녕하세요. ${login.usrnm}님</p>
      <button type='button' class='btn btn-default' onClick='location.href="/Page/Logout"' >로그아웃</button>
   </div>
   <div style="height: 100%;">
      <table id="tbInfo" border="1" style="height: 100%; width: 100%; border-collapse: collapse; text-align: center; table-layout: fixed;">
         <tr>
         	<th>업체명</th>
         	<td colspan="5" style="text-align: left"> 
         		<label id = "company">${param.dealer }</label>
         	</td>
         </tr>
         <tr>   
            <th>
               <label>차　번</label>
            </th>
            <td>
               <label id ="carNum" name= "carNum">${car_no}</label>
            </td>
            <th>
               <label>중　량</label>
            </th>
            <td>
            
               <label id = "weight">${param.weight}</label>
            </td>
            <th>구　분</th>
         	<td>
         		<label id = "keraType"> ${param.deal_gb }</label>
         	</td>
         </tr>
         <tr>
            <td colspan="6" style="background-color: yellow;color: black; font-weight: bold">
               <span class="">등급정보 입력<i class="fa fa-lock"></i></span>
           	</td>
         </tr>
         <tr>
         	<th>대분류</th>
         	<td colspan="5" style=""> 
         		<input class="pro_sel_box" type="text" readonly="readonly" id="SltDaeGrade_inpt">
         		<ul class="drop_selBox" id="SltDaeGrade">
         		</ul>
         		<!-- <select id="SltDaeGrade" style="height: 30px; width: 98%; color: black;"></select> -->
         	</td>
         </tr>
         <tr>
            <th>
               <label>등　급</label>
            </th>
            <td colspan="2">
               <!-- <select id="SltGrade" style="height: 30px; width: 95%; color: black;"></select> -->
               <input class="pro_sel_box" type="text" readonly="readonly" id="SltGrade_inpt">
         		<ul class="drop_selBox" id="SltGrade">
         		</ul>
            </td>
            <th>
               <label>비율선택</label>
            </th>
            <td colspan="2">
               <select id="selectRate" style="height: 30px; width: 95%; color: black;">
                  <option value="1">1</option>
                  <option value="2">2</option>
                  <option value="3">3</option>
                  <option value="4">4</option>
                  <option value="5">5</option>
                  <option value="6">6</option>
                  <option value="7">7</option>
                  <option value="8">8</option>
                  <option value="9">9</option>
               </select>
            </td>
         </tr>
         <tr>
            <th>
               <label>품　목</label>
            </th>
            <td colspan="3">
               <!-- <select id="sltItem" style="height: 30px;  width: 96.4%; color: black;"></select> -->
               <input class="pro_sel_box" type="text" readonly="readonly" id="sltItem_inpt">
         		<ul class="drop_selBox" id="sltItem">
         		</ul>
            </td>
            <td colspan="2">
               <input type="button" id="AddDtlItem" value="상세품목추가" class='btn btn-default'>
            </td>
         </tr>      
         <tr>
            <th rowspan="2">
               <label>검수비고</label>
            </th>
            <td colspan="5">
               <input type="text" id="isptRmk" style="height: 30px; width: 98%; color: black;">
            </td>   
         </tr>   
         <tr>
            <td colspan="5">
               <input type="button" id="AddIsptRmk" value="검수내역추가" class='btn btn-default'>
               <input type="button" id="CancleIsptRmk" value="검수내역취소" class='btn btn-default'>
            </td>
         </tr>   
         <tr>
            <th>
               <label>감량중량</label>
            </th>
            <td colspan="5">
               <input type="text" id="lossWeight" style="height: 30px; width: 98%; color: black;" onkeyup="inputNumberFormat(this);">
            </td>
         </tr>      
         <tr>
            <th rowspan="2">
               <label>감량사유</label>
            </th>
            <td colspan="5" style="height: 50px;">
               <div class="dropdown" onclick="dropDown();chkReason();"><label class="font_normal" id="dropdowntxt" style="margin-top: 10px;width: 98%;">선택</label></div>
               <div class="dropdown-content clickDropDown" id="dropCont" style="margin-left: 1%;">
		       </div>
            </td>
         </tr>
         <tr>
         	<td colspan="5"><textarea id="chagamResn" rows="3" cols="" style="width:98%;color: black;margin-top: 10px;margin-bottom: 10px;"></textarea></td>
         </tr>
         
      </table>   
      <div style="float: right; margin-top: 10px; margin-bottom: 5px">
         <input type="hidden" id="junpyoId" value="${param.junpyoid }">
         <input type="button" id="btnConfirm" value="검수완료" class='btn btn-default' onclick="saveEditModal();">
      </div>
   </div> 
   </div>     
</body>
</html>