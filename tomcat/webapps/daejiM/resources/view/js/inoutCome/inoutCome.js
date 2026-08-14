var totalItems = 0; //총 데이터수
var itemsPerPage = 30; //표시 데이터수
var visiblePages = 4; //보이는페이지수

var pagination;

/*페이징*/
function pageing(){
	//페이징
	pagination = new tui.Pagination('pagination', {
	    totalItems: totalItems,
	    itemsPerPage: itemsPerPage,
	    visiblePages: visiblePages
	});

	pagination.on('beforeMove', function(eventData) {
		getList(eventData.page);
	});

	pagination.on('afterMove', function(eventData) {
		getList(eventData.page);
	});
}

/**거래구분 별 div hide/show */

function setDisplay(tab) {

	var divName = "";
	
    if ($('input:radio[id=inCome]').is(':checked')) {
        $('.outCome').hide();
        $('.direct').hide();
        $('.inCome').show();
        
        divName = ".inCome";
    }
    else if ($('input:radio[id=outCome]').is(':checked')) {
        $('.inCome').hide();
        $('.direct').hide();
        $('.outCome').show();
        
        divName = ".outCome";

    } else {
        $('.inCome').hide();
        $('.outCome').hide();
        $('.direct').show();
        
        divName = ".direct";
    }
    
    var listTable = $(".list_table");
	
	if(tab == "거래처별"){
		$(divName).find('.client').show();
		$(divName).find('.level').hide();
		$(divName).find('.company').hide();
	}
	else if(tab == "등급별"){
		$(divName).find('.client').hide();
		$(divName).find('.level').show();
		$(divName).find('.company').hide();
	}
	else if(tab == "업체별 현황"){
		$(divName).find('.client').hide();
		$(divName).find('.level').hide();
		$(divName).find('.company').show();
	}
	
	$(".jb-table tbody tr").removeClass("tr_select");
}

$(document).ready(function () {
	var today = new Date();
	
	var year = today.getFullYear(); // 년도
	var month = today.getMonth() + 1+"";  // 월
	var date = today.getDate()+"";  // 날짜
	
	if(month.length < 2){
		month = "0"+month;
	}
	
	if(date.length < 2){
		date = "0"+date;
	}
	
	var fdate = year+"-"+month+"-"+date;
	
	$("#fdate, #tdate").val(fdate);
	
	setDisplay("거래처별");
    getList(1);
}); //ready  end

//계근사진조회
$(document).on("dblclick", ".img_click", function(){
	var JUNPYOID = $(this).text().trim();
	var J_DATE = $(this).closest('tr').find('[data-jdate]').text().trim();
	
	var data = {};
	
	data["JUNPYOID"] = JUNPYOID;
	data["J_DATE"] = J_DATE;
	
	$.ajax({
		url:contextUrl+"/main/getInoutImg",
		type:"post",
		data:{"data":JSON.stringify(data)},
		success: function(res){
			if(res.RESULT != null && res.RESULT == "1"){				
				$('#pop_add').css('display', 'block');
				
				var list = ["1_1","1_2","1_3"
					       ,"2_1","2_2","2_3"];
				
				var yy = J_DATE.split("-")[0];
				var mm = J_DATE.split("-")[1];
				
				for(var i=0;i<list.length;i++){
					var url = "/daejiM/resources/temp/"+yy+"/"+mm+"/"+J_DATE+"/"+JUNPYOID+"_"+list[i]+".jpg";
					isImage(url,$("#img"+list[i]));
				}
			}else if(res.RESULT != null && res.RESULT == "0"){
				toastAlert('warning', res.MSG);
			}
		}
	})
})
//계근사진 닫기
$(document).on("click", "#imgClose", function(){
	$('#pop_add').css('display', 'none');
	$(".img_box").find("img").attr("src","/daejiM/resources/common/img/no_image.jpg");
})

