/* javascript (login) */

/* ---------- jQuery basics ---------- */

$(window).on('load', function() {

}); // 페이지 로딩이 끝났을 때

$(document).ready(function() {
	delSetItem("sdate");
	delSetItem("edate");
}); // 페이지가 시작될 때

/* ---------- Plain Javascripts ---------- */

const btnLogin = document.getElementById('btnLogin');
const txtID = document.getElementById('txtID');
const txtPW = document.getElementById('txtPW');

btnLogin.addEventListener('click', function(e) {
    login();
});

/* ---------- Functions ---------- */
//엔터시 포커스이동
$("#txtID").on("keyup", function(e){
	if(e.keyCode==13)
	{
		$("#txtPW").focus();
	}
})
$("#txtPW").on("keyup", function(e){
	if(e.keyCode==13)
	{
		login();
	}
})

/* ---------- Functions ---------- */
function login(){
	var usrid = $("#txtID").val();
	var usrpw = $("#txtPW").val();
	
	if(usrid == ""){
		createAlert('alert', '❗아이디는 필수 입력 사항입니다.');
		$("#txtID").focus();
		return;
	}
	
	if(usrpw == ""){
		createAlert('alert', '❗비밀번호를 입력하셔야 합니다.');
		$("#txtPW").focus();
		return;
	}
	
	document.getElementById("frmLogin").submit();
}