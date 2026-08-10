/**
 * 
 */

var totalItems = 500; //총 데이터수
var itemsPerPage = 50; //표시 데이터수
var visiblePages = 4; //보이는페이지수

var pagination;

$(document).ready(function () {
	//오늘일자 세팅
	var today = new Date();
	var fdate = setDateFomat(today);
	
	$("#fDate").val(fdate);
	
	getList(1);
})

//조회
$(document).on("click", "#BtnRetr", function () {
	pagination = null;
	getList(1);
})
//라디오버튼 클릭시 조회
$(document).on("change", "input[name='Weight']", function(){
	pagination = null;
	getList(1);
})
$(document).on("change", "input[name='outCome']", function(){
	pagination = null;
	getList(1);
})

//이전날짜, 다음날짜
$(document).on("click", "#prvDateBtn , #nextDateBtn", function (){
	var id = $(this).attr("id");
	var date = $("#fDate").val();
	var date2 = "";
	
	if(id == "prvDateBtn"){
		//이전날
		var prvDate = new Date(date);
		prvDate.setDate(prvDate.getDate() - 1);
		
		date2 = setDateFomat(prvDate);
	}
	else if(id == "nextDateBtn"){
		//다음날
		var prvDate = new Date(date);
		prvDate.setDate(prvDate.getDate() + 1);
		
		date2 = setDateFomat(prvDate);
	}
	
	$("#fDate").val(date2);
	
	pagination = null;
	getList(1);
})

function getList(page) {
	var FDATE = $("#fDate").val();
	var rdiChk = $("input[name='Weight']:checked").val();
	var rdiInOut = $("input[name='outCome']:checked").val();
	var findObj = $("#findObj").val();
	var findWord = $("#findWord").val();

	var data = {};
	
	data["FDATE"] = FDATE;
	data["CHKYN"] = rdiChk;
	data["INOUT"] = rdiInOut;
	data["findObj"] = findObj;
	data["findWord"] = findWord;
	data["pageNum"] = page;
	data["pageLength"] = itemsPerPage;
	
	$.ajax({
		url:contextUrl + "/main/priceInputList",
		type:"post",
		data:{"data":JSON.stringify(data)},
		success: function (res) {
			$("#bTbody tr").remove();
			if (res != null && res != "") {

				var tbody = "";
				for (var i = 0; i < res.length; i++) {
					var row = res[i];
					
					tbody += '<tr data-junpyoid="'+row.JUNPYOID+'" data-gubun="'+row.KERATYPE+'">';
					tbody += '<td class="rowColumn" contenteditable="false" data-default="">'+row.SUN+'</td>';//순번
                    tbody += '<td class="rowColumn" contenteditable="false" data-default="">'+row.DEALER_NM+'</td>';//거래처명
                    tbody += '<td class="rowColumn" contenteditable="false" data-default="">'+row.J_BNUM+'</td>';//차량번호
                    tbody += '<td class="rowColumn" contenteditable="false" data-default="">'+row.GRADE_NM+'</td>';//등급
                    tbody += '<td class="rowColumn" contenteditable="false" data-default="">'+row.CHAGAM_WEIGHT+'</td>';//감량중량
                    tbody += '<td class="rowColumn" contenteditable="false" data-default="" data-acptWt>'+row.ACPT_WEIGHT+'</td>';//인수량
                    tbody += '<td class="rowColumn" contenteditable="false" data-default="">'+row.COMP_WEIGHT+'</td>';//업체중량
                    tbody += '<td class="rowColumn" contenteditable="false" data-default="">'+row.LOSS_WEIGHT+'</td>';//Loss중량
                    tbody += '<td class="rowColumn" contenteditable="false" data-default="">'+row.STD_UNIT_PRC+'</td>';//기준단가
                    if(row.APPLY_UNIT_PRC == "0"){
                    	tbody += '<td class="yellow rowColumn" contenteditable="false" data-default="" data-apply-unit><input class="aDanInpt" value="'+row.APPLY_UNIT_PRC+'"></td>';//적용단가
                    }else{
                    	tbody += '<td class="green rowColumn" contenteditable="false" data-default="" data-apply-unit><input class="aDanInpt" value="'+row.APPLY_UNIT_PRC+'"></td>';//적용단가
                    }
                    tbody += '<td class="rowColumn" contenteditable="false" data-default="">'+row.DIFF_UNIT_PRC+'</td>';//차액
                    if(row.TRANSPORTKUMAK == "0"){
                    	tbody += '<td class="yellow rowColumn" contenteditable="false" data-default="" data-trans><input class="tAmtInpt" value="'+row.TRANSPORTKUMAK+'"></td>';//운반비
                    }
                    else{
                    	tbody += '<td class="green rowColumn" contenteditable="false" data-default="" data-trans><input class="tAmtInpt" value="'+row.TRANSPORTKUMAK+'"></td>';//운반비
                    }
                    tbody += '<td class="rowColumn" contenteditable="false" data-default="" data-car-unit>'+row.CRY_UNIT_PRC+'</td>';//운반비단가
                    tbody += '</tr>';
                    
					if (i == 0) {
						totalItems = row.CNT;
					}
				}

				$("#bTbody")[0].innerHTML = tbody;

				if (pagination == null) {
					pageing();
				}
				
				//
				$(".aDanInpt, .tAmtInpt").comma();
			}
			else {
				tbody = "<tr><td colspan='13'>조회결과가 없습니다.</td></tr>"
				$("#bTbody")[0].innerHTML = tbody;
				totalItems = 0;
				pageing();
			}
		}
	})
}

