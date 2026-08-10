<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
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
                <li onclick="location.href='mgtRpt'">경영보고</li>
                <li onclick="location.href='prodRpt'">생산보고</li>
                <li class="active" onclick="location.href='busiRpt'">영업보고</li>
                <li onclick="location.href='fncDaily'">자금일보</li>
                <li onclick="location.href='atdDaily'">일일계근</li>
                <li onclick="location.href='prcInput'">단가입력</li>
            </ul>
        </nav>
        <section id="textWrapper">
        	<article class="filter-section">
                <div class="ft-item">
			        <p class="ft-item-name">조회일자</p>
			        <input type="date" name="sYmdFrom" value = ${sYmdFrom }>
			        <p>~</p>
			        <input type="date" name="sYmdTo" value = ${sYmdTo }>
			    </div>
                
                <button class="ar" type="button" onclick = "submitForm()">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16"><path fill="#fff" d="M18.031 16.6168L22.3137 20.8995L20.8995 22.3137L16.6168 18.031C15.0769 19.263 13.124 20 11 20C6.032 20 2 15.968 2 11C2 6.032 6.032 2 11 2C15.968 2 20 6.032 20 11C20 13.124 19.263 15.0769 18.031 16.6168ZM16.0247 15.8748C17.2475 14.6146 18 12.8956 18 11C18 7.1325 14.8675 4 11 4C7.1325 4 4 7.1325 4 11C4 14.8675 7.1325 18 11 18C12.8956 18 14.6146 17.2475 15.8748 16.0247L16.0247 15.8748Z" fill="rgba(58,78,132,1)"></path></svg>
                    조회
                </button>
            </article>
            <div class="title-compart">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16"><path d="M2 20H22V22H2V20ZM4 12H6V19H4V12ZM9 12H11V19H9V12ZM13 12H15V19H13V12ZM18 12H20V19H18V12ZM2 7L12 2L22 7V11H2V7ZM12 8C12.5523 8 13 7.55228 13 7C13 6.44772 12.5523 6 12 6C11.4477 6 11 6.44772 11 7C11 7.55228 11.4477 8 12 8Z" fill="rgba(58,78,132,1)"></path></svg>
                <h2>매출</h2>
            </div>
            <!-- 테이블 시작 -->
            <div id="" class="section-contents scrolling-table common-table-wrap">
                <table id="" class="common-data-table amount-table" style="border-block: 0;">
                    <colgroup>
                        <col class="tb-cell-year" />
                        <col class="tb-cell-year" />
                        <col class="tb-cell-instname" />
                        <col class="tb-cell-year" />
                        <col class="tb-cell-year" />                   
                    </colgroup>
                    <thead>
                        <tr>
                            <th>구분</th>
                            <th>월목표</th>
                            <th>업체명</th>
                            <th>매출량</th>
                            <th>평균단가</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach  var = "bs" items="${busiList}">
                    		<c:set var = "gu" value = "${bs.gu}"/>
                    		<c:choose>
                    			<c:when  test="${gu eq '소계'}">
							 		<tr class = "subtotal-row">
	                    				<td style = "text-align:center">${bs.gu}</td>
	                    				<td><fmt:formatNumber value="${bs.monthc}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:left">${bs.dealernm}</td>
	                    				<td><fmt:formatNumber value="${bs.danjung}" pattern="###,###.#" /></td>
	                    				<td><fmt:formatNumber value="${bs.danga}" pattern="###,###.#" /></td>
	                    			</tr>  
								</c:when>
								
								<c:when  test="${gu eq '합계'}">
							 		<tr class = "sum-total-row">
	                    				<td style = "text-align:center">${bs.gu}</td>
	                    				<td><fmt:formatNumber value="${bs.monthc}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:left">${bs.dealernm}</td>
	                    				<td><fmt:formatNumber value="${bs.danjung}" pattern="###,###.#" /></td>
	                    				<td><fmt:formatNumber value="${bs.danga}" pattern="###,###.#" /></td>
	                    			</tr>  
								</c:when>
								
								<c:otherwise>
									<tr>
	                    				<td style = "text-align:center">${bs.gu}</td>
	                    				<td><fmt:formatNumber value="${bs.monthc}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:left">${bs.dealernm}</td>
	                    				<td><fmt:formatNumber value="${bs.danjung}" pattern="###,###.#" /></td>
	                    				<td><fmt:formatNumber value="${bs.danga}" pattern="###,###.#" /></td>
	                    			</tr>
								</c:otherwise>	
                    		</c:choose>
                    	</c:forEach>
                    </tbody>
                </table>
            </div>
            <!-- 테이블 끝 -->
            
            <div class="title-compart">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16"><path d="M2 20H22V22H2V20ZM4 12H6V19H4V12ZM9 12H11V19H9V12ZM13 12H15V19H13V12ZM18 12H20V19H18V12ZM2 7L12 2L22 7V11H2V7ZM12 8C12.5523 8 13 7.55228 13 7C13 6.44772 12.5523 6 12 6C11.4477 6 11 6.44772 11 7C11 7.55228 11.4477 8 12 8Z" fill="rgba(58,78,132,1)"></path></svg>
                <h2>매입</h2>
            </div>
            <!-- 테이블 시작 -->
            <div id="" class="section-contents scrolling-table common-table-wrap">
                <table id="" class="common-data-table">
                    <colgroup>
			            <col class="tb-cell-instname" />
			            <col class="tb-cell-year" />
			            <col class="tb-cell-year" />
			            <col class="tb-cell-year" />
			            <col class="tb-cell-year" />
			            <col class="tb-cell-year" />
			            <col class="tb-cell-year" />
			            <col class="tb-cell-year" />
			            <col class="tb-cell-year" />
			            <col class="tb-cell-year" />
			            <col class="tb-cell-year" />
			        </colgroup>
                    <thead>
                        <tr>
                            <th rowspan="2">담당자</th>
			                <th colspan="3">슈레더</th>
			                <th colspan="3">고철A</th>
			                <th colspan="3">고철B</th>
			                <th colspan="3">합계</th>
                        </tr>
                        <tr>
                        	<th>목표량</th>
                        	<th>매입량</th>
                        	<th>평균단가</th>
                        	<th>목표량</th>
                        	<th>매입량</th>
                        	<th>평균단가</th>
                        	<th>목표량</th>
                        	<th>매입량</th>
                        	<th>평균단가</th>
                        	<th>목표량</th>
                        	<th>매입량</th>
                        	<th>평균단가</th>
                        </tr>
                    </thead>
                    <tbody>
                    
                    	<c:forEach  var = "mp" items="${maeipList}">
                    		<c:set var = "nm" value = "${mp.chrgnm}"/>
                    		<c:choose>
								
								<c:when  test="${nm eq '합계'}">
							 		<tr class = "sum-total-row">
							 			<td style = "text-align:left">${mp.chrgnm }</td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.s1}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.s2}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.s3}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.a1}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.a2}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.a3}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.b1}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.b2}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.b3}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.t1}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.t2}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.t3}" pattern="###,###.#" /></td>
									</tr>  
								</c:when>
								
								<c:otherwise>
									<tr>
										<td style = "text-align:left">${mp.chrgnm }</td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.s1}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.s2}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.s3}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.a1}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.a2}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.a3}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.b1}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.b2}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.b3}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.t1}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.t2}" pattern="###,###.#" /></td>
	                    				<td style = "text-align:right"><fmt:formatNumber value="${mp.t3}" pattern="###,###.#" /></td>
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
	    var sYmdFrom = document.getElementsByName('sYmdFrom')[0].value;
	    var sYmdTo = document.getElementsByName('sYmdTo')[0].value;

	
        //alert('날짜 : ' + sYmdFrom + "~" + sYmdTo + ', sKeraType: ' + sKeraType);


        if(sYmdFrom == '' || sYmdTo == ''){
        	alert("조회일자를 선택해주세요.");
        }
        else{
        	// Ajax를 이용하여 컨트롤러로 값을 전송하고 결과를 받음
    	    $.ajax({
    	        url: "/exe/busiRpt/busilist", // 실제 컨트롤러의 엔드포인트
    	        method: "POST",
    	        data: {sYmdFrom: sYmdFrom, sYmdTo: sYmdTo},
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