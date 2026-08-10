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
                <li class="active" onclick="location.href='atdDaily'">일일계근</li>
                <li onclick="location.href='prcInput'">단가입력</li>
            </ul>
        </nav>
        <section id="textWrapper">
            <div class="title-compart">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16"><path d="M2 20H22V22H2V20ZM4 12H6V19H4V12ZM9 12H11V19H9V12ZM13 12H15V19H13V12ZM18 12H20V19H18V12ZM2 7L12 2L22 7V11H2V7ZM12 8C12.5523 8 13 7.55228 13 7C13 6.44772 12.5523 6 12 6C11.4477 6 11 6.44772 11 7C11 7.55228 11.4477 8 12 8Z" fill="rgba(58,78,132,1)"></path></svg>
                <h2>일일계근현황</h2>
            </div>
            <article class="filter-section" style="gap: 32px;">
                <div class="ft-item">
			        <p class="ft-item-name">계근일자</p>
			        <input type="date" name="jDate" value = ${jDate }>   <!-- jDate 변경 조회 해도 유지 -->
			    </div>

                <div class="ft-item">
			        <input id="ftAll" type="radio" name="sKeraType" value="ALL" ${sKeraType == 'ALL' ? 'checked="checked"' : ''}>
			        <label for="ftAll">전체</label>
			
			        <input id="ftInput" type="radio" name="sKeraType" value="IN" ${sKeraType == 'IN' ? 'checked="checked"' : ''}>
				    <label for="ftInput">입고</label>
				
				    <input id="ftOutput" type="radio" name="sKeraType" value="OUT" ${sKeraType == 'OUT' ? 'checked="checked"' : ''}>
				    <label for="ftOutput">출고</label>
				</div>

                <div class="ft-item">    
					<p class="ft-item-name">대분류</p>
					<select name="sBigCate">
					    <option value="">전체</option>
					    <option value="슈레더" ${sBigCate == '슈레더' ? 'selected' : ''}>슈레더</option>
					    <option value="고철A" ${sBigCate == '고철A' ? 'selected' : ''}>고철A</option>
					    <option value="고철B" ${sBigCate == '고철B' ? 'selected' : ''}>고철B</option>
					    <option value="일반" ${sBigCate == '일반' ? 'selected' : ''}>일반</option>
					    <option value="인센티브" ${sBigCate == '인센티브' ? 'selected' : ''}>인센티브</option>
					    <option value="재고" ${sBigCate == '재고' ? 'selected' : ''}>재고</option>
					    <option value="재고이동" ${sBigCate == '재고이동' ? 'selected' : ''}>재고이동</option>
			            <!-- 필요에 따라 추가할 수 있습니다. -->
			        </select>
			    </div>
                
                <button class="ar" type="button" onclick="submitForm()">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16"><path fill="#fff" d="M18.031 16.6168L22.3137 20.8995L20.8995 22.3137L16.6168 18.031C15.0769 19.263 13.124 20 11 20C6.032 20 2 15.968 2 11C2 6.032 6.032 2 11 2C15.968 2 20 6.032 20 11C20 13.124 19.263 15.0769 18.031 16.6168ZM16.0247 15.8748C17.2475 14.6146 18 12.8956 18 11C18 7.1325 14.8675 4 11 4C7.1325 4 4 7.1325 4 11C4 14.8675 7.1325 18 11 18C12.8956 18 14.6146 17.2475 15.8748 16.0247L16.0247 15.8748Z" fill="rgba(58,78,132,1)"></path></svg>
                    조회
                </button>
            </article>
            <!-- 테이블 시작 -->
            <div id="maint" class="section-contents scrolling-table common-table-wrap">
                <table id="" class="common-data-table amount-table" style="border-block: 0;">
                    <colgroup>
                        <col class="tb-cell-year" />
                        <col class="tb-cell-year" />
                        <col class="tb-cell-instname" />
                        <col class="tb-cell-instname" />
                        <col class="tb-cell-instname" />
                        <col class="tb-cell-shortname" />
                        <col class="tb-cell-instname" />
                        <col class="tb-cell-instname" />
                        <col class="tb-cell-instname" />
                        <col class="tb-cell-instname" />               
                    </colgroup>
                    <thead>
                        <tr>
                            <th>순번</th>
                            <th>구분</th>
                            <th>차량번호</th>
                            <th>거래처</th>
                            <th>등급</th>
                            <th>인수량</th>
                            <th>공차중량</th>
                            <th>공차시간</th>
                            <th>총중량</th>
                            <th>총중량시간</th>
                            <th>대지중량</th>
                            <th>감량</th>
                            <th>감량 감가사유</th>
                            <th>검수판정(품목)</th>
                            <th>검수자</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach  var = "atd" items="${atdList}" varStatus="loop">
							 	<tr>
	                    			<td class = "center">${loop.index + 1}</td>
	                    			<td class = "center">${atd.keratype}</td>
									<td>${atd.jbnum}</td>
									<td style = "text-align:left">${atd.jcompany}</td>
									<td style = "text-align:left">${atd.gubun1}</td>
									<td><fmt:formatNumber value="${atd.oweight}" pattern="###,###.#" /></td>
									<td><fmt:formatNumber value="${atd.firstweight}" pattern="###,###.#" /></td>
									<td class = "center">${atd.firsttime}</td>
									<td><fmt:formatNumber value="${atd.secondweight}" pattern="###,###.#" /></td>
									<td class = "center">${atd.secondtime}</td>
									<td><fmt:formatNumber value="${atd.weight}" pattern="###,###.#" /></td>
									<td><fmt:formatNumber value="${atd.ochagam}" pattern="###,###.#" /></td>
									<td style = "text-align:left">${atd.jstate}</td>
									<td style = "text-align:left">${atd.gumsubigo}</td>
									<td class = "center">${atd.empnm}</td>
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
	    var jDate = document.getElementsByName('jDate')[0].value;
	    var sKeraType = document.querySelector('input[name="sKeraType"]:checked').value;
	    var sBigCate = document.getElementsByName('sBigCate')[0].value;
	
        //alert('jDate: ' + jDate + ', sKeraType: ' + sKeraType + ', sBigCate: ' + sBigCate);


        if(jDate == ''){
        	alert("계근일자를 선택해주세요.");
        }
        else{
        	// Ajax를 이용하여 컨트롤러로 값을 전송하고 결과를 받음
    	    $.ajax({
    	        url: "/exe/atdDaily/searchatdlist", // 실제 컨트롤러의 엔드포인트
    	        method: "POST",
    	        data: {jDate: jDate, sKeraType: sKeraType, sBigCate: sBigCate},
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