<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html lang="kor">
<head>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/common/js/common.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>대지에스텍</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/view/css/style.css">
</head>
<body>
    <div id="wrap">
        <nav>
            <!-- <div class="nav-logo">
                <img src="web/images/daeji_logo.svg" alt="대지에스텍 로고">
                <h1>대지에스텍</h1>
            </div> -->
            
            <ul>
                <li onclick="location.href='mgtRpt'">경영보고</li>
                <li onclick="location.href='prodRpt'">생산보고</li>
                <li onclick="location.href='busiRpt'">영업보고</li>
                <li onclick="location.href='fncDaily'">자금일보</li>
                <li onclick="location.href='atdDaily'">일일계근</li>
                <li class="active" onclick="location.href='prcInput'">단가입력</li>
            </ul>
        </nav>
        <section id="textWrapper">
            <div class="title-compart">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16"><path d="M2 20H22V22H2V20ZM4 12H6V19H4V12ZM9 12H11V19H9V12ZM13 12H15V19H13V12ZM18 12H20V19H18V12ZM2 7L12 2L22 7V11H2V7ZM12 8C12.5523 8 13 7.55228 13 7C13 6.44772 12.5523 6 12 6C11.4477 6 11 6.44772 11 7C11 7.55228 11.4477 8 12 8Z" fill="rgba(58,78,132,1)"></path></svg>
                <h2>단가입력</h2>
            </div>
            <article class="filter-section" style="gap: 32px;">
            
                <div class="ft-item">
			        <p class="ft-item-name">계근일자</p>
			        <input type="date" name="sYmdFrom" value = ${sYmdFrom }>
			        <p>~</p>
			        <input type="date" name="sYmdTo" value = ${sYmdTo }>
			    </div>
<!-- 
				<div class="ft-item">
					<p class="ft-item-name">계근구분</p>
			        <input id="ft" type="radio" name="sUtPrcYn" value="" ${sUtPrcYn == '' ? 'checked="checked"' : ''}>
			        <label for="ft">전체</label>
			
			        <input id="ftY" type="radio" name="sUtPrcYn" value="Y" ${sUtPrcYn == 'Y' ? 'checked="checked"' : ''}>
				    <label for="ftY">입력</label>
				
				    <input id="ftN" type="radio" name="sUtPrcYn" value="N" ${sUtPrcYn == 'N' ? 'checked="checked"' : ''}>
				    <label for="ftN">미입력</label>
				</div>
 -->

                <div class="ft-item">
                	<p class="ft-item-name"></p>
			        <input id="ftAll" type="radio" name="sKeraType" value="ALL" ${sKeraType == 'ALL' ? 'checked="checked"' : ''}>
			        <label for="ftAll">전체</label>
			
			        <input id="ftInput" type="radio" name="sKeraType" value="IN" ${sKeraType == 'IN' ? 'checked="checked"' : ''}>
				    <label for="ftInput">입고</label>
				
				    <input id="ftOutput" type="radio" name="sKeraType" value="OUT" ${sKeraType == 'OUT' ? 'checked="checked"' : ''}>
				    <label for="ftOutput">출고</label>
				</div>
				
				<button class="ar" type="button" onclick="submitForm()">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16">
                    	<path fill="#fff" d="M18.031 16.6168L22.3137 20.8995L20.8995 22.3137L16.6168 18.031C15.0769 19.263 13.124 20 11 20C6.032 20 2 15.968 2 11C2 6.032 6.032 2 11 2C15.968 2 20 6.032 20 11C20 13.124 19.263 15.0769 18.031 16.6168ZM16.0247 15.8748C17.2475 14.6146 18 12.8956 18 11C18 7.1325 14.8675 4 11 4C7.1325 4 4 7.1325 4 11C4 14.8675 7.1325 18 11 18C12.8956 18 14.6146 17.2475 15.8748 16.0247L16.0247 15.8748Z" fill="rgba(58,78,132,1)"></path>
                    </svg>
                    조회
                </button>
                
                <button id="saveButton" class="ar" type="button" onclick="saveData()">
				    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16">
				        <path d="M18 21V13H6V21H4C3.44772 21 3 20.5523 3 20V4C3 3.44772 3.44772 3 4 3H17L21 7V20C21 20.5523 20.5523 21 20 21H18ZM16 21H8V15H16V21Z" fill="rgba(255,255,255,1)"></path>
				    </svg>
				    저장
				</button>
                
            </article>
            <!-- 테이블 시작 -->
            <div id="" class="section-contents scrolling-table common-table-wrap">
                <table id="" class="common-data-table amount-table" style="border-block: 0;">
                    <colgroup>
                        <col class="tb-cell-number" />
                        <col class="tb-cell-number" />
                        <col class="tb-cell-shortname" />
                        <col class="tb-cell-year" />
                        <col class="tb-cell-title" />
                        <col class="tb-cell-year" />
                        <col class="tb-cell-year" />
                        <col class="tb-cell-year" />
                        <col class="tb-cell-instname" />
                        <col class="tb-cell-instname" />
                        <col class="tb-cell-year" />
                        <col class="tb-cell-year" />
                    </colgroup>
                    <thead>
                        <tr>
                            <th></th>
                            <th>순번</th>
                            <th>계근일자</th>
                            <th>거래구분</th>
                            <th>거래처명</th>
                            <th>담당자</th>
                            <th>차량번호</th>
                            <th>등급</th>
                            <th>공차중량</th>
                            <th>총중량</th>
                            <th>기준단가</th>
                            <th>적용단가</th>
                        </tr>
                    </thead>
                    <tbody>
                
                    	<c:forEach  var = "prc" items="${prcList}" varStatus="loop">
							 	<tr>
									<td class = "center"><input type="checkbox"></td>
	                    			<td style = "text-align:center" data-junpyoid ="${prc.junpyoid }">${loop.index + 1}</td>
	                    			<td class = "center">${prc.jdate}</td>
									<td style = "text-align:center">${prc.keratype}</td>
									<td style = "text-align:left">${prc.dealernm}</td>
									<td>${prc.chrgnm}</td>
									<td>${prc.jbnum}</td>
									<td>${prc.gradenm}</td>
									<td><fmt:formatNumber value="${prc.emptyweight}" pattern="###,###.#" /></td>
									<td><fmt:formatNumber value="${prc.totweight}" pattern="###,###.#" /></td>
									<td><fmt:formatNumber value="${prc.stdunitprc}" pattern="###,###.#" /></td>
									<td><input class="inputText" type="text" placeholder="${prc.applyunitprc } " ></td>
	                    		</tr>  
                    	</c:forEach>
                         
                    </tbody>
                </table>
            </div>
            <!-- 테이블 끝 -->
        </section>
    </div>
