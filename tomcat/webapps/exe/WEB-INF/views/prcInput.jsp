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

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@latest/fonts/remixicon.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/view/css/style.css?v=<%=System.currentTimeMillis()%>">

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
                <li onclick="location.href='atdDaily'">일일계근</li>
                <li class="active" onclick="location.href='prcInput'">단가입력</li>
            </ul>
        </nav>
        <section id="textWrapper">
            <div class="title-compart">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16"><path d="M2 20H22V22H2V20ZM4 12H6V19H4V12ZM9 12H11V19H9V12ZM13 12H15V19H13V12ZM18 12H20V19H18V12ZM2 7L12 2L22 7V11H2V7ZM12 8C12.5523 8 13 7.55228 13 7C13 6.44772 12.5523 6 12 6C11.4477 6 11 6.44772 11 7C11 7.55228 11.4477 8 12 8Z" fill="rgba(58,78,132,1)"></path></svg>
                <h2>단가입력</h2>
            </div>
            <article class="section-control-compartment ft-wrap mi-0 al w-full mb-8 h-auto">
                <div class="labeled-input-binder ft-al-between">
                    <label for="" class="form-input-label">계근일자</label>

                    <div class="form-filter-date">
                        <div class="form-input-date">
                            <input type="text" id="SRCH_EVAL_SDT" name="sYmdFrom" class="date-picker flatpickr-input" value = ${sYmdFrom } readonly="readonly" >
                            <div class="date-calendar-icon">
                                <i class="ri-calendar-event-line"></i>
                            </div>
                        </div>
                        ~
                        <div class="form-input-date">
                            <input type="text" id="SRCH_EVAL_EDT" name="sYmdTo" class="date-picker flatpickr-input" value= ${sYmdTo } readonly="readonly">
                            <div class="date-calendar-icon">
                                <i class="ri-calendar-event-line"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="labeled-input-binder ml-12 ft-al-between">
                    <label for="" class="form-input-label">담당자</label>

                    <div class="form-input-search w-full">
                        <input type="text" id="COGRUP_NM" name="COGRUP_NM" class="search-result h-auto" readonly="" onclick="showCOGRUP()" value = ${empName }>
                        <div class="search-icon" onclick="showCOGRUP()">
                            <i class="ri-search-line"></i>
                        </div>
                    </div>
                </div>

                <div class="labeled-input-binder ml-12 ft-al-between">
                    <label for="" class="form-input-label">입출고구분</label>

                    <div class="form-filter-date gap-12 bg-gray">
                        <div class="form-input-checker">
                            <input type="radio" name="sKeraType" id="ftInput" value="IN" ${sKeraType == 'IN' ? 'checked="checked"' : ''} class="checker-element">
                            <label for="chkIn">입고</label>
                        </div>
                        <div class="form-input-checker">
                            <input type="radio" name="sKeraType" id="ftOutput" value="OUT" ${sKeraType == 'OUT' ? 'checked="checked"' : ''} class="checker-element">
                            <label for="chkOut">출고</label>
                        </div>
                    </div>
                </div>
                
                <div class="labeled-input-binder ml-12 ft-al-between">
                    <label for="" class="form-input-label">마감구분</label>

                    <div class="form-filter-date gap-12 bg-gray">
                        <div class="form-input-checker">
                            <input type="radio" name="jCheck" id="cCate_all" value="ALL" ${jCheck == 'ALL' ? 'checked="checked"' : ''} class="checker-element">
                            <label for="cCate_all">전체</label>
                        </div>
                        <div class="form-input-checker">
                            <input type="radio" name="jCheck" id="cCate_end" value="1" ${jCheck == '1' ? 'checked="checked"' : ''} class="checker-element">
                            <label for="cCate_end">마감</label>
                        </div>
                        <div class="form-input-checker">
                            <input type="radio" name="jCheck" id="cCate_nEnd" value="" ${jCheck == '' ? 'checked="checked"' : ''} class="checker-element">
                            <label for="cCate_end">미마감</label>
                        </div>
                    </div>
                </div>
                <button class="ml-auto common-button" type="button" onclick="submitForm()">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" fill="rgba(255,255,255, .5)"><path d="M18.031 16.6168L22.3137 20.8995L20.8995 22.3137L16.6168 18.031C15.0769 19.263 13.124 20 11 20C6.032 20 2 15.968 2 11C2 6.032 6.032 2 11 2C15.968 2 20 6.032 20 11C20 13.124 19.263 15.0769 18.031 16.6168ZM16.0247 15.8748C17.2475 14.6146 18 12.8956 18 11C18 7.1325 14.8675 4 11 4C7.1325 4 4 7.1325 4 11C4 14.8675 7.1325 18 11 18C12.8956 18 14.6146 17.2475 15.8748 16.0247L16.0247 15.8748Z"></path></svg>
                    조회
                </button>
                <button class="common-button" type="button" style="--button-face-color: #0075ff;" onclick="saveData()">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" fill="rgba(255,255,255,.5)"><path d="M7 19V13H17V19H19V7.82843L16.1716 5H5V19H7ZM4 3H17L21 7V20C21 20.5523 20.5523 21 20 21H4C3.44772 21 3 20.5523 3 20V4C3 3.44772 3.44772 3 4 3ZM9 15V19H15V15H9Z"></path></svg>
                    저장
                </button>
            </article>
            <!-- 테이블 시작 -->
            <div id="" class="section-contents scrolling-table common-table-wrap">
                <table id="" class="common-data-table amount-table" style="border-block: 0;">
                    <colgroup>
                        <col class="tb-cell-number" />
                        <col class="tb-cell-shortname" />
                        <col class="tb-cell-year" />
                        <col class="tb-cell-title" />
                        <col class="tb-cell-year" />
                        <col class="tb-cell-year" />
                        <col class="tb-cell-year" />

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
                            <th>마감</th>
                            <th>계근일자</th>
                            <th>거래구분</th>
                            <th>거래처명</th>
                            <th>담당자</th>
                            <th>차량번호</th>
                            <th>등급</th>

                            <th>감량</th>
                            <th>인수량</th>
                            <th>운반비</th>

                            <th>공차중량</th>
                            <th>총중량</th>
                            <th>기준단가</th>
                            <th>적용단가</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach  var = "prc" items="${prcList}" varStatus="loop">
							 	<tr>
							 		<td style="text-align:center" data-junpyoid="${prc.junpyoid}" class="center">
    									<input type="checkbox" id="checkbox_${prc.junpyoid}" ${prc.jcheck == '1' ? 'checked' : ''} onclick = "return false">
									</td>
									<!-- <td style = "text-align:center" data-junpyoid ="${prc.junpyoid }" class = "center"><input type="checkbox"></td> -->
	                    			<td class = "center">${prc.jdate}</td>
									<td style = "text-align:center">${prc.keratype}</td>
									<td style = "text-align:left">${prc.dealernm}</td>
									<td>${prc.chrgnm}</td>
									<td>${prc.jbnum}</td>
									<td>${prc.gradenm}</td>
									<td><fmt:formatNumber value="${prc.chagamweight}" pattern="###,###.#" /></td>
									<td><fmt:formatNumber value="${prc.acptweight}" pattern="###,###.#" /></td>
									<td><fmt:formatNumber value="${prc.transportkumak}" pattern="###,###.#" /></td>
									<td><fmt:formatNumber value="${prc.emptyweight}" pattern="###,###.#" /></td>
									<td><fmt:formatNumber value="${prc.totweight}" pattern="###,###.#" /></td>
									<td><fmt:formatNumber value="${prc.stdunitprc}" pattern="###,###.#" /></td>
									<td><input class="inputText" type="text" placeholder="${prc.applyunitprc } " ${prc.jcheck == '1' ? 'disabled' : ''} ></td>
	                    		</tr>  
                    	</c:forEach>
                    </tbody>
                </table>
            </div>
            <!-- 테이블 끝 -->
        </section>
    </div>

    <!-- 담당자 Modal -->
    <dialog id="modalCogrup" class="common-modal">
	    <div class="common-modal-container">
	        <div class="modal-titlebar">
	            <div class="modal-icon">
	                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" opacity=".5"><path fill="currentColor" d="M12 14V16C8.68629 16 6 18.6863 6 22H4C4 17.5817 7.58172 14 12 14ZM12 13C8.685 13 6 10.315 6 7C6 3.685 8.685 1 12 1C15.315 1 18 3.685 18 7C18 10.315 15.315 13 12 13ZM12 11C14.21 11 16 9.21 16 7C16 4.79 14.21 3 12 3C9.79 3 8 4.79 8 7C8 9.21 9.79 11 12 11ZM21.4462 20.032L22.9497 21.5355L21.5355 22.9497L20.032 21.4462C19.4365 21.7981 18.7418 22 18 22C15.7909 22 14 20.2091 14 18C14 15.7909 15.7909 14 18 14C20.2091 14 22 15.7909 22 18C22 18.7418 21.7981 19.4365 21.4462 20.032ZM18 20C19.1046 20 20 19.1046 20 18C20 16.8954 19.1046 16 18 16C16.8954 16 16 16.8954 16 18C16 19.1046 16.8954 20 18 20Z"></path></svg>
	            </div>
	            <div class="modal-label">
	                중앙부처 검색
	            </div>
	        </div>
	        <section class="modal-contents h-md-body">
	        	<div class="modal-section-title h-auto mt-12">
                    <svg xmlns="http://www.w3.org/2000/svg" class="modal-section-icon" viewBox="0 0 24 24" width="16" height="16" opacity=".5"><path fill="currentColor" d="M18.031 16.6168L22.3137 20.8995L20.8995 22.3137L16.6168 18.031C15.0769 19.263 13.124 20 11 20C6.032 20 2 15.968 2 11C2 6.032 6.032 2 11 2C15.968 2 20 6.032 20 11C20 13.124 19.263 15.0769 18.031 16.6168ZM16.0247 15.8748C17.2475 14.6146 18 12.8956 18 11C18 7.1325 14.8675 4 11 4C7.1325 4 4 7.1325 4 11C4 14.8675 7.1325 18 11 18C12.8956 18 14.6146 17.2475 15.8748 16.0247L16.0247 15.8748Z"></path></svg>
                    <span class="modal-section-label">담당자 검색</span>
                </div>
	            
	            <div class="modal-search-compartment">
						<div class="form-input-text">
	                        <input type="text" id="srchKeyword" name="srchKeyword" class="input-element" placeholder="키워드 입력...">
	                    </div>

	                <button type="button" id="btnSearch" class="common-button" style="--button-face-color: #32c05a;" onclick = "searchEmp()">
	                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="16" height="16" opacity=".5"><path fill="currentColor" d="M10.0007 15.1709L19.1931 5.97852L20.6073 7.39273L10.0007 17.9993L3.63672 11.6354L5.05093 10.2212L10.0007 15.1709Z"></path></svg>
	                    <span class="common-button-label">검색</span>
	                </button>
	            </div>
	            <!-- 테이블 시작 -->
	            <div class="section-contents scrolling-table for-md-scr mi-0 mh-auto">
	                <table id="tablePIC" class="common-data-table uploaded-table">
	                    <colgroup>
	                        <col class="tb-cell-instname"/>
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th class="left">영업사원목록</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<tr>
								<td style = "text-align:left" class="tb-cell-body-title cursor-pointer" onclick="selectCogrup(this)">전체</td>
							</tr>
	                    	<c:forEach  var = "emp" items="${empList}" varStatus="loop">
							 <tr>
								<td style = "text-align:left" class="tb-cell-body-title cursor-pointer" onclick="selectCogrup(this)">${emp.empnm}</td>
							</tr>  
                    		</c:forEach>
	                    </tbody>
	                </table>
	            </div>
	        </section>
	        <div class="modal-control-compartment">
	            <button type="button" class="common-button" onclick="closeCOGRUP()">
	                <svg xmlns="http://www.w3.org/2000/svg" class="common-button-icon" viewBox="0 0 24 24" width="16" height="16"><path d="M12.0007 10.5865L16.9504 5.63672L18.3646 7.05093L13.4149 12.0007L18.3646 16.9504L16.9504 18.3646L12.0007 13.4149L7.05093 18.3646L5.63672 16.9504L10.5865 12.0007L5.63672 7.05093L7.05093 5.63672L12.0007 10.5865Z"></path></svg>
	                <span class="common-button-label">닫기</span>
	            </button>
	        </div>
	    </div>
	</dialog>
