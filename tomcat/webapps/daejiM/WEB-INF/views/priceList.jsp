        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <%@include file="/WEB-INF/views/include/header.jsp" %>

        <link rel="stylesheet" href="/daejiM/resources/view/css/priceList.css" />
        <script src="/daejiM/resources/view/js/priceList/priceList.js?v=<%=System.currentTimeMillis()%>"></script>

        <div id="wrap">
            <header>
                <nav>
                    <div class="prev" onclick="location.href='/daejiM/main'">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
                            <path fill="none" d="M0 0H24V24H0z" />
                            <path d="M14 4.5V9c5.523 0 10 4.477 10 10 0 .273-.01.543-.032.81-1.463-2.774-4.33-4.691-7.655-4.805L16 15h-2v4.5L6 12l8-7.5zm-6 0v2.737L2.92 12l5.079 4.761L8 19.5 0 12l8-7.5z" fill="rgba(255,255,255,1)" />
                        </svg>
                    </div>

                    <h4>대지에스텍</h4>

                    <div>
                        <img src="/daejiM/resources/common/img/logo_W.png">
                    </div>
                </nav>
            </header>

            <main id="mainWrap">
                <div id="contentView">
                    <!-- <div class="list_title">
                        <form>
                            <button type="button" id="BtnRetr">조회</button>
                        </form>
                    </div> -->

                    <div class="price_table">
                        <h4>매입기준 단가표

                        <div class="price_table_date">
                            <p>
                                스크랩 <input id="scrap" type="date" min="0000-01-01" max="9999-12-31">
                            </p>
                            <p>
                                폐압 <input id="sureder" type="date" min="0000-01-01" max="9999-12-31">
                            </p>
                        </div>
                    </div>

                    <div class="list_table">
                        <div class="list_table_in">
                            <table id="jb-table">
                                <thead>
                                    <tr>
                                        <th colspan=""></th>
                                        <th colspan="8">제 강 사</th>
                                        <th>야드 도착</th>
                                    </tr>
                                </thead>

                                <thead class="table_mak">
                                    <tr id="th_title">
                                        <th>
                                            <p>등급</p>
                                        </th>
                                        <th>
                                            <p>현대 제철</p>
                                        </th>
                                        <th>
                                            <p>동국 (포항)</p>
                                        </th>
                                        <th>
                                            <p>대한</p>
                                        </th>
                                        <th>
                                            <p>한국 철강</p>
                                        </th>
                                        <th>
                                            <p>한국 특강</p>
                                        </th>
                                        <th>
                                            <p>포스코(광양)</p>
                                        </th>
                                        <th>
                                            <p>포스코(포항)</p>
                                        </th>
                                        <th>
                                            <p>세아 창원</p>
                                        </th>
                                        <th>
                                            <p>인근 (기준)</p>
                                        </th>
                                    </tr>

                                    <tr id="th_title">
                                        <th>
                                            <p></p>
                                        </th>
                                        <th id="dt1"></th>
                                        <th id="dt2"></th>
                                        <th id="dt3"></th>
                                        <th id="dt4"></th>
                                        <th id="dt5"></th>
                                        <th id="dt6"></th>
                                        <th id="dt7"></th>
                                        <th id="dt8"></th>
                                        <th id="dt9"></th>
                                    </tr>

                                    <tr class="table_mak" id="table_mak">
                                        <th>
                                            <p></p>
                                        </th>
                                        <th id="RK1" class="rowColumn" data-default=""></th>
                                        <th id="RK2" class="rowColumn" data-default=""></th>
                                        <th id="RK3" class="rowColumn" data-default=""></th>
                                        <th id="RK4" class="rowColumn" data-default=""></th>
                                        <th id="RK5" class="rowColumn" data-default=""></th>
                                        <th id="RK6" class="rowColumn" data-default=""></th>
                                        <th id="RK7" class="rowColumn" data-default=""></th>
                                        <th id="RK8" class="rowColumn" data-default=""></th>
                                        <th id="RK9" class="rowColumn" data-default=""></th>
                                    </tr>
                                </thead>

                                <tbody id="scrapBody">
                                    <tr>
                                        <td>
                                            <p class="rowColumn" contenteditable="true" data-default="">생철</p>
                                        </td>
                                        <td>
                                            <p class="rowColumn" contenteditable="true" data-default="">485</p>
                                        </td>
                                        <td>
                                            <p class="rowColumn" contenteditable="true" data-default="">485</p>
                                        </td>
                                        <td>
                                            <p class="rowColumn" contenteditable="true" data-default="">485</p>
                                        </td>
                                        <td>
                                            <p class="rowColumn" contenteditable="true" data-default="">485</p>
                                        </td>
                                        <td>
                                            <p class="rowColumn" contenteditable="true" data-default="">485</p>
                                        </td>
                                        <td>
                                            <p class="rowColumn" contenteditable="true" data-default="">485</p>
                                        </td>
                                        <td>
                                            <p class="rowColumn" contenteditable="true" data-default="">485</p>
                                        </td>
                                        <td>
                                            <p class="rowColumn" contenteditable="true" data-default="">485</p>
                                        </td>
                                        <td>
                                            <p class="rowColumn" contenteditable="true" data-default="">485</p>
                                        </td>
                                    </tr>
                                </tbody>

                                <thead class="table_mak">
                                    <tr>
                                        <th>등급</th>
                                        <th colspan="2">야드(후)</th>
                                        <th colspan="5"></th>
                                        <th colspan="2">야드(후)</th>
                                    </tr>

                                    <tr>
                                        <th></th>
                                        <th colspan="2" id="BfSuDt"></th>
                                        <th colspan="5"></th>
                                        <th colspan="2" id="AfSuDt"></th>
                                    </tr>
                                </thead>

                                <tbody id="surederBody">
                                    <tr>
                                        <td>모재B</td>
                                        <td colspan="2">
                                            <p class="rowColumn" contenteditable="true" data-default="">12</p>
                                        </td>
                                        <td colspan="5">
                                            <p></p>
                                        </td>
                                        <td colspan="2">
                                            <p class="rowColumn" contenteditable="true" data-default="">134</p>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div> <!-- #contentView -->
            </main>
        </div>
    </body>
</html>