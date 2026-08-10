<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html lang="kor">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>대지에스텍</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/view/css/style.css?v=<%=System.currentTimeMillis()%>">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@latest/fonts/remixicon.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

	<script src="${pageContext.request.contextPath}/resources/common/js/common.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
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
            <article class="section-control-compartment ft-wrap mi-0 al w-full mb-8 h-auto">
                <div class="labeled-input-binder ft-al-between">
                    <label for="" class="form-input-label">계근일자</label>

                    <div class="form-filter-date">
                        <div class="form-input-date">
                            <input type="text" id="SRCH_EVAL_SDT" name="jDate" class="date-picker flatpickr-input" value= ${jDate } readonly="readonly">
                            <div class="date-calendar-icon">
                                <i class="ri-calendar-event-line"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="labeled-input-binder ml-12 ft-al-between">
                    <label for="" class="form-input-label">입출고구분</label>

                    <div class="form-filter-date gap-12 bg-gray">
                    <div class="form-input-checker">
                            <input type="radio" name="sKeraType" id="ftAll" value="ALL" class="checker-element" ${sKeraType == 'ALL' ? 'checked="checked"' : ''}>
                            <label for="ftAll">전체</label>
                        </div>
                        <div class="form-input-checker">
                            <input type="radio" name="sKeraType" id="ftInput" value="IN" class="checker-element" ${sKeraType == 'IN' ? 'checked="checked"' : ''}>
                            <label for="ftInput">입고</label>
                        </div>
                        <div class="form-input-checker">
                            <input type="radio" name="sKeraType" id="ftOutput" value="OUT" class="checker-element" ${sKeraType == 'OUT' ? 'checked="checked"' : ''}>
                            <label for="ftOutput">출고</label>
                        </div>
                    </div>
                </div>

                <div class="labeled-input-binder ml-12 ft-al-between mn-w-130">
                    <label for="" class="form-input-label">대분류</label>
                    <div class="form-input-select" style="width: 100%;">
                        <select id="calcType" name="sBigCate" class="select-element">
                            <option value="">전체</option>
                            <option value="슈레더" ${sBigCate == '슈레더' ? 'selected' : ''}>슈레더</option>
						    <option value="고철A" ${sBigCate == '고철A' ? 'selected' : ''}>고철A</option>
						    <option value="고철B" ${sBigCate == '고철B' ? 'selected' : ''}>고철B</option>
                        </select>
                        <div class="select-arrow-icon">
                            <i class="ri-arrow-down-s-line"></i>
                        </div>
                    </div>
                </div>

                <button class="ml-auto common-button" type="button" onclick="submitForm()">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16"><path fill="#fff" d="M18.031 16.6168L22.3137 20.8995L20.8995 22.3137L16.6168 18.031C15.0769 19.263 13.124 20 11 20C6.032 20 2 15.968 2 11C2 6.032 6.032 2 11 2C15.968 2 20 6.032 20 11C20 13.124 19.263 15.0769 18.031 16.6168ZM16.0247 15.8748C17.2475 14.6146 18 12.8956 18 11C18 7.1325 14.8675 4 11 4C7.1325 4 4 7.1325 4 11C4 14.8675 7.1325 18 11 18C12.8956 18 14.6146 17.2475 15.8748 16.0247L16.0247 15.8748Z" fill="rgba(58,78,132,1)"></path></svg>
                    조회
                </button>
                <button class="common-button" type="button" onclick="showViewTbMd()" style="--button-face-color: #0075ff;">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" fill="rgba(255,255,255,1)"><path d="M20 2C21.6569 2 23 3.34315 23 5V7H21V19C21 20.6569 19.6569 22 18 22H4C2.34315 22 1 20.6569 1 19V17H17V19C17 19.5128 17.386 19.9355 17.8834 19.9933L18 20C18.5128 20 18.9355 19.614 18.9933 19.1166L19 19V4H6C5.48716 4 5.06449 4.38604 5.00673 4.88338L5 5V15H3V5C3 3.34315 4.34315 2 6 2H20Z"></path></svg>
                    계근표보기
                </button>

            </article>

            <!-- 테이블 시작 -->
            <div id="" class="section-contents scrolling-table common-table-wrap">
                <table id="" class="common-data-table amount-table tch-tb" style="border-block: 0;">
                    <colgroup>
                        <col class="tb-cell-number" />
                        <col class="tb-cell-year" />
                        <col class="tb-cell-year" />
                        <col class="tb-cell-instname" />
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
                            <th></th>
                            <th>구분</th>
                            <th>차량번호</th>
                            <th>거래처</th>
                            <th>등급</th>
                            <th>인수량</th>
                            <th>공차중량</th>
                            <th>총중량</th>
                            <th>감량</th>
                            <th>감량 감가사유</th>
                            <th>검수판정(품목)</th>
                            <th>검수자</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach  var = "atd" items="${atdList}" varStatus="loop">
							<tr>
								<td>
                                	<div class="form-input-checker">
                                    <input type="radio" name="atdList" id="atd1" class="checker-element">
                                	</div>
                            	</td>
	                    		<td class = "center">${atd.keratype}</td>
								<td>${atd.jbnum}</td>
								<td class="left tb-cell-title view-ellipsis">
									<p> ${atd.jcompany}</p>
                                	<label class="elp-txt"></label>
                                </td>
								<td class="left">${atd.gubun1}</td>
								<td><fmt:formatNumber value="${atd.oweight}" pattern="###,###.#" /></td>
								<td><fmt:formatNumber value="${atd.firstweight}" pattern="###,###.#" /></td>
								<td><fmt:formatNumber value="${atd.secondweight}" pattern="###,###.#" /></td>
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

    <dialog id="viewTb" class="view-img-md">
        <img src="${pageContext.request.contextPath}/resources/view/img/sample_img.jpg" alt="계근표 이미지">
        <button class="view-img-md-close" type="button" onclick="closeViewTbMd()">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="14" height="14" fill="rgba(255,255,255,.5)"><path d="M12 22C6.47715 22 2 17.5228 2 12C2 6.47715 6.47715 2 12 2C17.5228 2 22 6.47715 22 12C22 17.5228 17.5228 22 12 22ZM12 20C16.4183 20 20 16.4183 20 12C20 7.58172 16.4183 4 12 4C7.58172 4 4 7.58172 4 12C4 16.4183 7.58172 20 12 20ZM12 10.5858L14.8284 7.75736L16.2426 9.17157L13.4142 12L16.2426 14.8284L14.8284 16.2426L12 13.4142L9.17157 16.2426L7.75736 14.8284L10.5858 12L7.75736 9.17157L9.17157 7.75736L12 10.5858Z"></path></svg>
            닫기
        </button>
    </dialog>
