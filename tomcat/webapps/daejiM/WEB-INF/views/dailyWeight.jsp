<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" href="/daejiM/resources/view/css/dailyWeight.css" />
<script src="/daejiM/resources/view/js/dailyWeight/dailyWeight.js?v=<%=System.currentTimeMillis()%>"></script>

	<div id="wrap">
        <header>
            <nav>
                <div class="prev" onclick="location.href='/daejiM/main'"><svg xmlns="http://www.w3.org/2000/svg"
                        viewBox="0 0 24 24" width="24" height="24">
                        <path fill="none" d="M0 0H24V24H0z" />
                        <path
                            d="M14 4.5V9c5.523 0 10 4.477 10 10 0 .273-.01.543-.032.81-1.463-2.774-4.33-4.691-7.655-4.805L16 15h-2v4.5L6 12l8-7.5zm-6 0v2.737L2.92 12l5.079 4.761L8 19.5 0 12l8-7.5z"
                            fill="rgba(255,255,255,1)" />
                    </svg></div>
                <h4>대지에스텍</h4>
                <div>
                    <img src="/daejiM/resources/common/img/logo_W.png">
                </div>
            </nav>
        </header>

        <main id="mainWrap">
            <div id="contentView">

                <div class="list_title search">
                    <form>
                        <div class="closure">
                            <button type="button" class="leftBtn arrowBtn" id="prvDateBtn"><i class="ri-arrow-left-line"></i></button>
                            <input type="date" id="fDate" min="0000-01-01" max="9999-12-31">
                            <button type="button" class="rightBtn arrowBtn" id="nextDateBtn"><i class="ri-arrow-right-line"></i></button>
                            <article class="closure_in">
                                <label><input type="radio" id="all" name="Weight" value="ALL" checked> 전체</label>
                                <label><input type="radio" id="outCome" name="Weight" value="IN"> 입고</label>
                                <label><input type="radio" id="direct" name="Weight" value="OUT"> 출고</label>
                            </article>
                            <article class="closure_in">
	                            <label><input type="checkbox" name="chkDaegb" value="고철A"><span> 고철A</span></label>
	                            <label><input type="checkbox" name="chkDaegb" value="고철B"><span> 고철B</span></label>
	                            <label><input type="checkbox" name="chkDaegb" value="슈레더"><span> 슈레더</span></label>
	                        </article>
                        </div>
                        <button type="button" class="SearchBtn" id="BtnRetr">조회</button>
                    </form>
                </div>

                <div class="list_table">
                    <div class="list_table_in">

                        <table id="jb-table">
                           
                            <thead>
                                <tr>
                                    <th>
                                        <p>순번</p>
                                    </th>
                                    <th>
                                        <p>구분</p>
                                    </th>
                                    <th>
                                        <p>차량번호</p>
                                    </th>
                                    <th>
                                        <p>거래처</p>
                                    </th>
                                    <th>
                                        <p>등급</p>
                                    </th>
                                    <th>
                                        <p>대지중량</p>
                                    </th>
                                    <th>
                                        <p>인수량</p>
                                    </th>
                                    <th>
                                        <p>감량</p>
                                    </th>
                                    <th>
                                        <p>감량 감가사유</p>
                                    </th>
                                    <th>
                                        <p>검수판정(품목)</p>
                                    </th>
                                    <th>
                                        <p>검수자</p>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="bTbody">
                                <!-- <tr>
                                    <td>
                                        <p class="rowColumn" contenteditable="false" data-default="">2</p>
                                    </td>
                                    <td>
                                        <p class="rowColumn" contenteditable="false" data-default="">입고</p>
                                    </td>
                                    <td>
                                        <p class="rowColumn" contenteditable="false" data-default="">1231</p>
                                    </td>
                                    <td>
                                        <p class="rowColumn" contenteditable="false" data-default="">주식회사광양이엔에스(광양)</p>
                                    </td>
                                    <td>
                                        <p class="rowColumn" contenteditable="false" data-default="">납품잔량 ABH</p>
                                    </td>
                                    <td>
                                        <p class="rowColumn" contenteditable="false" data-default="">23,000</p>
                                    </td>
                                    <td>
                                        <p class="rowColumn" contenteditable="false" data-default="">25,000</p>
                                    </td>
                                    <td>
                                        <p class="rowColumn" contenteditable="false" data-default="">40,000</p>
                                    </td>
                                    <td>
                                        <p class="rowColumn" contenteditable="false" data-default="">폐기물 혼합</p>
                                    </td >
                                    <td>
                                        <p class="rowColumn" contenteditable="false" data-default="">경량BI, 생활고철, 용접기, 바리시</p>
                                    </td >
                                    <td>
                                        <p class="rowColumn" contenteditable="false" data-default="">김홍철</p>
                                    </td >
                                </tr> -->
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td>합계</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>

                            </tfoot>
                        </table>
                    </div>
                    <div id="pagination" class="tui-pagination"></div>
                </div>
            </div> <!-- #contentView -->
        </main>
    </div>

</body>
</html>