function pageing() {
	//페이징
	pagination = new tui.Pagination('pagination', {
		totalItems: totalItems,
		itemsPerPage: itemsPerPage,
		visiblePages: visiblePages
	});

	pagination.on('beforeMove', function (eventData) {
		getList(eventData.page);
	});

	pagination.on('afterMove', function (eventData) {
		getList(eventData.page);
	});
}

/*테이블 tr 클릭*/
$(document).on("click","#jb-table tbody tr", function(){
	if(!$(this).hasClass("tr_select")){
		$(this).addClass("tr_select");
		$(this).find("td:eq(0)").addClass("tr_select");
	}
	
	$(this).siblings("tr").removeClass("tr_select");
	$(this).siblings("tr").find("td:eq(0)").removeClass("tr_select");
});

//td입력
$(document).on("focus", "#bTbody .aDanInpt, #bTbody .tAmtInpt", function(){
	this.select();
})

//운반비 입력시 자동 계산
$(document).on("input", "#bTbody .aDanInpt, #bTbody .tAmtInpt", function(){
	var td = $(this).closest("td");
	
	if(!$(td).hasClass("green")){
		$(td).addClass("green");
	}
	
	if(!$(td).hasClass("editTd")){
		$(td).addClass("editTd");
	}
	
	if($(this).hasClass("tAmtInpt")){
		var tAmt = $(this).val().replace(/,/g,'')*1;
		var tr = $(this).closest("tr");
		var acpWt = tr.find("[data-acptWt]")[0].textContent.replace(/,/g,'')*1;

		var unbanDanga = Math.round(acpWt/tAmt*10)/10+"";
		
		if(unbanDanga == "Infinity"){
			tr.find("[data-car-unit]")[0].textContent = 0;
		}else{
			tr.find("[data-car-unit]")[0].textContent = $.round_comma(unbanDanga, 1, false, true);
		}
	}
})

//저장
$(document).on("click", "#BtnSave", function(){
	var edit = $("#bTbody .editTd");
	
	if(edit.length == 0){
		toastAlert('warning', "변경 내역이 없습니다.");
		return;
	}
	
	Swal.fire({
        title: "변경된 내용을\r\n저장하시겠습니까?",
        text: "다시 되돌릴 수 없습니다.",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#42562f',
        cancelButtonColor: 'coral',
        confirmButtonText: '확인',
        cancelButtonText: '취소'
    }).then((result) => {
        if (result.isConfirmed) {
        	saveDanga();
        }
    })
})

function saveDanga(){
	var edit = $("#bTbody .editTd");
	
	var list = [];
	for(var i=0;i<edit.length;i++){
		var tr = $(edit[i]).closest("tr")[0];
		var sJUNPYOID       = $(tr).attr("data-junpyoid");
		var sKERATYPE       = $(tr).attr("data-gubun");
		var sDANGA          = $(tr).find("[data-apply-unit] input")[0].value;
		var sTRANSPORTKUMAK = $(tr).find("[data-trans] input")[0].value;
		var acpWt = $(tr).find("[data-acptWt]")[0].textContent.replace(/,/g,'')*1;
		
		var data = {};
		
		data["JUNPYOID"] = sJUNPYOID*1;
		data["KERATYPE"] = sKERATYPE;
		data["DANGA"] = sDANGA.replace(/,/g,'')*1;
		data["WEIGHT"] = acpWt;
		data["TRANSPORTKUMAK"] = sTRANSPORTKUMAK.replace(/,/g,'')*1;
		
		list.push(data);
	}
	
	//중복제거
	var saveList = list.filter(function(item1, idx){
		//filter() 메서드는 콜백함수에서 정의한 조건이 true인 항목만 리턴한다.(필터링)
	    return list.findIndex(function(item2, idx){
	    	//findIndex() 메서드는 콜백함수에 정의한 조건이 true인 항목의 index를 리턴한다.
	        return item1.JUNPYOID == item2.JUNPYOID
	    }) == idx;
	});
	
	$.ajax({
		url:contextUrl + "/main/saveDanga",
		type:"post",
		data:{"data":JSON.stringify(saveList)},
		success: function(res){
			if(res != null && res.RESULT != null){
				var result = res.RESULT *1;
				
				if(result > 0){
					toastAlert('success', res.MSG);
					getList(1);
				}else{
					toastAlert('warning', res.MSG);
				}
			}else{
				toastAlert('warning', "저장 오류입니다. \r\n관리자에게 문의하세요.");
			}
		}
	})
}

