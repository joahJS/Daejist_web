<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" href="/daejiM/resources/view/css/inoutCome.css" />
<script src="/daejiM/resources/view/js/inoutCome/inoutCome.js?v=<%=System.currentTimeMillis()%>"></script>

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
                        <div class="closure m_closure">
                            <input type="date" id="fdate" min="0000-01-01" max="9999-12-31"><span class="hide">~</span><input type="date" id="tdate" min="0000-01-01" max="9999-12-31">
                        </div>
                        <div class="closure">
                            <label><input type="radio" id="inCome" name="closure" value="매입" checked> <span > 매입</span></label>
                            <label><input type="radio" id="outCome" name="closure" value="매출"> <span > 매출</span></label>
                            <label><input type="radio" id="direct" name="closure" value="직송"> <span > 직송</span></label>
                        </div>
                        <div class="closure">
                            <label><input type="checkbox" name="chkDaegb" value="고철A" checked="checked"> <span> 고철A</span></label>
                            <label><input type="checkbox" name="chkDaegb" value="고철B" checked="checked"> <span> 고철B</span></label>
                            <label><input type="checkbox" name="chkDaegb" value="슈레더" checked="checked"> <span> 슈레더</span></label>
                        </div>

                        <button type="button" id="BtnRetr">조회</button>
                    </form>
                </div>
				
				<div class="tab_menu">
                    <ul class="tab_wrap">
                        <li class="tab1 on">거래처별</li>
                        <li class="tab2">등급별</li>
                        <li class="tab3">업체별 현황</li>
                    </ul>
                </div>
				
                <!--매입-->
                <div class="list_table inCome">
                    <!--매입 / 거래처-->
                    <div class="list_table_in inCome_client client">
                        <table class="jb-table">
                            <thead>
                                <tr>
                                    <!-- <th style="max-width:50px; min-width:50px;">-</th> -->
                                    <th colspan="21">마감정보</th>
                                    <th>부대비용</th>
                                </tr>
                                <tr class="tableCol">
                                    <!-- <th style="max-width:50px; min-width:50px;"></th> -->
                                    <th class="shop_name">상호</th>
                                    <th>마감일자</th>
                                    <th>계근일자</th>
                                    <th>담당자</th>
                                    <th>차량</th>
                                    <th>대지중량</th>
                                    <th>감량</th>
                                    <th>인수량</th>
                                    <th>중량차이</th>
                                    <th>등급</th>
                                    <th>기준단가</th>
                                    <th>지급단가</th>
                                    <th>차액</th>
                                    <th>도착도단가</th>
                                    <th>운반비</th>
                                    <th>운반비단가</th>
                                    <th>금액</th>
                                    <th>도착도금액</th>
                                    <th>감량사유</th>
                                    <th>사진</th>
                                    <th>비고</th>
                                    <th>부대비용</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                            <tfoot>
                            </tfoot>
                        </table>
                    </div>
                    <!--매입 / 등급별-->
                    <div class="list_table_in inCome_level level">
                        <table class="jb-table">
                            <thead>
                                <tr class="tableCol">
                                    <th class="shop_name">등급</th>
                                    <th>인수량</th>
                                    <th>대지중량</th>
                                    <th>차이중량(KG)</th>
                                    <th>기준단가</th>
                                    <th>지급단가</th>
                                    <th>금액</th>
                                    <th>감량</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                            <tfoot>
                            </tfoot>
                        </table>
                    </div>
                    <!--매입 / 업체별-->
                    <div class="list_table_in inCome_company company">
                        <table class="jb-table">
                            <thead>
                                <tr class="tableCol">
                                    <th class="shop_name">거래처</th>
                                    <th>담당자</th>
                                    <th>인수량</th>
                                    <th>금액</th>
                                    <th>평균단가</th>
                                    <th>지역</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                            <tfoot>
                                
                            </tfoot>
                        </table>
                    </div>
                </div>

                <!--매출-->
                <div class="list_table outCome">
                    <!-- <div class="tab_menu">
                        <ul class="tab_wrap">
                            <li class="tab1 on">거래처별</li>
                            <li class="tab2">등급별</li>
                            <li class="tab3">업체별 현황</li>
                        </ul>
                    </div> -->
                    <!--매출 / 거래처-->
                    <div class="list_table_in outCome_client client">
                        <table class="jb-table">
                            <thead>
                                <tr>
                                    <!-- <th style="max-width:50px; min-width:50px;">-</th> -->
                                    <th colspan="21">마감정보</th>
                                    <th colspan="3">기타비용1</th>
                                    <th colspan="3">기타비용2</th>
                                </tr>
                                <tr class="tableCol">
                                    <!-- <th style="max-width:50px; min-width:50px;"></th> -->
                                    <th class="shop_name">상호</th>
                                    <th>마감일자</th>
                                    <th>계근일자</th>
                                    <th>담당자</th>
                                    <th>차량</th>
                                    <th>대지중량</th>
                                    <th>감량</th>
                                    <th>인수량</th>
                                    <th>중량차이</th>
                                    <th>등급</th>
                                    <th>기준단가</th>
                                    <th>지급단가</th>
                                    <th>차액</th>
                                    <th>도착도단가</th>
                                    <th>운반비</th>
                                    <th>운반비단가</th>
                                    <th>금액</th>
                                    <th>도착도금액</th>
                                    <th>감량사유</th>
                                    <th>사진</th>
                                    <th>비고</th>
                                    <th>업체명</th>
                                    <th>내용</th>
                                    <th>금액</th>
                                    <th>업체명</th>
                                    <th>내용</th>
                                    <th>금액</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                            <tfoot>
                                
                            </tfoot>
                        </table>
                    </div>
                    <!--매출 / 등급별-->
                    <div class="list_table_in outCome_level level">
                        <table class="jb-table">
                            <thead>
                                <tr class="tableCol">
                                    <th class="shop_name">등급</th>
                                    <th>인수량</th>
                                    <th>대지중량</th>
                                    <th>차이중량(KG)</th>
                                    <th>기준단가</th>
                                    <th>매출단가</th>
                                    <th>금액</th>
                                    <th>감량</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                            <tfoot>
                                
                            </tfoot>
                        </table>
                    </div>
                    <!--매출 / 업체별-->
                    <div class="list_table_in outCome_company company">
                        <table class="jb-table">
                            <thead>
                                <tr class="tableCol">
                                    <th class="shop_name">거래처</th>
                                    <th>담당자</th>
                                    <th>인수량</th>
                                    <th>금액</th>
                                    <th>평균단가</th>
                                    <th>지역</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                            <tfoot>
                                
                            </tfoot>
                        </table>
                    </div>
                </div>

                <!--직송-->
                <div class="list_table direct">
                    <!-- <div class="tab_menu">
                        <ul class="tab_wrap">
                            <li class="tab1 on">거래처별</li>
                            <li class="tab2">등급별</li>
                            <li class="tab3 choice_pop">업체별 현황</li>
                        </ul>
                    </div> -->
                    <!--직송 / 거래처-->
                    <div class="list_table_in direct_client client">
                        <table class="jb-table">
                            <thead>
                                <tr>
                                    <!-- <th style="max-width:50px; min-width:50px;">-</th> -->
                                    <th colspan="17">마감정보</th>
                                    <th colspan="3">기타비용1</th>
                                    <th colspan="3">기타비용2</th>
                                </tr>
                                <tr class="tableCol">
                                    <!-- <th style="max-width:50px; min-width:50px;">출</th> -->
                                    <th class="shop_name">매출처</th>
                                    <th>마감일자</th>
                                    <th>담당자</th>
                                    <th>등급</th>
                                    <th>차량</th>
                                    <th>매출중량</th>
                                    <th>매출단가</th>
                                    <th>매출액</th>
                                    <th>매입처</th>
                                    <th>매입단가</th>
                                    <th>도착도단가</th>
                                    <th>매입금액</th>
                                    <th>차액</th>
                                    <th>운반비</th>
                                    <th>운반비단가</th>
                                    <th>도착도금액</th>
                                    <th>감량</th>
                                    <th>업체명</th>
                                    <th>내용</th>
                                    <th>금액</th>
                                    <th>업체명</th>
                                    <th>내용</th>
                                    <th>금액</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                            <tfoot>
                                
                            </tfoot>
                        </table>
                    </div>
                    <!--직송 / 등급별-->
                    <div class="list_table_in direct_level level">
                        <table class="jb-table">
                            <thead>
                                <tr class="tableCol">
                                    <th class="shop_name">등급</th>
                                    <th>인수량</th>
                                    <th>대지중량</th>
                                    <th>차이중량(KG)</th>
                                    <th>기준단가</th>
                                    <th>지급단가</th>
                                    <th>금액</th>
                                    <th>감량</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <p>경량 AA</p>
                                    </td>
                                    <td>
                                        <p>20,220,301</p>
                                    </td>
                                    <td>
                                        <p>20,220,301</p>
                                    </td>
                                    <td>
                                        <p>-100</p>
                                    </td>
                                    <td>
                                        <p>640.0</p>
                                    </td>
                                    <td>
                                        <p>543.0</p>
                                    </td>
                                    <td>
                                        <p>234,513,700</p>
                                    </td>
                                    <td>
                                        <p>543.0</p>
                                    </td>
                                </tr>
                            </tbody>
                            <tfoot>
                                
                            </tfoot>
                        </table>
                    </div>
                    <!--직송 / 업체별-->
                    <div class="list_table_in direct_company company">
                        <table class="jb-table">
                            <thead>
                                <tr class="tableCol">
                                    <th class="shop_name">거래처</th>
                                    <th>담당자</th>
                                    <th>인수량</th>
                                    <th>금액</th>
                                    <th>평균단가</th>
                                    <th>지역</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        <p>25시자원 (홍길동)(김해)</p>
                                    </td>
                                    <td>
                                        <p>홍길동</p>
                                    </td>
                                    <td>
                                        <p>123,230</p>
                                    </td>
                                    <td>
                                        <p>123,123</p>
                                    </td>
                                    <td>
                                        <p>234.5</p>
                                    </td>
                                    <td>
                                        <p>김해</p>
                                    </td>

                                </tr>
                            </tbody>
                            <tfoot>
                                
                            </tfoot>
                        </table>
                    </div>
                </div>
				
				<div id="pagination" class="tui-pagination"></div>
				
                <div id="pop_add">
                    <div class="popText">
                        <h5>계근사진 조회</h5>
                        <div class="list_box">
                            <div class="list">
                                <p>1차 계근</p>
                                <div class="img_box">
                                    <p><img id="img1_1" src="/daejiM/resources/common/img/no_image.jpg"></p>
                                    <p><img id="img1_2" src="/daejiM/resources/common/img/no_image.jpg"></p>
                                    <p><img id="img1_3" src="/daejiM/resources/common/img/no_image.jpg"></p>
                                </div>
                            </div>
                            <div class="list">

                                <p>2차 계근</p>
                                <div class="img_box">
                                    <p><img id="img2_1" src="/daejiM/resources/common/img/no_image.jpg"></p>
                                    <p><img id="img2_2" src="/daejiM/resources/common/img/no_image.jpg"></p>
                                    <p><img id="img2_3" src="/daejiM/resources/common/img/no_image.jpg"></p>
                                </div>
                            </div>
                        </div>

                        <div class="pop_btn">
                            <button class="pop_close" id="imgClose">닫기</button>
                        </div>
                    </div>
                </div>

				<input type="hidden" id="jkgub">
                <div id="pop_choice">
                    <div class="popText">
                        <h6>매입출 선택</h6>
                        <div class="list_box">
                            <p>매입/매출 현황 중</p>
                            <p>하나를 선택하세요</p>
                        </div>
                        <div class="pop_btn" id="pop_choice_btn_box">
                            <button type="button">매입</button>
                            <button type="button">매출</button>
                            <button class="pop_close" id="choiceClose">닫기</button>
                        </div>
                    </div>
                </div>
            </div><!-- #contentView -->
        </main>
    </div>

</body>
</html>