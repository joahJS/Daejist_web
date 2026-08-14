<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>

<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="user-scalable=yes, width=device-width">
        <meta id="_csrf" name="_csrf" content="${_csrf.token}">
        <meta id="_csrf_name" name="_csrf_name" content="${_csrf.headerName}">

        <title>대지에스텍 (이미지 미리보기)</title>

        <link rel="icon" href="/daejiM/resources/common/img/logo.ico">
        <link rel="stylesheet" href="/daejiM/resources/common/css/reset.css">
        <link rel="stylesheet" href="/daejiM/resources/common/css/common.css">

        <style>
            body {
                background-color: #000;
                color: #fff;
            }

            #headSpacer {
                position: sticky;
                top: 0;
                padding-block: 30px;
                border-block-end: .5px solid #fff3;
                background-color: #0009;
                font-size: 16px;
                font-weight: 900;
                text-align: center;
                z-index: 50000;
            }

            #btnClose {
                position: absolute;
                inset: 0;
                margin-block: auto;
                margin-inline-start: auto;
                margin-inline-end: 15px;
                padding: .3rem 1.2rem;
                width: fit-content;
                height: fit-content;
                border: 2px solid #f31;
                border-radius: 500px;
                background-color: #f313;
                color: #f31;
                font-weight: 900;
                cursor: pointer;
            }

            #imageWrapper {
                padding: 15px;
            }

            #imageWrapper img {
                display: block;
                margin: auto;
                max-width: 100%;
            }
        </style>
    </head>

    <body>
        <div id="headSpacer">
            <span id="imgDesc"></span>

            <button id="btnClose">
                닫기
            </button>
        </div>

        <div id="imageWrapper">
            <img src="" id="imgSelf" alt="">
        </div>
    </body>

    <script>
        const imageDescription = document.getElementById('imgDesc')
        const imageSelf = document.getElementById('imgSelf');
        const storedText = sessionStorage.getItem('storedText');
        const storedImage = sessionStorage.getItem('storedImage');
        const btnClose = document.getElementById('btnClose');

        if (storedText !== null && storedText !== '') {
            imageDescription.textContent = storedText;
        } else {
            imageDescription.textContent = '이미지에 대한 설명 없음'
        }

        imageSelf.src = 'data:image/png;base64,' + storedImage;

        btnClose.addEventListener('click', () => window.close());
    </script>
</html>