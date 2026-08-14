/**
 * 프로젝트 : 대지에스텍 모바일
 * 페이지명 : 로그인
 *
 * 작성자 : 김창완
 * 최초 작성일 : 2023. 08. 04 (금)
 *
 * 수정자 : 김창완
 * 최종 수정일 : 2023. 08. 04 (금)
 */

const frmLogin = document.getElementById('frmLogin') // 로그인 폼
const inputID = document.getElementById('usrid'); // 아이디 입력창
const inputPW = document.getElementById('usrpw'); // 비밀번호 입력창
const chkSaveID = document.getElementById('saveID'); // 계정 정보 저장 체크박스
const btnLogin = document.getElementById('btnLogin'); // 로그인 버튼

inputID.addEventListener('keydown', function(event) { // 입력창 포커스 이동
    if (event.key === 'Enter' && event.target.value !== '') {
        event.preventDefault();
        inputPW.focus();
    }
});

inputPW.addEventListener('keydown', function(event) {
    if (event.key === 'Enter' && event.target.value !== '') {
        event.preventDefault();
        login();
    }
});

btnLogin.addEventListener('click', () => login());

function login() {
    const userID = inputID.value;
    const userPW = inputPW.value;

    if (userID === '') {
        toastAlert('warning', '아이디를 입력해주세요.');
        inputID.focus();

        return;
    }

    if (userPW === '') {
        toastAlert('warning', '패스워드를 입력해주세요.');
        inputPW.focus();

        return;
    }

    if (chkSaveID.checked === true) {
        setCookie('userInputId', inputID.value, 700);
        setCookie('userInputPw', inputPW.value, 700);
    }

		
    frmLogin.submit(); 

	/*$.ajax({
		url:'login.do',
		type:'post',
		data:{
			USRID: inputID.value,
			PASSWD: inputPW.value
		},
		success:function(res) {
			console.log(res)
			if(res == 'Y') {
				location.href = 'main';
			} else {
				
			}
		},
		error:function() {
			
		}
	})*/
}

document.addEventListener('DOMContentLoaded', () => { // 쿠키가 존재하면 계정 정보 불러오기
    const cookieUserID = getCookie('userInputId');
    const cookieUserPW = getCookie('userInputPw');

    if (cookieUserID === null || cookieUserID === '') {
        inputID.focus();
    } else {
        inputID.value = cookieUserID;
        inputPW.value = cookieUserPW;
        chkSaveID.checked = true;
    }
});

chkSaveID.addEventListener('change', function(event) { // 계정 정보 저장
    if (event.target.checked === true) {
        setCookie('userInputId', inputID.value, 700);
        setCookie('userInputPw', inputPW.value, 700);
    } else {
        deleteCookie('userInputId');
        deleteCookie('userInputPw');
    }
});

function getCookie(cookieName) {
    cookieName = cookieName + '=';

    let cookieData = document.cookie;
    let start = cookieData.indexOf(cookieName);
    let cookieValue = '';

    if (start != -1) {
        start += cookieName.length;

        let end = cookieData.indexOf(';', start);

        if (end == -1) end = cookieData.length;

        cookieValue = cookieData.substring(start, end);
    }

    return unescape(cookieValue);
}

function setCookie(cookieName, value, exdays) {
    let exdate = new Date();

    exdate.setDate(exdate.getDate() + exdays);

    let cookieValue = escape(value) + ((exdays == null) ? '' : '; expires=' + exdate.toGMTString());

    document.cookie = cookieName + '=' + cookieValue;
}

function deleteCookie(cookieName){
    let expireDate = new Date();

    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + '= ' + '; expires=' + expireDate.toGMTString();
}