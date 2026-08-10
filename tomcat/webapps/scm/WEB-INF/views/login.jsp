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
                <link rel="stylesheet" type="text/css" href="/scm/resources/css/main/login.css">
                <!-- Per-Page CSS -->

                <script type="text/javascript" src="/scm/resources/js/main/login.js" defer></script>
                <!-- Per-Page JavaScript -->

                <div id="contentView">
                    <div id="winLogin">
                        <h2>
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="1em" height="1em"><path fill="none" d="M0 0h24v24H0z"/><path d="M7 10h13a1 1 0 0 1 1 1v10a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V11a1 1 0 0 1 1-1h1V9a7 7 0 0 1 13.262-3.131l-1.789.894A5 5 0 0 0 7 9v1zm-2 2v8h14v-8H5zm5 3h4v2h-4v-2z"/></svg>
                            로그인
                        </h2>
                        <form id="frmLogin" class="clr_fix" method="post" action="/scm/login/loginChk.do">
                            <div class="input_container">
                                <div class="line_protector">
                                    <label for="txtID">아이디</label>
                                    <fieldset data-form-object="input-wrapper">
                                        <input type="text" name="username" id="txtID" placeholder="아이디">
                                        <legend>아이디</legend>
                                    </fieldset>
                                </div>

                                <div class="line_protector">
                                    <label for="txtPW">비밀번호</label>
                                    <fieldset data-form-object="input-wrapper">
                                        <input type="password" name="password" id="txtPW" placeholder="비밀번호">
                                        <legend>비밀번호</legend>
                                    </fieldset>
                                </div>
                            </div>
                            <button type="button" id="btnLogin">LOGIN</button>
                            <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}">
                        </form>
                        
						<!-- 로그인 실패문구 -->
	                    <c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
	                        <div style="color: red;">${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}</div>
	                        <c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session" />
	                    </c:if>
	                    <!-- 로그인 실패문구 -->
                    </div>
                </div> <!-- #contentView -->
            </main> <!-- #mainWrap -->
<%@include file="/WEB-INF/views/include/footer.jsp"%> 