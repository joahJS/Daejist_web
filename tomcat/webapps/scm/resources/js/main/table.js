
var dataYN = "N";
let corByDealer = {}; // 거래처(지점)별 누적잔액
let queryReqId = 0; // 조회 요청 번호(오래된 응답이 최신 화면을 덮어쓰는 것 방지)
let carryOverXhr = null;
let tableDataXhr = null;
/* javascript (table) */

/* ---------- jQuery basics ---------- */

$(window).on('load', function() {

}); // 페이지 로딩이 끝났을 때

$(document).ready(function() {
	dataYN = "N";
	sessionStorage.removeItem("sdate");
	sessionStorage.removeItem("edate");

}); // 페이지가 시작될 때

/* ---------- Plain Javascripts ---------- */

const carryOver = document.getElementById('txtCarryOver'); // 이월금액

carryOver.addEventListener('keypress', function() {
    createAlert('alert', '수정할 수 없습니다.');
});

const rowTemplate = document.querySelector('[data-table-row]');
const rowContainer = document.querySelector('[data-row-list]');

function listSum() {
    const totalLine = document.querySelector('tfoot');
    const totalWeight = totalLine.querySelector('[data-weight]');
    const totalWgtSum = totalLine.querySelector('[data-wgtsum]');
    const totalPrice = totalLine.querySelector('[data-price]');
    const totalTax = totalLine.querySelector('[data-tax]');
    const totalReceive = totalLine.querySelector('[data-receive]');
    //const totalRemain = totalLine.querySelector('[data-remain]');

    var arrWeight = rowContainer.querySelectorAll('[data-weight]');
    var arrWgtSum = rowContainer.querySelectorAll('[data-wgtsum]');
    var arrPrice = rowContainer.querySelectorAll('[data-price]');
    var arrTax = rowContainer.querySelectorAll('[data-tax]');
    var arrReceive = rowContainer.querySelectorAll('[data-receive]');
    var arrRemain = rowContainer.querySelectorAll('[data-remain]');

    totalWeight.textContent = sumOfAllFears(arrWeight);
    totalWgtSum.textContent = sumOfAllFears(arrWgtSum);
    totalPrice.textContent = sumOfAllFears(arrPrice);
    totalTax.textContent = sumOfAllFears(arrTax);
    totalReceive.textContent = sumOfAllFears(arrReceive);
    //totalRemain.textContent = sumOfAllFears(arrRemain);
}

/* ---------- Functions ---------- */

/* 배열의 숫자 총합 리턴 */
function sumOfAllFears(arrayName) {
    var arrayContent = [];

    arrayName.forEach(function(e) {
        const item = parseInt(e.textContent.replace(/,/gi, ''));

        arrayContent.push(item);
    });

    var sumResult = arrayContent.reduce(function(def, currentValue) {
        return def + currentValue;
    }, 0);

    return $.round_comma(sumResult+"", 0, false, true);
}
/* 배열의 숫자 총합 리턴 끝 */

$("#dateEnd").on("keyup", function(e){
	if(e.keyCode==13)
	{
		getTableData();
	}
})

$("#btnApply").on("click", function(){
	getTableData();
})

function getCarryOver(sdate, edate, reqId) {

	if(carryOverXhr){
		carryOverXhr.abort(); // 이전에 보낸(아직 안 끝난) 조회는 취소
	}

	carryOverXhr = $.ajax({
		url:contextUrl + "/member/getCarryOver.do",
		type:"post",
		data:{"sdate":sdate, "edate":edate},
		success: function(res){
			if(reqId !== queryReqId){
				return; // 그 사이 새로 조회가 시작됐으면 이 응답은 버림
			}
			if(res != ""){
				$("#txtCarryOver").val($.round_comma(res.CARRY_OVER_AMT+"", 0, false, true));

				corByDealer = {};
				if(res.byDealer){
					for(var dealerCd in res.byDealer){
						corByDealer[dealerCd] = parseFloat(res.byDealer[dealerCd]) || 0;
					}
				}
			}
		}
	})
}

