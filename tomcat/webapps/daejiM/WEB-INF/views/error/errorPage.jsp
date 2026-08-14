<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta id="_csrf" name="_csrf" content="${_csrf.token}">
        <meta id="_csrf_name" name="_csrf_name" content="${_csrf.headerName}">

        <title>대지에스텍</title>

        <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
        <link rel="stylesheet" href="/daejiM/resources/common/css/reset.css" />
        <link rel="stylesheet" href="/daejiM/resources/common/css/header.css" />
        <link rel="stylesheet" href="/daejiM/resources/common/css/common.css" />
        <link rel="stylesheet" href="/daejiM/resources/common/css/layout.css" />
        <link rel="stylesheet" href="/daejiM/resources/view/css/errorPage.css" />

        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
        <script src="/daejiM/resources/common/js/jquery-3.6.0.min.js"></script>

        <script src="/daejiM/resources/common/js/commom.js"></script>
    </head>

    <body>
        <div id="wrap">
            <main id="mainWrap">
                <svg id="logoBackground" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 110.11 75.65">
                    <defs>
                        <style>
                            .cls-1 { fill: #fff; }
                            .cls-2 { fill: #07549b; }
                            .cls-3 { fill: url(#logoGradient); }
                            .cls-4 { fill: none; }
                            .cls-5 { fill: #00605d; }
                        </style>

                        <linearGradient id="logoGradient" x1="0" y1="42.34" x2="110.11" y2="42.34" gradientUnits="userSpaceOnUse">
                            <stop offset="0" stop-color="#b0d6e1" />
                            <stop offset=".22" stop-color="#689bbb" />
                            <stop offset=".46" stop-color="#4279a8" />
                            <stop offset="1" stop-color="#0b4488" />
                        </linearGradient>
                    </defs>

                    <g>
                        <path class="cls-3" d="M28.62,9.79c9.4-1.37,20.67-.73,28.84,.71-8.15-1.21-18.9-2.24-29.32,.21-5.46,1.24-13.05,3.76-17.88,10.59-3.15,4.18-2.7,10.32-1.39,14.08,1.43,4.08,3.05,6.5,6.29,10,4.1,4.27,9.02,7.64,10.73,8.68,4,2.56,9.82,5.23,14.61,6.78,5.02,1.83,10.95,3.44,15.76,3.85,2.8,.29,10.66,1.17,17.3,.74,5.29-.39,11.78-1.76,16.56-3.66,8.46-3.35,14.35-10.53,12.78-19.33-1.12-6.24-4.59-10.08-7.65-13.48-2.26-2.28-5.36-4.81-8.12-6.73-5.38-3.74-13.96-7.13-18.58-9.09,8.95,3.15,17.68,7.22,24.91,12.47,2.72,1.92,10.28,8.72,12.12,11.82s3.87,6.43,4.34,10.44c.57,4.91-.33,8.45-1.46,10.76-1.64,3.33-3.79,5.4-6.44,7.61-2.64,2.25-5.76,3.79-9.07,5.27-6.69,2.81-14.13,3.76-18.92,4.05-6.37,.28-14.34-.39-18.45-.93-5.82-.68-12.9-2.49-18.59-4.69-5.89-2.38-11.62-5.2-16.26-8.14-2.29-1.65-9.47-6.79-13.04-11.17-3.34-4.1-6.52-8.86-7.54-14.84-.43-4.47,.06-7.2,1.22-10.01,1.12-2.82,4.04-6.21,6.07-7.83,4.09-3.24,12.17-7.14,21.18-8.19Z" />
                        <path class="cls-4" d="M56,38.32c2.03-.95,1.32-1.28,2.45-2.5,2.82-3.05,3.76-7.35,3.81-10.93v-.02s0-.56,0-.56v-.23c-.05-3.78-.48-8.07-3.29-11.12-2.01-2.18-5.97-4.79-10.95-4.79h-12.42V40.81h10.53c-.1-.61-.09-3.85-.09-4.56v-11.62h8.72" />
                        <path class="cls-5" d="M46.12,40.81h-9.73V7.98h11.62c5.75,0,9.01,2.72,11.02,4.9,2.82,3.05,3.17,7.43,3.22,11.21v.23s0,.56,0,.56v.02c0,3.98-1,7.48-2.66,9.72-.71,.88-1.93,2.76-3.6,3.71,.64,1.7,2.4,3.34,8.84,3.57,.11-.11,.23-.23,.34-.34,4.41-4.78,5.88-11.22,5.84-17,.12-5.87-1.57-13.11-5.98-17.89-3.11-3.37-9.18-6.66-17.02-6.66H20.16V7.98h7.44V40.81h-7.24v8.18h27.65c2.33,0,5.93-1.09,7.82-1.68-4.15-1.14-9.07-2.39-9.71-6.5Z" />
                        <path class="cls-2" d="M54.76,24.63h-8.72v11.62c0,.7-.01,3.94-.01,4.56h1.99c2.07,.55,6.4-.13,7.98-2.49-.12-.16-.92-.98-1.12-2.92-.2-1.94-.12-10.77-.12-10.77Z" />
                        <path class="cls-2" d="M70.31,.18V7.82h10.5v25.47c0,3.27-.58,8.94-8.49,8.94-4.36,0-6.19-.24-7.49-.34-2.18,2.28-4.72,4.09-9,5.42,4.62,1.27,9.42,2.18,16.49,2.18,13.84,0,16.83-7.94,16.83-16.2V7.82h11.54V.18h-30.39Z" />
                        <path class="cls-1" d="M56,38.32c-2.74,2.12-5.79,2.49-7.98,2.49h-1.99c.05,.94-.01,2.87,.25,3.31,2.17,1.23,6.85,2.45,9.56,3.19,4.28-1.32,6.82-3.13,9-5.42-6.07-.46-7.88-2.17-8.84-3.57Z" />
                    </g>
                </svg>

                <div id="contentView">
                    <div class="DJ_title">
                        <h5>
                            <i class="ri-error-warning-line"></i> Error
                        </h5>

                        <h2 data-error-code>{ ${requestScope['javax.servlet.error.status_code']} }</h2>

                        <h3 data-error-desc>
                            <c:if test="${requestScope['javax.servlet.error.status_code'] == 400}">
                            잘못된 요청입니다.
                            </c:if>

                            <c:if test="${requestScope['javax.servlet.error.status_code'] == 404}">
                            요청하신 페이지를 찾을 수 없습니다.
                            </c:if>

                            <c:if test="${requestScope['javax.servlet.error.status_code'] == 405}">
                            요청된 메소드가 허용되지 않습니다.
                            </c:if>

                            <c:if test="${requestScope['javax.servlet.error.status_code'] == 500}">
                            서버에 오류가 발생하여 요청을 수행할 수 없습니다.
                            </c:if>

                            <c:if test="${requestScope['javax.servlet.error.status_code'] == 503}">
                            서비스를 사용할 수 없습니다.
                            </c:if>
                        </h3>

                        <div data-error-msg></div>

                        <button type="submit" onclick="history.back()">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
                                <path fill="none" d="M0 0H24V24H0z" />
                                <path d="M14 4.5V9c5.523 0 10 4.477 10 10 0 .273-.01.543-.032.81-1.463-2.774-4.33-4.691-7.655-4.805L16 15h-2v4.5L6 12l8-7.5zm-6 0v2.737L2.92 12l5.079 4.761L8 19.5 0 12l8-7.5z" fill="rgba(255,255,255,1)" />
                            </svg>

                            뒤로가기
                        </button>
                    </div>
                </div> <!-- #contentView -->
            </main>
        </div>
    </body>
</html>