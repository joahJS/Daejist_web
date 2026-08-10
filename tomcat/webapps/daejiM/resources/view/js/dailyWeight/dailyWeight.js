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
	var rdiInOut = $("input[name='Weight']:checked").val();
	var chkDaeGb = $("input[name='chkDaegb']:checked");
	var DAEGUBUN = [];
	
	for(var i=0;i<chkDaeGb.length;i++){
		var daegb = $(chkDaeGb[i]).val();
		DAEGUBUN.push(daegb);
	}

	var data = {};
	
	data["FDATE"] = FDATE;
	data["INOUT"] = rdiInOut;
	data["DAEGUBUN"] = DAEGUBUN;
	data["pageNum"] = page;
	data["pageLength"] = itemsPerPage;
	
	$.ajax({
		url:contextUrl + "/main/dailyWeightList",
		type:"post",
		data:{"data":JSON.stringify(data)},
		success: function (res) {
			$("#bTbody tr").remove();
			if (res != null && res != "") {

				var tbody = "";
				for (var i = 0; i < res.length; i++) {
					var row = res[i];
					
					tbody += '<tr>';
	                tbody += '    <td>';
	                tbody += '        <p class="rowColumn" contenteditable="false" data-default="">'+row.SUN+'</p>';//순번
	                tbody += '    </td>';
	                tbody += '    <td>';
	                tbody += '        <p class="rowColumn" contenteditable="false" data-default="">'+row.KERATYPE+'</p>';//구분
	                tbody += '    </td>';
	                tbody += '    <td>';
	                tbody += '        <p class="rowColumn" contenteditable="false" data-default="">'+row.J_BNUM+'</p>';//차량번호
	                tbody += '    </td>';
	                tbody += '    <td>';
	                tbody += '        <p class="rowColumn" contenteditable="false" data-default="">'+row.J_COMPANY+'</p>';//거래처
	                tbody += '    </td>';
	                tbody += '    <td>';
	                tbody += '        <p class="rowColumn" contenteditable="false" data-default="">'+row.GUBUN1+'</p>';//등급
	                tbody += '    </td>';
	                tbody += '    <td data-sum-dajiw>';
	                tbody += '        <p class="rowColumn" contenteditable="false" data-default="">'+row.WEIGHT+'</p>';//대지중량
	                tbody += '    </td>';
	                tbody += '    <td data-sum-insu>';
	                tbody += '        <p class="rowColumn" contenteditable="false" data-default="">'+row.OWEIGHT+'</p>';//인수량
	                tbody += '    </td>';
	                tbody += '    <td data-sum-gam>';
	                tbody += '        <p class="rowColumn" contenteditable="false" data-default="">'+row.OCHAGAM+'</p>';//감량
	                tbody += '    </td>';
	                tbody += '    <td>';
	                tbody += '        <p class="rowColumn" contenteditable="false" data-default="">'+row.J_STATE+'</p>';//감량 감가사유
	                tbody += '    </td >';
	                tbody += '    <td>';
	                tbody += '        <p class="rowColumn" contenteditable="false" data-default="">'+row.GUMSUBIGO+'</p>';//검수판전(품목)
	                tbody += '    </td >';
	                tbody += '    <td>';
	                tbody += '        <p class="rowColumn" contenteditable="false" data-default="">'+row.EMP_NM+'</p>';//검수자
	                tbody += '    </td >';
	                tbody += '</tr>';
                
					if (i == 0) {
						totalItems = row.CNT;
					}
				}

				$("#bTbody")[0].innerHTML = tbody;

				if (pagination == null) {
					pageing();
				}
				
				//전체합계
				setFooterSumData("[data-sum-dajiw]", res[0].TOTWEIGHT);
				setFooterSumData("[data-sum-insu]", res[0].TOTOWEIGHT);
				setFooterSumData("[data-sum-gam]", res[0].TOTOCHAGAM);
				
				/* 페이지에 표시된 데이터만 SUM해서 FOOTER 세팅
				setFooterSumData("[data-sum-dajiw]");
				setFooterSumData("[data-sum-insu]");
				setFooterSumData("[data-sum-gam]");
				*/
			}
			else {
				tbody = "<tr><td colspan='11'>조회결과가 없습니다.</td></tr>"
				$("#bTbody")[0].innerHTML = tbody;
				totalItems = 0;
				pageing();
			}
		}
	})
}

/* 페이지에 표시된 데이터만 SUM해서 FOOTER 세팅
function setFooterSumData(strDataSet){
	var target = $(strDataSet);
	var idx = $(target[0]).parent().children().index($(target[0]));
	
	var tot = 0;
	for(var i=0;i<target.length;i++){
		var text = $(target[i]).text();
		var num = text.replace(/,/g,"");
		
		tot += num*1;
	}
	
	tot = setComma(tot);
	
	$("tfoot tr:eq(0) td:eq("+idx+")").text(tot);
}
*/

function setFooterSumData(strDataSet, num){
	var target = $(strDataSet);
	var idx = $(target[0]).parent().children().index($(target[0]));
	
	$("tfoot tr:eq(0) td:eq("+idx+")").text(num);
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
	if($(this).hasClass("tr_select")){
		$(this).removeClass("tr_select");
		$(this).find("td:eq(0)").removeClass("tr_select");
	
	}else{
		$(this).addClass("tr_select");
		$(this).find("td:eq(0)").addClass("tr_select");
	}
	
	$(this).siblings("tr").removeClass("tr_select");
	$(this).siblings("tr").find("td:eq(0)").removeClass("tr_select");
});
