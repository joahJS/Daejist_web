<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="kor">
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/common/js/common.js"></script>
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
                <!-- <li class="active" onclick="location.href='mgtRpt'">경영보고</li>
                <li onclick="location.href='prodRpt'">생산보고</li>
                <li onclick="location.href='busiRpt'">영업보고</li> -->
                <!-- <li onclick="location.href='fncDaily'">자금일보</li> -->
                <li >일일계근</li>
                <!-- <li onclick="location.href='prcInput'">단가입력</li> -->
            </ul>
        </nav>
        <section id="textWrapper">
<!--         	<article class="filter-section"> -->
<!--                 <div class="ft-item"> -->
<!--                     <p class="ft-item-name">조회일자</p> -->
<%-- 			        <input type="date" name="jDate" value = ${jDate }>   <!-- jDate 변경 조회 해도 유지 --> --%>
<!--                 </div> -->
                
<!--                 <button class="ar" type="button" onclick="submitForm()"> -->
<!--                     <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16"><path fill="#fff" d="M18.031 16.6168L22.3137 20.8995L20.8995 22.3137L16.6168 18.031C15.0769 19.263 13.124 20 11 20C6.032 20 2 15.968 2 11C2 6.032 6.032 2 11 2C15.968 2 20 6.032 20 11C20 13.124 19.263 15.0769 18.031 16.6168ZM16.0247 15.8748C17.2475 14.6146 18 12.8956 18 11C18 7.1325 14.8675 4 11 4C7.1325 4 4 7.1325 4 11C4 14.8675 7.1325 18 11 18C12.8956 18 14.6146 17.2475 15.8748 16.0247L16.0247 15.8748Z" fill="rgba(58,78,132,1)"></path></svg> -->
<!--                     조회 -->
<!--                 </button> -->
<!--             </article> -->
            <div class="title-compart">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16"><path d="M2 20H22V22H2V20ZM4 12H6V19H4V12ZM9 12H11V19H9V12ZM13 12H15V19H13V12ZM18 12H20V19H18V12ZM2 7L12 2L22 7V11H2V7ZM12 8C12.5523 8 13 7.55228 13 7C13 6.44772 12.5523 6 12 6C11.4477 6 11 6.44772 11 7C11 7.55228 11.4477 8 12 8Z" fill="rgba(58,78,132,1)"></path></svg>
                <h2>재고자산</h2>
            </div>
            <!-- 테이블 시작 -->
            <div id="invAssetTb" class="section-contents scrolling-table common-table-wrap">
                <table id="" class="common-data-table amount-table" style="border-block: 0;">
                    <colgroup>
                        <col class="tb-cell-year" />
                        
                        <col class="tb-cell-shortname" />
                        <col class="tb-cell-year" />
                        <col class="tb-cell-shortname" />
                        
                        <col class="tb-cell-shortname" />
                        <col class="tb-cell-year" />
                        <col class="tb-cell-shortname" />
                        <col class="tb-cell-shortname" />
                        <col class="tb-cell-year" />
                        <col class="tb-cell-shortname" />
                    </colgroup>
                    <thead>
                        <tr>
                            <th rowspan="2">구분</th>
                            <th colspan="3">슈레더</th>
                            <th colspan="3">고철</th>
                            <th colspan="3">합계</th>
                        </tr>
                        <tr>
                            <!-- <th>구분</th> -->
                            <th>중량</th>
                            <th>단가</th>
                            <th>금액</th>
                            <th>중량</th>
                            <th>단가</th>
                            <th>금액</th>
                            <th>중량</th>
                            <th>단가</th>
                            <th>금액</th>
                        </tr>
                    </thead>
                    <tbody>
   	 					<tr>
        					<td style = "text-align:left">합계</td>
							<td><fmt:formatNumber value="${mgtRptList.a1}" pattern="###,###.#" /></td>
							<td><fmt:formatNumber value="${mgtRptList.b1}" pattern="###,###.#" /></td>
        					<td><fmt:formatNumber value="${mgtRptList.c1}" pattern="###,###.#" /></td>
							<td><fmt:formatNumber value="${mgtRptList.a2}" pattern="###,###.#" /></td>
							<td><fmt:formatNumber value="${mgtRptList.b2}" pattern="###,###.#" /></td>
							<td><fmt:formatNumber value="${mgtRptList.c2}" pattern="###,###.#" /></td>
							<td><fmt:formatNumber value="${mgtRptList.a3}" pattern="###,###.#" /></td>
							<td><fmt:formatNumber value="${mgtRptList.b3}" pattern="###,###.#" /></td>
							<td><fmt:formatNumber value="${mgtRptList.c3}" pattern="###,###.#" /></td>
    					</tr>
					</tbody>
                </table>
            </div>
            <!-- 테이블 끝 -->

            <div class="title-compart">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16"><path d="M2 20H22V22H2V20ZM4 12H6V19H4V12ZM9 12H11V19H9V12ZM13 12H15V19H13V12ZM18 12H20V19H18V12ZM2 7L12 2L22 7V11H2V7ZM12 8C12.5523 8 13 7.55228 13 7C13 6.44772 12.5523 6 12 6C11.4477 6 11 6.44772 11 7C11 7.55228 11.4477 8 12 8Z" fill="rgba(58,78,132,1)"></path></svg>
                <h2>재무-현금자산</h2>
            </div>
            <!-- 테이블 시작 -->
            <div id="" class="section-contents scrolling-table common-table-wrap">
                <table id="" class="common-data-table">
                    <colgroup>
                        <col class="tb-cell-year" />
                        <col class="tb-cell-title" />
                        <col class="tb-cell-year" />
                        <col class="tb-cell-instname" />
                        <col class="tb-cell-instname" />
                    </colgroup>
                    <thead>
                        <tr>
                            <th>구분</th>
                            <th>업체명</th>
                            <th>은행</th>
                            <th>계좌번호</th>
                            <th>잔액</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach  var = "jm" items="${jaemooList}">
                    		<c:set var = "gu" value = "${jm.gu}"/>
                    		<c:choose>
                    			<c:when  test="${gu eq '소계'}">
							 		<tr class = "subtotal-row">
	                    				<td style = "text-align:left">${jm.gu}</td>
	                    				<td>${jm.dealernm}</td>
	                    				<td>${jm.banknm}</td>
	                    				<td>${jm.bankac}</td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${jm.jamt}" pattern="###,###.#" /></td>
	                    			</tr>  
								</c:when>
								
								<c:when  test="${gu eq '합계'}">
							 		<tr class = "sum-total-row">
	                    				<td style = "text-align:left">${jm.gu}</td>
	                    				<td>${jm.dealernm}</td>
	                    				<td>${jm.banknm}</td>
	                    				<td>${jm.bankac}</td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${jm.jamt}" pattern="###,###.#" /></td>
	                    			</tr>  
								</c:when>
								
								<c:otherwise>
									<tr>
	                    				<td style = "text-align:left">${jm.gu}</td>
	                    				<td>${jm.dealernm}</td>
	                    				<td>${jm.banknm}</td>
	                    				<td>${jm.bankac}</td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${jm.jamt}" pattern="###,###.#" /></td>
	                    			</tr>
								</c:otherwise>	
                    		</c:choose>
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
	    var jDate = document.getElementsByName('jDate')[0].value;
	
        //alert('jDate: ' + jDate + ', sKeraType: ' + sKeraType + ', sBigCate: ' + sBigCate);


        if(jDate == ''){
        	alert("조회일자를 선택해주세요.");
        }
        else{
        	// Ajax를 이용하여 컨트롤러로 값을 전송하고 결과를 받음
    	    $.ajax({
    	        url: "/exe/mgtRpt/mgtlist", // 실제 컨트롤러의 엔드포인트
    	        method: "POST",
    	        data: {jDate: jDate},
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
</script>
</html>