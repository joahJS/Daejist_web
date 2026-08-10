<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>

<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="user-scalable=yes, width=device-width">
        <meta id="_csrf" name="_csrf" content="${_csrf.token}">
        <meta id="_csrf_name" name="_csrf_name" content="${_csrf.headerName}">

        <title>대지에스텍</title>

        <link rel="icon" href="/daejiM/resources/common/img/logo.ico">
        <link href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css" rel="stylesheet">
        <link rel="stylesheet" href="/daejiM/resources/common/css/reset.css">
        <link rel="stylesheet" href="/daejiM/resources/common/css/header.css">
        <link rel="stylesheet" href="/daejiM/resources/common/css/layout.css">

        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
        <script src="/daejiM/resources/common/js/jquery-3.6.0.min.js"></script>

        <!-- 페이징 -->
        <link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css">
        <script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>

        <link rel="stylesheet" href="/daejiM/resources/common/css/common.css">
        <script src="/daejiM/resources/common/js/commom.js?v=2"></script>
    </head>

    <body>
        <div id="lodingView">
            <div class="loading-container">
                <div class="loading"></div>
                <div id="loading-text">loading</div>
            </div>
        </div>

        <!-- End of header -->