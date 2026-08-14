<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" href="/daejiM/resources/view/css/priceInput.css" />
<script src="/daejiM/resources/view/js/priceInput/priceInput.js?v=<%=System.currentTimeMillis()%>" defer></script>

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
                            <input type="date" id="fDate">
                            <button type="button" class="rightBtn arrowBtn" id="nextDateBtn"><i class="ri-arrow-right-line"></i></button>
                            <select id="findObj">
                                <option value="0">거래처명</option>
                            </select>
                            <input id="findWord" type="text" placeholder="검색어 입력...">
                            
                        </div>
            
                        <div class="closure">
                            <article class="">
                                <label><input type="radio" id="all" name="Weight" value="ALL"> 전체</label>
                                <label><input type="radio" id="outCome" name="Weight" value="Y"> 입력</label>
                                <label><input type="radio" id="direct" name="Weight" value="N" checked> 미입력</label>
                            </article>
                            <article class="closure_in">
                                <label><input type="radio" id="all1" name="outCome" value="ALL" checked> 전체</label>
                                <label><input type="radio" id="outCome" name="outCome" value="입고"> 입고</label>
                                <label><input type="radio" id="direct" name="outCome" value="출고"> 출고</label>
                            </article>
                        </div>
                        <div class="submitBtn">
                            <button type="button" id="BtnRetr">조회</button>
                            <button type="button" id="BtnSave">저장</button>
                        </div>
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
                                        <p>거래처명</p>
                                    </th>
                                    <th>
                                        <p>차량번호</p>
                                    </th>
                                    <th>
                                        <p>등급</p>
                                    </th>
                                    <th>
                                        <p>감량중량</p>
                                    </th>
                                    <th>
                                        <p>인수량</p>
                                    </th>
                                    <th>
                                        <p>업체중량</p>
                                    </th>
                                    <th>
                                        <p>Loss중량</p>
                                    </th>
                                    <th>
                                        <p>기준단가</p>
                                    </th>
                                    <th>
                                        <p>적용단가</p>
                                    </th>
                                    <th>
                                        <p>차액</p>
                                    </th>
                                    <th>
                                        <p>운반비</p>
                                    </th>
                                    <th>
                                        <p>운반비단가</p>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="bTbody">
                                <!-- <tr>
                                    <td class="rowColumn" contenteditable="false" data-default="">1</td>
                                    <td class="rowColumn" contenteditable="false" data-default="">주식회사광양이엔에스(광양)</td>
                                    <td class="rowColumn" contenteditable="false" data-default="">1231</td>
                                    <td class="rowColumn" contenteditable="false" data-default="">납품잔량 ak</td>
                                    <td class="rowColumn" contenteditable="false" data-default="">500</td>
                                    <td class="rowColumn" contenteditable="false" data-default="">23,000</td>
                                    <td class="rowColumn" contenteditable="false" data-default="">25,000</td>
                                    <td class="rowColumn" contenteditable="false" data-default="">40,000</td>
                                    <td class="rowColumn" contenteditable="false" data-default="">123</td>
                                    <td class="green rowColumn" contenteditable="false" data-default="">604.99</td>
                                    <td class="rowColumn" contenteditable="false" data-default="">4.99</td>
                                    <td class="yellow rowColumn" contenteditable="false" data-default="">0</td>
                                    <td class="rowColumn" contenteditable="false" data-default="">0</td>
                                </tr> -->
                           </tbody>
                           
                        </table>
                    </div>
                    <div id="pagination" class="tui-pagination"></div>
                </div>
            </div> <!-- #contentView -->
        </main>
    </div>

</body>
</html>