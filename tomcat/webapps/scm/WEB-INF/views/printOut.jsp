<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="now" value="<%=new java.util.Date()%>" />

<%@include file="/WEB-INF/views/include/header.jsp"%>
    <body>
        <div id="wrap">
            <main id="mainWrap" role="main">
                <link rel="stylesheet" type="text/css" href="/scm/resources/css/main/printOut.css">
                <!-- Per-Page CSS -->

                <script type="text/javascript" src="/scm/resources/js/main/printOut.js" defer></script>
                <!-- Per-Page JavaScript -->

				<div class="closeBtnBox">
					<button id="btnClose">닫기</button>
				</div>
				
                <div id="contentView">
                    <div id="printOut">
                        <table id="headTable">
                            <thead>
                                <tr>
                                    <th colspan="9">
                                        <h1 class="head_title">거래명세표</h1>
                                        <button id="btnPrint" class="print_page">인쇄</button>
                                    </th>
                                    <th class="large_text" ><fmt:formatDate value="${now}" pattern="yyyy. MM. dd"/></th>
                                </tr>
                                <tr data-hidden-aligner>
                                    <th colspan="5"></th>
                                    <th colspan="5"></th>
                                </tr>
                            </thead>

                            <tbody>
                                <tr>
                                    <th class="size__none" rowspan="4">공급자</th>
                                    <th class="size__title" scope="row">등록번호</th>
                                    <td class="large_text" colspan="3" data-pvd-no>${comInfo.IDT_NO}</td>
                                    <th class="size__none" rowspan="4">공급받는자</th>
                                    <th class="size__title" scope="row">등록번호</th>
                                    <td class="large_text" colspan="3" data-sup-no>${daejiInfo.SANO}</td>
                                </tr>
                                <tr>
                                    <th class="size__title" scope="row">법인명</th>
                                    <td class="large_text" colspan="2" data-pvd-co>${comInfo.DEALER_NM}</td>
                                    <td class="large_text" data-pvd-name>${comInfo.REP_NM}</td>
                                    <th class="size__title" scope="row">법인명</th>
                                    <td class="large_text" colspan="2" data-sup-co>${daejiInfo.COMNM}</td>
                                    <td class="large_text" data-sup-name>${daejiInfo.OWNAM}</td>
                                </tr>
                                <tr>
                                    <th class="size__title" scope="row">사업장 주소</th>
                                    <td class="large_text" colspan="3" data-pvd-addr>${comInfo.ADDR}</td>
                                    <th class="size__title" scope="row">사업장 주소</th>
                                    <td class="large_text" colspan="3" data-sup-addr>${daejiInfo.ADDR1}</td>
                                </tr>
                                <tr>
                                    <th class="size__title">업태</th>
                                    <td class="size__remain" data-pvd-did>${comInfo.BIZ_NM}</td>
                                    <th class="size__title">종목</th>
                                    <td class="size__remain" data-pvd-cat>${comInfo.TYPE_NM}</td>
                                    <th class="size__title">업태</th>
                                    <td class="size__remain" data-sup-did>${daejiInfo.UPTAE}</td>
                                    <th class="size__title">종목</th>
                                    <td class="size__remain" data-sup-cat>${daejiInfo.JONGK}</td>
                                </tr>
                            </tbody>
                        </table>

                        <table id="mainTable">
                            <thead>
                                <tr>
                                    <th class="large_text" >연도</th>
                                    <th class="large_text" colspan="2">월 / 일</th>
                                    <th class="large_text" >등급</th>
                                    <th class="large_text" >차량번호</th>
                                    <th class="large_text" >총중량</th>
                                    <th class="large_text" >감량</th>
                                    <th class="large_text" >단가</th>
                                    <th class="large_text" >공급가액</th>
                                    <th class="large_text" >세액</th>
                                    <th class="large_text" >매출합계</th>
                                </tr>
                            </thead>

                            <tbody data-row-list>
                            	<c:forEach items="${list}" var="item">
                            		<tr data-row-id>
			                            <td class="large_text" data-row-year>${item.YY}</td>
			                            <td class="large_text" data-row-month>${item.MM}</td>
			                            <td class="large_text" data-row-day>${item.DD}</td>
			                            <td class="large_text" data-row-grade>${item.GUBUN1}</td>
			                            <td class="large_text" data-row-carno>${item.J_BNUM}</td>
			                            <td class="large_text" data-row-totwgt><fmt:formatNumber value="${item.IWEIGHT}" pattern="#,###"/></td>
			                            <td class="large_text" data-row-rdcwgt><fmt:formatNumber value="${item.HALIN}" pattern="#,###"/></td>
			                            <td class="large_text" data-row-single><fmt:formatNumber value="${item.DANGA}" pattern="#,###"/></td>
			                            <td class="large_text" data-row-suprice><fmt:formatNumber value="${item.IKONGKEP}" pattern="#,###"/></td>
			                            <td class="large_text" data-row-tax><fmt:formatNumber value="${item.J_BUGASE}" pattern="#,###"/></td>
			                            <td class="large_text" data-row-totsales><fmt:formatNumber value="${item.TOTAMT}" pattern="#,###"/></td>
			                        </tr>
                            	</c:forEach>
	                            	<tr>
	                                    <td colspan="100%"></td>
	                                </tr>
	                                <tr id="tfoot">
	                                    <th class="large_text" colspan="3" scope="row">합계</th>
	                                    <td class="large_text" colspan="2" data-sum-car>차량 대 수 : </td>
	                                    <td class="large_text" data-sum-totwgt></td>
	                                    <td class="large_text" data-sum-rdcwgt></td>
	                                    <td></td>
	                                    <td class="large_text" data-sum-suprice></td>
	                                    <td class="large_text" data-sum-tax></td>
	                                    <td class="large_text" data-sum-totsales></td>
	                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <template data-table-row>
                        <tr data-row-id>
                            <td data-row-year></td>
                            <td data-row-month></td>
                            <td data-row-day></td>
                            <td data-row-grade></td>
                            <td data-row-carno></td>
                            <td data-row-totwgt></td>
                            <td data-row-rdcwgt></td>
                            <td data-row-single></td>
                            <td data-row-suprice></td>
                            <td data-row-tax></td>
                            <td data-row-totsales></td>
                        </tr>
                    </template>
                </div> <!-- #contentView -->
            </main> <!-- #mainWrap -->
            
<%@include file="/WEB-INF/views/include/footer.jsp"%> 