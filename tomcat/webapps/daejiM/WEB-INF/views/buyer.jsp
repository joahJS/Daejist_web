        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@include file="/WEB-INF/views/include/header.jsp" %>

        <link rel="stylesheet" href="/daejiM/resources/view/css/buyer.css" />
        <script src="/daejiM/resources/view/js/buyer/buyer.js?v=<%=System.currentTimeMillis()%>" defer></script>

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
                    <div class="list_title search">
                        <form>
                            <div class="closure">
                                <select id="findObj">
                                    <option value="0">거래처명</option>
                                    <option value="1">거래처코드</option>
                                    <option value="2">사업자번호</option>
                                    <option value="3">대표자명</option>
                                </select>

                                <input type="text" id="findWord">
                            </div>

                            <div class="closure">
                                <p class="hide">구분 </p>
                                <label><input type="radio" name="closure" value=""> 전체</label>
                                <label><input type="radio" name="closure" checked value="N"> 비폐업</label>
                                <label><input type="radio" name="closure" value="Y"> 폐업</label>
                            </div>

                            <button type="button" id="BtnRetr">조회</button>
                        </form>
                    </div>

                    <div class="list_table">
                        <div class="list_table_in">
                            <table id="jb-table">
                                <thead>
                                    <tr>
                                        <th style="max-width: 200px; min-width: 200px;">거래처명</th>
                                        <th>대표자명</th>
                                        <th>사업자번호</th>
                                        <th style="max-width: 500px; min-width: 500px;">도로명주소</th>
                                        <th>지역</th>
                                        <th style="max-width: 110px; min-width: 110px;">팩스번호</th>
                                        <th>웹팩스 구분</th>
                                        <th>SCM 패스워드</th>
                                        <th>담당자명</th>
                                        <th style="max-width: 110px; min-width: 110px;">담당자 전화번호</th>
                                        <th style="max-width: 110px; min-width: 110px;">담당자 휴대폰</th>
                                        <th style="max-width: 200px; min-width: 200px;">담당자 이메일</th>
                                        <th>폐업 구분</th>
                                    </tr>
                                </thead>

                                <tbody id="bTbody"></tbody>
                            </table>
                        </div>
                    </div>

                    <div id="pagination" class="tui-pagination"></div>
                </div> <!-- #contentView -->
            </main> <!-- #mainWrap -->
        </div> <!-- #wrap -->

        <dialog id="modalAccountDetails" class="modal-window">
            <div id="detailHistory" class="modal-insert-frame">
                <div class="modal-insert-title">
                    <h3>거래처 기록</h3>
                </div>

                <div class="modal-insert-content">
                    <div id="accountHistory">
                        <div class="history-table-row header">
                            <p class="history-table-row-note">특이사항</p>
                            <p class="history-table-row-date">등록일시</p>
                        </div>

                        <div class="history-table-container">
                            <div class="history-table-row">
                                <p class="history-table-row-note">특이사항</p>
                                <p class="history-table-row-date">등록일시</p>
                            </div>
                            <div class="history-table-row">
                                <p class="history-table-row-note">특이사항</p>
                                <p class="history-table-row-date">등록일시</p>
                            </div>
                            <div class="history-table-row">
                                <p class="history-table-row-note">특이사항</p>
                                <p class="history-table-row-date">등록일시</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div> <!-- #detailHistory -->

            <div id="detailImages" class="modal-insert-frame">
                <div class="modal-insert-title">
                    <h3>거래처 정보 이미지</h3>
                </div>

                <div class="modal-insert-content">
                    <div id="accountImages"></div> <!-- #accountImages -->
                </div>
            </div> <!-- #detailImages -->

            <div class="modal-control-compartment">
                <button type="button" id="btnModalClose">
                    닫기
                </button>
            </div>
        </dialog> <!-- #modalAccountDetails -->
    </body>
</html>