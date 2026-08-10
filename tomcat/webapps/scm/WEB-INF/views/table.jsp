<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>

    <body>
        <a href="#mainWrap" id="skipToMain" tabindex="0">Skip To Main Contents</a> <!-- 메인 컨텐츠 영역으로 건너뛰기 (접근성) -->

        <div id="wrap">
            <header id="headPrimary">
                <nav id="navPrimary" role="navigation">

                </nav>
            </header> <!-- #headPrimary -->

            <main id="mainWrap" role="main">
                <link rel="stylesheet" type="text/css" href="/scm/resources/css/main/table.css">
                <!-- Per-Page CSS -->

                <script type="text/javascript" src="/scm/resources/js/main/table.js?v=<%=System.currentTimeMillis()%>" defer></script>
                <!-- Per-Page JavaScript -->

                <div id="contentView">
                    <header id="tableHeader">
                        <img src="/scm/resources/images/main/header.jpg" class="header_image">
                        <div class="logo" onclick='location.href="http://daejist.co.kr"'>
                            <img src="/scm/resources/images/main/logo.png">
                            <h1>(주)대지에스텍</h1>
                        </div>
                        <div class="header_text">철스크랩 전문 기업 <p>(주)대지에스텍</p></div>
                    </header>

                    <div id="accChangePW">
                        로그인 비밀번호 변경
                        <input type="text" name="txtChangePW" id="txtChangePW" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$" maxlength="20">
                        <button id="chgPw">변경</button>
                        <button id="logout">로그아웃</button>
                    </div>

                    <div id="listTable">
                        <div id="tableFilter">
                            <span>조회기간</span>

                            <input type="date" name="dateRange" id="dateBegin" data-label="시작일자" min="0000-00-00" max="9999-12-31">
                            ~
                            <input type="date" name="dateRange" id="dateEnd" data-label="종료일자" min="0000-00-00" max="9999-12-31">

                            <button type="button" id="btnApply">조회</button>
                        </div>

                        <div id="carryOver">
                            <button id="printOut">거래명세서</button>

                            <label for="txtCarryOver">이월금액</label>
                            <input type="text" name="txtCarryOver" id="txtCarryOver" class="exclude" value="0" readonly>
                        </div>

                        <table>
                            <colgroup>
                                <!-- 13 -->
                                <col class="data_no">
                                <col class="data_date">
                                <col class="data_carno">
                                <col class="data_grade">
                                <col class="data_weight">
                                <col class="data_single">
                                <col class="data_wgtsum">
                                <!-- <col class="data_logis"> -->
                                <col class="data_price">
                                <col class="data_tax">
                                <col class="data_recieve">
                                <col class="data_remain">
                                <col class="data_receipt">
                            </colgroup>

                            <thead>
                                <tr>
                                    <th scope="col">순번</th>
                                    <th scope="col">일자</th>
                                    <th scope="col">차량번호</th>
                                    <th scope="col">등급</th>
                                    <th scope="col">중량</th>
                                    <th scope="col">단가</th>
                                    <th scope="col">감량증량</th>
                                    <!-- <th scope="col">운반비</th> -->
                                    <th scope="col">공급가액</th>
                                    <th scope="col">부가세</th>
                                    <th scope="col">입금액</th>
                                    <th scope="col">잔액</th>
                                    <th scope="col">계산서 여부</th>
                                </tr>
                            </thead>

                            <tbody data-row-list>

                            </tbody>

                            <tfoot>
                                <tr>
                                    <th colspan="2" scope="row">합계</th>
                                    <td colspan="2"></td>
                                    <td data-weight>0</td>
                                    <td></td>
                                    <td data-wgtsum>0</td>
                                    <!-- <td></td> -->
                                    <td data-price>0</td>
                                    <td data-tax>0</td>
                                    <td data-receive>0</td>
                                    <td data-remain></td>
                                    <td></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                    <template data-table-row>
                        <tr data-row-id>
                            <td data-no></td>
                            <td data-date></td>
                            <td data-carno></td>
                            <td data-grade></td>
                            <td data-weight></td>
                            <td data-single></td>
                            <td data-wgtsum></td>
                            <!--  <td data-logis></td>-->
                            <td data-price></td>
                            <td data-tax></td>
                            <td data-receive></td>
                            <td data-remain></td>
                            <td data-receipt></td>
                        </tr>
                    </template>
                </div> <!-- #contentView -->
            </main> <!-- #mainWrap -->

<%@include file="/WEB-INF/views/include/footer.jsp"%>            