function getTableData(){
	var sdate = $("#dateBegin").val();
	var edate = $("#dateEnd").val();

	if(sdate == null || sdate == ""){
		createAlert('alert', '시작일자를 입력해 주세요.');
		$("#dateBegin").focus();
		return;
	}

	if(edate == null || edate == ""){
		createAlert('alert', '종료일자를 입력해 주세요.');
		$("#dateEnd").focus();
		return;
	}

	queryReqId++;
	var thisReqId = queryReqId;

	if(tableDataXhr){
		tableDataXhr.abort(); // 이전에 보낸(아직 안 끝난) 조회는 취소
	}

	getCarryOver(sdate, edate, thisReqId);

	tableDataXhr = $.ajax({
		url:contextUrl + "/member/getTableData.do",
		type:"post",
		data:{"sdate":sdate, "edate":edate},
		success: function(res){
			if(thisReqId !== queryReqId){
				return; // 그 사이 새로 조회가 시작됐으면 이 응답은 버림
			}
			if(res != ""){
				var jan = 0;

				$(rowContainer).text("");

				for (i = 0; i < res.length; i ++) {
			        const tableRow = rowTemplate.content.cloneNode(true).children[0];

			        const rowNum = tableRow.querySelector('[data-no]'); // 현재는 행 갯수에 따라 자동으로 입력됨
			        const rowDate = tableRow.querySelector('[data-date]');
			        const rowCarNo = tableRow.querySelector('[data-carno]');
			        const rowGrade = tableRow.querySelector('[data-grade]');
			        const rowWeight = tableRow.querySelector('[data-weight]');
			        const rowSingle = tableRow.querySelector('[data-single]');
			        const rowWgtSum = tableRow.querySelector('[data-wgtsum]');
			        const rowLogis = tableRow.querySelector('[data-logis]');
			        const rowPrice = tableRow.querySelector('[data-price]');
			        const rowTax = tableRow.querySelector('[data-tax]');
			        const rowRecv = tableRow.querySelector('[data-receive]');
			        const rowRemain = tableRow.querySelector('[data-remain]');
			        const rowReceipt = tableRow.querySelector('[data-receipt]');
			        const rowCompany = tableRow.querySelector('[data-company]');

			        //tableRow.dataset.rowId = tableData[i]; // 행 고유 ID

			        var row = res[i];
			        var dealerCd = row["DEALER_CD"];

			        // 거래처(지점)마다 이월잔액을 따로 관리해서 누적잔액이 섞이지 않게 함
			        if(corByDealer[dealerCd] === undefined){
			        	corByDealer[dealerCd] = 0;
			        }
			        corByDealer[dealerCd] += row["K_DAE"]+row["J_BUGASE"]-row["K_CHA"];

			        rowDate.textContent = row["J_DATE"];
			        rowCarNo.textContent = row["J_BNUM"];
			        rowGrade.textContent = row["GUBUN1"];
			        rowWeight.textContent = $.round_comma(row["IWEIGHT"]+"", 0, false, true);
			        rowSingle.textContent = row["DANGA"];
			        rowWgtSum.textContent = row["HALIN"];
			        //rowLogis.textContent = $.round_comma(row["CKONGKEP"]+"", 0, false, true);
			        rowPrice.textContent = $.round_comma(row["K_DAE"]+"", 0, false, true);
			        rowTax.textContent = $.round_comma(row["J_BUGASE"]+"", 0, false, true);
			        rowRecv.textContent = $.round_comma(row["K_CHA"]+"", 0, false, true);
			        rowRemain.textContent = $.round_comma(corByDealer[dealerCd]+"", 0, false, true);
			        rowReceipt.textContent = "";
			        rowCompany.textContent = row["DEALER_NM"] || "";

			        rowContainer.appendChild(tableRow);
			    }
				
				listSum();
				
				dataYN = "Y";
				
				setItem("sdate",sdate);
				setItem("edate",edate);
			}
		}
	})
}

$("#chgPw").on("click", function(){
	var pw = $("#txtChangePW").val();
	
	if(pw == null || pw == ""){
		createAlert('alert', '변경할 비밀번호를 입력해주세요.');
		$("#txtChangePW").focus();
		return;
	}
	
	if(!confirm("로그인 비밀번호를 입력한 비밀번호로 변경하시겠습니까?")){
		return;
	}
	
	$.ajax({
		url:contextUrl + "/member/chgScmPw.do",
		type:"post",
		data:{"SCMPW":pw},
		success: function(res){
			if(res != ""){
				createAlert('alert', res.MSG);
				
				if(res.RESULT == "1"){
					$("#txtChangePW").val("");
				}
			}
		}
	})
})

$("#printOut").on("click", function(){
	var sdate = getItem("sdate");
	var edate = getItem("edate");
	
	if(dataYN == "N" || sdate == "" || edate == ""){
		createAlert('alert', '조회 후 거래명세서 버튼을 선택해주세요.');
		return;
	}
	
	location.href="/scm/member/print.do?sdate="+sdate+"&edate="+edate;
})

$("#logout").on("click", function(){
	delSetItem("sdate");
	delSetItem("edate");
	
	$.ajax({
		url:contextUrl+"/login/logout.do",
		type:"post",
		success: function(){
			location.href = "http://daejist.co.kr";
		}
	})
})

$(document).on("keyup","#dateBegin", function(e){
	if(e.keyCode == 13){
		dateEnd.focus();
	}
})