//탭 선택
$(document).on("click", ".tab_menu .tab_wrap li", function(){
	var KERATYPE = $("input[name='closure']:checked").val();
	var tab = $(this).text();
	
	setDisplay(tab);
	
	$(this).siblings('li').removeClass('on');
    $(this).addClass('on');
    
    if(KERATYPE == "직송" && tab == "업체별 현황"){
		$('#pop_choice').css('display', 'block')
	}else{
		pagination = null;
		getList(1);
	}
})

/*테이블 tr 클릭*/
$(document).on("click",".jb-table tbody tr", function(){
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


//직송 매입 매출 선택 버튼
$(document).on("click", "#pop_choice_btn_box button", function(){
	$("#jkgub").val($(this).text());
	$('#pop_choice').css('display', 'none');
	getList(1);
});

//직송 매입출 닫기
$(document).on("click","#choiceClose", function(){
	$('#pop_choice').css('display', 'none');
    $("#jkgub").val("");
});

//조회버튼
$(document).on("click", "#BtnRetr", function(){
	var KERATYPE = $("input[name='closure']:checked").val();
	var TabList = $(".list_table");
	var TABGB = $(".tab_wrap li.on").text();
	
	if(KERATYPE == "직송" && TABGB == "업체별 현황"){
		$('#pop_choice').css('display', 'block')
	}else{
		pagination = null;
		getList(1);
	}
})

//거래구분 선택
$(document).on("change","input[name='closure']", function(){
	var TABGB = $(".tab_wrap li.on").text();
	setDisplay(TABGB);
	
	if($(this).val() == "직송" && TABGB == "업체별 현황"){
		$('#pop_choice').css('display', 'block');
	}else{
		pagination = null;
		getList(1);
	}
})

//조회
function getList(page){
	var FDATE = $("#fdate").val();
	var TDATE = $("#tdate").val();
	var KERATYPE = $("input[name='closure']:checked").val();
	var chkDaeGb = $("input[name='chkDaegb']:checked");
	var DAEGUBUN = [];
	
	for(var i=0;i<chkDaeGb.length;i++){
		var daegb = $(chkDaeGb[i]).val();
		DAEGUBUN.push(daegb);
	}
	
	var JKGUB = "";
	
	var TabList = $(".list_table");
	var TABGB = $(".tab_wrap li.on").text();
	
	var table;
	var tbody;
	var tfoot;
	for(var i=0;i<TabList.length;i++){
		if($(TabList[i]).css("display") != "none"){
			var target = $(TabList[i]);
			var tableList = target.find(".list_table_in");
			
			
			for(var j=0;j<tableList.length;j++){
				if($(tableList[j]).css("display") != "none"){
					table = $(tableList[j]);
					tbody = $(table).find("tbody")[0];
					tfoot = $(table).find("tfoot")[0];
				}
			}
		}
	}
	
	if(KERATYPE == "직송" && TABGB == "업체별 현황"){
		JKGUB = $("#jkgub").val();
	}
	
	var data = {};
	data["FDATE"] = FDATE;
	data["TDATE"] = TDATE;
	data["KERATYPE"] = KERATYPE;
	data["DAEGUBUN"] = DAEGUBUN;
	data["JKGUB"] = JKGUB;
	
	data["TABGB"] = TABGB;
	data["pageNum"] = page;
	data["pageLength"] = itemsPerPage;
	
	$.ajax({
		url:contextUrl+"/main/inoutComeList",
		type:"post",
		data:data,
		success: function(res){
			var str = "";
			var tfootData;
			if(res != null && res.length > 0){
				for(var i=0;i<res.length;i++){
					var row = res[i];
					var type = row["TYPE"];
					
					if(i==0){
				    	totalItems = row.CNT;
				    }
					
					if(type == "TOT"){
						tfootData = row;						
						continue;
					}
					
					if(KERATYPE == "매입"){
						str+= strTbody_inCome(row,TABGB);
					}
					else if(KERATYPE == "매출"){
						str+= strTbody_outCome(row,TABGB);
					}
					else if(KERATYPE == "직송"){
						str+= strTbody_direct(row,TABGB);
					}
				}
				
			}else{
				var colCnt = $(table).find(".tableCol th").length;
				
				str+="<tr><td class='text_left' colspan='"+colCnt+"'>조회결과가 없습니다.</td></tr>";
			}
			
			tbody.innerHTML = str;
			
			var tfootTd = "";
			if(tfootData != null && tfootData != ""){
				console.log(tfootData);
				if(KERATYPE == "매입"){
					tfootTd+= strTfoot_inCome(tfootData,TABGB);
				}
				else if(KERATYPE == "매출"){
					tfootTd+= strTfoot_outCome(tfootData,TABGB);
				}
				else if(KERATYPE == "직송"){
					tfootTd+= strTfoot_direct(tfootData,TABGB);
				}
			}
			
			tfoot.innerHTML = tfootTd;
			
			if(pagination == null){
				pageing();
			}
		}
	})
}

/** 매입 **/
function strTbody_inCome(row, gb){
	var str = "";
	
	if(gb == "거래처별"){
		str += '<tr>';
	    /*str += '    <td>';
	    str += '        <p>1</p>';
	    str += '    </td>';*/

		str += '    <td>';
	    str += '        <p>'+row.DEALER_NM+'</p>'; //상호
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p data-jdate>'+row.J_DATE+'</p>'; //마감일자
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.MESURE_DT+'</p>'; //계근일자
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.INSPECTOR+'</p>';//담당자
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.J_BNUM+'</p>'; //차량
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.LANDEDWEIGHT+'</p>';// 대지중량
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.LOSS+'</p>';//감량
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.ACCEPTWEIGHT+'</p>';//인수량
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.DIFFWEIGHT+'</p>';//중량차이
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.GUBUN1+'</p>';//등급
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.STDDUNITPRICE+'</p>';//기준단가
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.PAYEDUNITPRICE+'</p>'; //지급단가
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.DIFFUNITPRICE+'</p>';//차액
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.ARRVUNITPRICE+'</p>';//도착도단가
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.CARRYCOST+'</p>';//운반비
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.CARRY_UNIT_PRICE+'</p>';//운반비단가
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.TOTALPRICE+'</p>';//금액
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.ARRVTOTALPRICE+'</p>';//도착도금액
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.LOSSCAUSE+'</p>';//감량사유
	    str += '    </td>';
	    str += '    <td class="img_click">';
	    str += '        <p>'+row.IMAGE+'</p>'; //사진
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.INSPECTNOTE+'</p>'; //비고
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.ETC_COST+'</p>'; //부대비용
	    str += '    </td>';
	    str += '</tr>';
	}
	else if(gb == "등급별"){
		str += '<tr>';
	    str += '    <td>';
	    str += '        <p>'+row.GUBUN1+'</p>'; //등급
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.ACCEPTWEIGHT+'</p>'; //인수량
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.LANDEDWEIGHT+'</p>';// 대지중량
	    str += '    </td>';
	    if(row.DIFFWEIGHT.replace(/,/gi,"")*1 < 0){
	    	str += '    <td class="num_minus">'; //차이중량
	    }else{
	    	str += '    <td>';
	    }
	    str += '        <p>'+row.DIFFWEIGHT+'</p>';
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.STDDUNITPRICE+'</p>';//기준단가
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.PAYEDUNITPRICE+'</p>';//지급단가
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.TOTALPRICE+'</p>';//금액
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.HALIN+'</p>';//감량
	    str += '    </td>';
	    str += '</tr>';
	}
	else if(gb == "업체별 현황"){
		str += '<tr>';
	    str += '    <td>';
	    str += '        <p>'+row.DEALER_NM+'</p>';//거래처
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.CHRG_NM+'</p>';//담당자
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.ACCEPT_WEIGHT+'</p>';//인수량
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.PRICE+'</p>';//금액
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.AVG_UNIT_PRICE+'</p>';//평균단가
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.J_REGION+'</p>';//지역
	    str += '    </td>';
	    str += '</tr>';
	}
	
	return str;
}

function strTfoot_inCome(row, gb){
	var str = "";
	
	if(gb == "거래처별"){
		str += '<td>합계</td>';//마감일자
        str += '<td></td>  '; //계근일자
        str += '<td></td>  '; //상호        
        str += '<td></td>  '; //담당자       
        str += '<td></td>  '; //차량        
        str += '<td>'+row.LANDEDWEIGHT+'</td>  '; //대지중량      
        str += '<td>'+row.LOSS+'</td>  '; //감량        
        str += '<td>'+row.ACCEPTWEIGHT+'</td>  '; //인수량       
        str += '<td>'+row.DIFFWEIGHT+'</td>  '; //중량차이      
        str += '<td></td>  '; //등급        
        str += '<td></td>  '; //기준단가      
        str += '<td>'+row.PAYEDUNITPRICE+'</td>  '; //지급단가      
        str += '<td></td>  '; //차액        
        str += '<td></td>  '; //도착도단가     
        str += '<td>'+row.CARRYCOST+'</td>  '; //운반비       
        str += '<td></td>  '; //운반비단가     
        str += '<td>'+row.TOTALPRICE+'</td>  '; //금액        
        str += '<td>'+row.ARRVTOTALPRICE+'</td>  '; //도착도금액     
        str += '<td></td>  '; //감량사유      
        str += '<td></td>  '; //사진        
        str += '<td></td>  '; //비고        
        str += '<td></td>  '; //부대비용      
	}
	else if(gb == "등급별"){
		str += '<td>합계</td>'; //등급
        str += '<td>'+row.ACCEPTWEIGHT+'</td>  '; //인수량
        str += '<td>'+row.LANDEDWEIGHT+'</td>  '; //대지중량
        str += '<td>'+row.DIFFWEIGHT+'</td>  '; //차이중량
        str += '<td></td>  '; //기준단가
        str += '<td>'+row.PAYEDUNITPRICE+'</td>  '; //지급단가
        str += '<td>'+row.TOTALPRICE+'</td>  '; //금액
        str += '<td>'+row.HALIN+'</td>  '; //감량
	}
	else if(gb == "업체별 현황"){
		str += '<td>합계</td>' //거래처
        str += '<td></td>  ' //담당자
        str += '<td>'+row.ACCEPT_WEIGHT+'</td>  ' //인수량
        str += '<td>'+row.PRICE+'</td>  ' //금액
        str += '<td>'+row.AVG_UNIT_PRICE+'</td>  ' //평균단가
        str += '<td></td>  ' //지역
	}
	
	return str;
}

/** **/

/** 매출 **/
function strTbody_outCome(row, gb){
	var str = "";
	
	if(gb == "거래처별"){
		str += '<tr>';
	    /*str += '    <td>';
	    str += '        <p>'+row.+'</p>';
	    str += '    </td>';*/

		str += '    <td>';
	    str += '        <p>'+row.DEALER_NM+'</p>';//상호
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p data-jdate>'+row.J_DATE+'</p>';//마감일자
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.MESURE_DT+'</p>';//계근일자
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.INSPECTOR+'</p>';//담당자
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.J_BNUM+'</p>';//차량
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.LANDEDWEIGHT+'</p>';//대지중량
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.LOSS+'</p>';//감량
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.ACCEPTWEIGHT+'</p>';//인수량
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.DIFFWEIGHT+'</p>';//중량차이
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.GUBUN1+'</p>';//등급
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.STDDUNITPRICE+'</p>';//기준단가
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.SALEUNITPRICE+'</p>';//지급단가
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.DIFFUNITPRICE+'</p>';//차액
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.ARRVUNITPRICE+'</p>';//도착도단가
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.CARRYCOST+'</p>';//운반비
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.CARRY_UNIT_PRICE+'</p>';//운반비단가
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.TOTALPRICE+'</p>';//금액
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.ARRVTOTALPRICE+'</p>';//도착도금액
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.LOSSCAUSE+'</p>';//감량사유
	    str += '    </td>';
	    str += '    <td class="img_click">';
	    str += '        <p>'+row.IMAGE+'</p>';//사진
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.INSPECTNOTE+'</p>';//비고
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.ETC_DEALER_NM1+'</p>';//업체명
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.ETC_REMARK1+'</p>';//내용
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.ETC_COST1+'</p>';//금액
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.ETC_DEALER_NM1+'</p>';//업체명
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.ETC_REMARK2+'</p>';//내용
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.ETC_COST2+'</p>';//금액
	    str += '    </td>';
	    str += '</tr>';
	}
	else if(gb == "등급별"){
		str += '<tr>';
	    str += '    <td>';
	    str += '        <p>'+row.GUBUN1+'</p>';//등급
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.ACCEPTWEIGHT+'</p>';//인수량
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.LANDEDWEIGHT+'</p>';//대지중량
	    str += '    </td>';
	    if(row.DIFFWEIGHT.replace(/,/gi,"")*1 < 0){
	    	str += '    <td class="num_minus">';//차이중량
	    }else{
	    	str += '    <td>';
	    }
	    str += '        <p>'+row.DIFFWEIGHT+'</p>';
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.STTDUNITPRICE+'</p>';//기준단가
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.SALEUNITPRICE+'</p>';//매출단가
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.TOTALPRICE+'</p>';//금액
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.HALIN+'</p>';//감량
	    str += '    </td>';
	    str += '</tr>';
	}
	else if(gb == "업체별 현황"){
		str += '<tr>';
	    str += '    <td>';
	    str += '        <p>'+row.DEALER_NM+'</p>';//거래처
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.CHRG_NM+'</p>';//담당자
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.ACCEPT_WEIGHT+'</p>';//인수량
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.PRICE+'</p>';//금액
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.AVG_UNIT_PRICE+'</p>';//평균단가
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.J_REGION+'</p>';//지역
	    str += '    </td>';
	    str += '</tr>';
	}
	return str;
}

function strTfoot_outCome(row, gb){
	var str = "";
	
	if(gb == "거래처별"){
		str += '<td>합계</td>'//마감일자
        str += '<td></td>  ' //계근일자
        str += '<td></td>  ' //상호
        str += '<td></td>  ' //담당자
        str += '<td></td>  ' //차량
        str += '<td>'+row.LANDEDWEIGHT+'</td>  ' //대지중량
        str += '<td>'+row.LOSS+'</td>  ' //감량
        str += '<td>'+row.ACCEPTWEIGHT+'</td>  ' //인수량
        str += '<td>'+row.DIFFWEIGHT+'</td>  ' //중량차이
        str += '<td></td>  ' //등급
        str += '<td></td>  ' //기준단가
        str += '<td>'+row.SALEUNITPRICE+'</td>  ' //지급단가
        str += '<td></td>  ' //차액
        str += '<td></td>  ' //도착도단가
        str += '<td>'+row.CARRYCOST+'</td>  ' //운반비
        str += '<td></td>  ' //운반비단가
        str += '<td>'+row.TOTALPRICE+'</td>  ' //금액
        str += '<td>'+row.ARRVTOTALPRICE+'</td>  ' //도착도금액
        str += '<td></td>  ' //감량사유
        str += '<td></td>  ' //사진
        str += '<td></td>  ' //비고
        str += '<td></td>  ' //업체명
        str += '<td></td>  ' //내용
        str += '<td></td>  ' //금액
        str += '<td></td>  ' //업체명
        str += '<td></td>  ' //내용
    	str += '<td></td>  ' //금액	
	}   
	else if(gb == "등급별"){
		str += '<td>합계</td>'//등급
        str += '<td>'+row.ACCEPTWEIGHT+'</td>  '//인수량
        str += '<td>'+row.LANDEDWEIGHT+'</td>  '//대지중량
        str += '<td>'+row.DIFFWEIGHT+'</td>  '//차이중량
        str += '<td></td>  '//기준단가
        str += '<td>'+row.SALEUNITPRICE+'</td>  '//매출단가
        str += '<td>'+row.TOTALPRICE+'</td>  '//금액
        str += '<td>'+row.HALIN+'</td>  '//감량
	}
	else if(gb == "업체별 현황"){
		str += '<td>합계</td>'//거래처
        str += '<td></td>  '//담당자
        str += '<td>'+row.ACCEPT_WEIGHT+'</td>  '//인수량
        str += '<td>'+row.PRICE+'</td>  '//금액
        str += '<td>'+row.AVG_UNIT_PRICE+'</td>  '//평균단가
        str += '<td></td>  '//지역
	}
	
	return str;
}
/** **/

/** 직송 **/
function strTbody_direct(row, gb){
	var str = "";
	
	if(gb == "거래처별"){
		str += '<tr>';
	    /*str += '    <td>';
	    str += '        <p>1</p>';
	    str += '    </td>';*/
		str += '    <td>';
	    str += '        <p>'+row.SALE_DEALER_NM+'</p>';//매출처
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.J_DATE+'</p>';//마감일자
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.NAME+'</p>';//담당자
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.GUBUN1+'</p>';//등급
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.J_BNUM+'</p>';//차량
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.OWEIGHT+'</p>';//매출중량
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.SALEUNITPRICE+'</p>   ';//매출단가
	    str += '    </td>               ';
	    str += '    <td>                ';
	    str += '        <p>'+row.SALEPRICE+'</p>     ';//매출액
	    str += '    </td>               ';
	    str += '    <td>                ';
	    str += '        <p>'+row.DEALER_NM+'</p>      ';//매입처
	    str += '    </td>               ';
	    str += '    <td>                ';
	    str += '        <p>'+row.PURCHUNITPRICE+'</p>      ';//매입단가
	    str += '    </td>               ';
	    str += '    <td>                ';
	    str += '        <p>'+row.ARRIVEUNITPRICE+'</p>      ';//도착도단가
	    str += '    </td>               ';
	    str += '    <td>                ';
	    str += '        <p>'+row.PURC_AMT+'</p>       ';//매입금액
	    str += '    </td>               ';
	    str += '    <td>                ';
	    str += '        <p>'+row.DIFFUNITPRICE+'</p>      ';//차액
	    str += '    </td>               ';
	    str += '    <td>                ';
	    str += '        <p>'+row.CARRYCOST+'</p>        ';//운반비
	    str += '    </td>               ';
	    str += '    <td>                ';
	    str += '        <p>'+row.CARRY_UNIT_PRICE+'</p>        ';//운반비단가
	    str += '    </td>               ';
	    str += '    <td>                ';
	    str += '        <p>'+row.ARRVTOTALPRICE+'</p>';//도착도금액
	    str += '    </td>               ';
	    str += '    <td>                ';
	    str += '        <p>'+row.HALIN+'</p>';//감량
	    str += '    </td>               ';
	    str += '    <td>                ';
	    str += '        <p>'+row.ETC_DEALER_NM1+'</p>   ';//업체명
	    str += '    </td>               ';
	    str += '    <td>                ';
	    str += '        <p>'+row.ETC_REMARK1+'</p>    ';//내용
	    str += '    </td>               ';
	    str += '    <td>                ';
	    str += '        <p>'+row.ETC_COST1+'</p>     ';//금액
	    str += '    </td>               ';
	    str += '    <td>                ';
	    str += '        <p>'+row.ETC_DEALER_NM2+'</p>         ';//업체명
	    str += '    </td>               ';
	    str += '    <td>                ';
	    str += '        <p>'+row.ETC_REMARK2+'</p>         ';//내용
	    str += '    </td>               ';
	    str += '    <td>                ';
	    str += '        <p>'+row.ETC_COST2+'</p>         ';//금액
	    str += '    </td>               ';
	    str += '</tr>                   ';
	}
	else if(gb == "등급별"){
		str += '<tr>';
	    str += '    <td>';
	    str += '        <p>'+row.GUBUN1+'</p>';//등급
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.ACCEPTWEIGHT+'</p>';//인수량
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.LANDEDWEIGHT+'</p>';//대지중량
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.DIFFWEIGHT+'</p>';//차이중량
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.STTDUNITPRICE+'</p>';//기준단가
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.SALEUNITPRICE+'</p>';//지급단가
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.TOTALPRICE+'</p>';//금액
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.HALIN+'</p>';//감량
	    str += '    </td>';
	    str += '</tr>';
	}
	else if(gb == "업체별 현황"){
		str += '<tr>';
	    str += '    <td>';
	    str += '        <p>'+row.DEALER_NM+'</p>';//거래처
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.CHRG_NM+'</p>';//담당자
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.ACCEPT_WEIGHT+'</p>';//인수량
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.PRICE+'</p>';//금액
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.AVG_UNIT_PRICE+'</p>';//평균단가
	    str += '    </td>';
	    str += '    <td>';
	    str += '        <p>'+row.J_REGION+'</p>';//지역
	    str += '    </td>';
	    str += '</tr>';
	}
	
	return str;
}

function strTfoot_direct(row, gb){
	var str = "";
	
	if(gb == "거래처별"){
		str += '<td>합계</td>' //마감일자
        str += '<td></td>  ' //담당자
        str += '<td></td>  ' //등급
        str += '<td></td>  ' //차량
        str += '<td></td>  ' //매출처
        str += '<td>'+row.OWEIGHT+'</td>  ' //매출중량
        str += '<td>'+row.SALEUNITPRICE+'</td>  ' //매출단가
        str += '<td>'+row.SALEPRICE+'</td>  ' //매출액
        str += '<td></td>  ' //매입처
        str += '<td>'+row.PURCHUNITPRICE+'</td>  ' //매입단가
        str += '<td></td>  ' //도착도단가
        str += '<td>'+row.PURC_AMT+'</td>  ' //매입금액
        str += '<td>'+row.ARRIVEUNITPRICE+'</td>  ' //차액
        str += '<td>'+row.CARRYCOST+'</td>  ' //운반비
        str += '<td></td>  ' //운반비단가
        str += '<td>'+row.ARRVTOTALPRICE+'</td>  ' //도착도금액
        str += '<td>'+row.HALIN+'</td>  ' //감량
        str += '<td></td>  ' //업체명
        str += '<td></td>  ' //내용
        str += '<td></td>  ' //금액
        str += '<td></td>  ' //업체명
        str += '<td></td>  ' //내용
        str += '<td></td>  ' //금액
	}
	else if(gb == "등급별"){
		str += '<td>합계</td>'; //등급
        str += '<td>'+row.ACCEPTWEIGHT+'</td>  '; //인수량
        str += '<td>'+row.LANDEDWEIGHT+'</td>  '; //대지중량
        str += '<td>'+row.DIFFWEIGHT+'</td>  '; //차이중량
        str += '<td></td>  '; //기준단가
        str += '<td>'+row.SALEUNITPRICE+'</td>  '; //지급단가
        str += '<td>'+row.TOTALPRICE+'</td>  '; //금액
        str += '<td>'+row.HALIN+'</td>  '; //감량
	}
	else if(gb == "업체별 현황"){
		str += '<td>합계</td>';//거래처
        str += '<td></td>  ';//담당자
        str += '<td>'+row.ACCEPT_WEIGHT+'</td>  ';//인수량
        str += '<td>'+row.PRICE+'</td>  ';//금액
        str += '<td>'+row.AVG_UNIT_PRICE+'</td>  ';//평균단가
        str += '<td></td>  ';//지역
	}
	
	return str;
}
/** **/
