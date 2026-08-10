<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>    

<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0">

        <meta property="og:type" content="website">
        <meta property="og:url" content="https://example.co.kr">
        <meta property="og:title" content="Website Title">
        <meta property="og:image" content="https://meta-image.url">
        <meta property="og:description" content="Website Description">
        <meta property="og:site_name" content="Website Name">
        <meta property="og:locale" content="ko_KR">
        
        <meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
        <meta id="_csrf_name" name="_csrf_name" content="${_csrf.headerName}"/>
        <!-- OpenGraph Meta Tag -->

        <title>(주) 대지에스텍</title>
        <link rel="shortcut icon" type="image/x-icon" href="/scm/resources/images/icons/favicon.ico">

        <link rel="stylesheet" type="text/css" href="/scm/resources/css/common/default.css">
        <link rel="stylesheet" type="text/css" href="/scm/resources/css/common/common.css">
        <link rel="stylesheet" type="text/css" href="/scm/resources/css/common/wanderface.css">
        <!-- Global CSS -->

        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script> <!-- jQuery CDN -->
        <script type="text/javascript" src="/scm/resources/js/common/default.js" async></script>
        <!-- Global JavaScript / jQuery -->

        <!--[if lt IE 9]>
            <script src="./resources/js/common/html5shiv.min.js"></script>
        <![endif]-->
    </head>