</body>
<script>
	function submitForm() {
	    var sYmdFrom = document.getElementsByName('sYmdFrom')[0].value;
	    var sYmdTo = document.getElementsByName('sYmdTo')[0].value;
	    //var sUtPrcYn = document.querySelector('input[name="sUtPrcYn"]:checked').value;
	    var sKeraType = document.querySelector('input[name="sKeraType"]:checked').value;
	
        //alert('날짜 : ' + sYmdFrom + "~" + sYmdTo + ', sKeraType: ' + sKeraType);


        if(sYmdFrom == '' || sYmdTo == ''){
        	alert("계근일자를 선택해주세요.");
        }
        else{
        	// Ajax를 이용하여 컨트롤러로 값을 전송하고 결과를 받음
    	    $.ajax({
    	        url: "/exe/prcInput/prclist", // 실제 컨트롤러의 엔드포인트
    	        method: "POST",
    	        data: {sYmdFrom: sYmdFrom, sYmdTo: sYmdTo, sKeraType: sKeraType},
    	        success: function(response) {
    	            // 성공 시 처리
    	            // response에는 컨트롤러에서 전송한 데이터가 들어있음
    	            //console.log(response);
    	            $("body").html(response);
    	        },
    	        error: function(error) {
    	            console.error(error);
    	        }
    	    });
        }
	}
	
	 function saveData() {
	        var selectedRows = [];
	        var n = "";
	        var check = "";
	        $("input[type=checkbox]:checked").each(function () {   // 체크된 체크박스 값을 가져옴
	            var junpyoid = $(this).closest("tr").find("[data-junpyoid]").data("junpyoid");  // closest("tr")이 체크된 행
	            var inputValue = $(this).closest("tr").find(".inputText").val();
				if(inputValue == ""){
					n = "x";
				}				
	            selectedRows.push({ junpyoid: junpyoid, inputValue: inputValue });
	            check = "o";
	        });
			
	        if(n == "x"){
	        	alert("단가를 입력해주세요.");
	        	return;
	        }
	        
	        if(check == ""){
	        	alert("체크를 해주세요.");
	        	return;
	        }
	        
	        console.log(selectedRows);
			
	        
	        $.ajax({
	             url: "/exe/prcInput/prcupdate",
	             method: "POST",
	             contentType: "application/json",  // Content-Type을 JSON으로 지정
	             data:  JSON.stringify(selectedRows),  // JSON 형태로 서버에 보냄
	             success: function(response) {
	                 // 서버에서의 응답을 처리
	                 console.log(response);
	                 alert("저장되었습니다.");
	 	            //$("body").html(response);
	 	            submitForm();
	             },
	             error: function(error) {
	                 console.error("에러입니당");
	             }
	         });
	    }

</script>
</html>