</body>
<script>
    const viewTbMd = document.getElementById('viewTb');
    const viewElpBtn = document.querySelectorAll('.view-ellipsis');
    const elpTxts = document.querySelectorAll('.elp-txt');

    console.log(elpTxts)

    viewElpBtn.forEach(function(f) {
        f.addEventListener('click', function(g) {
            console.log(f.children[1])
            f.classList.add('on');
           
            console.log(f.children[1].textContent)
            if ( f.children[1].innerText == '') {
                f.children[1].innerText = f.innerText;
            } else {
                f.children[1].innerText = ''
                f.classList.remove('on');
            }
            

        })
    })


    function showViewTbMd() {
        viewTbMd.showModal();
    }

    function closeViewTbMd() {
        viewTbMd.close();
    }

    $(window).load(function(){
        //달력
        const fpOption = {
            locale: 'ko',
            dateFormat: 'Y-m-d'
        }

        flatpickr.localize(flatpickr.l10ns.kr);
        flatpickr(SRCH_EVAL_SDT, fpOption);
        flatpickr(SRCH_EVAL_EDT, fpOption);

        $(".date-picker").flatpickr({
            disableMobile: true
        })
    });

    function initializeFlatpickr() {
        const fpOption = {
            locale: 'ko', // 한국어 locale 설정
            dateFormat: 'Y-m-d',
            disableMobile: true
        };

        flatpickr.localize(flatpickr.l10ns.ko); // 한국어로 설정
        $(".date-picker").flatpickr(fpOption);
    }

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
                    initializeFlatpickr();
    	        },
    	        error: function(error) {
    	            console.error(error);
    	        }
    	    });
        }
	}
    
    
</script>
</html>