</body>

<script>
    const modalCogrup = document.getElementById('modalCogrup');

    function showCOGRUP() {
        modalCogrup.showModal();
    }

    function closeCOGRUP() {
        modalCogrup.close();
    }

    $(window).load(function(){
        //달력
    	const fpOption = {
                locale: 'ko', // 한국어 locale 설정
                dateFormat: 'Y-m-d',
                disableMobile: true
            };

            flatpickr.localize(flatpickr.l10ns.ko); // 한국어로 설정
            $(".date-picker").flatpickr(fpOption);
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
	    var sYmdFrom = document.getElementsByName('sYmdFrom')[0].value;
	    var sYmdTo = document.getElementsByName('sYmdTo')[0].value;
	    //var sUtPrcYn = document.querySelector('input[name="sUtPrcYn"]:checked').value;
	    var sKeraType = document.querySelector('input[name="sKeraType"]:checked').value;
	    var empName = document.getElementsByName('COGRUP_NM')[0].value;
	    var jCheck = document.querySelector('input[name="jCheck"]:checked').value;
	
        //alert('날짜 : ' + sYmdFrom + "~" + sYmdTo + ', sKeraType: ' + sKeraType);


        if(sYmdFrom == '' || sYmdTo == ''){
        	alert("계근일자를 선택해주세요.");
        }
        else{
        	// Ajax를 이용하여 컨트롤러로 값을 전송하고 결과를 받음
    	    $.ajax({
    	        url: "/exe/prcInput/prclist", // 실제 컨트롤러의 엔드포인트
    	        method: "POST",
    	        data: {sYmdFrom: sYmdFrom, sYmdTo: sYmdTo, sKeraType: sKeraType, empName: empName, jCheck: jCheck},
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
	
    function saveData() {
        var selectedRows = [];
        var isAnyCheckboxChecked = false;
        var count = 0;
        var checkcount = 0;
        var jCheck = $("input[name='jCheck']:checked").val(); 
        
        if(jCheck == '1'){
        	alert("마감승인된 자료는 단가수정이 불가능합니다.");
        	return;
        }

        $("input[type=checkbox]").each(function () {
            if ($(this).prop('checked')) {
                isAnyCheckboxChecked = true;  // 체크 - 마감된 데이터는 변경 불가능하게 하기 위해서
            }
            else {
            	checkcount++;
            }

            
            var junpyoid = $(this).closest("tr").find("[data-junpyoid]").data("junpyoid");
            var inputValue = $(this).closest("tr").find(".inputText").val();
            
			if (inputValue != ""){
	            var keratype = $(this).closest("tr").find('td:eq(2)').text().trim(); // 3번째 열에 있는 값 가져오기
	            count++;
			}
            
            // 만약 입력값이 비어 있다면 placeholder 값으로 대체
            if (inputValue == "") {
                inputValue = $(this).closest("tr").find(".inputText").attr("placeholder");
            }
            
            selectedRows.push({ junpyoid: junpyoid, inputValue: inputValue, keratype: keratype });
        });
        
        if(checkcount == 0){       	
            alert("마감승인된 자료는 단가수정이 불가능합니다.");
            return;
        }

        if(count == 0){
        	alert("적용단가를 한개 이상 입력해주세요.");
        	return;
        }
<%--     if (isAnyCheckboxChecked) {
              alert("마감승인된 자료는 단가수정이 불가능합니다.");
            return;
        }
--%>

		
		
        console.log(selectedRows);

        $.ajax({
            url: "/exe/prcInput/prcupdate",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(selectedRows),
            success: function (response) {
                console.log(response);
                alert("저장되었습니다.");
                submitForm();
            },
            error: function (error) {
                console.error("에러입니당");
            }
        });
    }
	 
	 function searchEmp() {
		    var keyword = document.getElementById('srchKeyword').value.trim();

		    var rows = document.querySelectorAll('#tablePIC tbody tr');

		    rows.forEach(function(row) {
		        var empName = row.querySelector('td').textContent.trim();
		        
		        if (empName.includes(keyword)) {
		        	
		            row.style.display = 'table-row';
		            
		        } else {
		            
		            row.style.display = 'none';
		        }
		    });
		}
	 
	 function selectCogrup(clickedElement) {
		    var empName = clickedElement.textContent.trim(); 
		    document.getElementById('COGRUP_NM').value = empName;
		    closeCOGRUP();
		}
    
</script>
</html>