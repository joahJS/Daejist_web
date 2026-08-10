/**
 * 
 */
$(document).ready(function () {
	getList();
}); //ready  end

//조회
$(document).on("click", "#BtnRetr", function(){
	getList();
})

function getList(){
	$.ajax({
		url:contextUrl+"/main/getPriceList",
		type:"post",
		success: function(res){
			$("#scrapBody").text();
			$("#surederBody").text();
			
			if(res != null && res != ""){
				strHtmlRk(res);
				$("#scrapBody")[0].innerHTML = strHtmlScrapBody(res);
				$("#surederBody")[0].innerHTML = strHtmlSureder(res);
			}
		}
	})
}

function strHtmlRk(res){
	var row = res["rkMap"];
	if(row != null){
		$("#scrap").val(row.SCRDT);
		$("#sureder").val(row.PAPDT);
		
		//업체별 일자
		$("#dt1")[0].innerHTML = row.HDDT.replace(/\r\n/ig,'<br>');;//현대
		$("#dt2")[0].innerHTML = row.DGDT.replace(/\r\n/ig,'<br>');;//동국
		$("#dt3")[0].innerHTML = row.DHDT.replace(/\r\n/ig,'<br>');;//대한
		$("#dt4")[0].innerHTML = row.HCDT.replace(/\r\n/ig,'<br>');;//한국철강
		$("#dt5")[0].innerHTML = row.HTDT.replace(/\r\n/ig,'<br>');;//한국특강
		$("#dt6")[0].innerHTML = row.PGDT.replace(/\r\n/ig,'<br>');;//포스코 광양
		$("#dt7")[0].innerHTML = row.PPDT.replace(/\r\n/ig,'<br>');;//포스코 포항
		$("#dt8")[0].innerHTML = row.SADT.replace(/\r\n/ig,'<br>');;//세아창원
		$("#dt9")[0].innerHTML = row.INDT.replace(/\r\n/ig,'<br>');;//인근기준

		//업체별 비고
		
		$("#RK1")[0].innerHTML = row.RK1.replace(/\r\n/ig,'<br>');//현대
		$("#RK2")[0].innerHTML = row.RK2.replace(/\r\n/ig,'<br>');;//동국
		$("#RK3")[0].innerHTML = row.RK3.replace(/\r\n/ig,'<br>');;//대한
		$("#RK4")[0].innerHTML = row.RK4.replace(/\r\n/ig,'<br>');;//한국철강
		$("#RK5")[0].innerHTML = row.RK5.replace(/\r\n/ig,'<br>');;//한국특강
		$("#RK6")[0].innerHTML = row.RK6.replace(/\r\n/ig,'<br>');;//포스코 광양
		$("#RK7")[0].innerHTML = row.RK7.replace(/\r\n/ig,'<br>');;//포스코 포항
		$("#RK8")[0].innerHTML = row.RK8.replace(/\r\n/ig,'<br>');;//세아창원
		$("#RK9")[0].innerHTML = row.RK9.replace(/\r\n/ig,'<br>');;//인근기준
		
		//야드 일자
		$("#BfSuDt").text(row.YADT1);
		$("#AfSuDt").text(row.YADT2);
	}
}

function strHtmlScrapBody(res){
	var list = res["scrap"];
	var str = "";
	
	if(list != null && list.length > 0){
		for(var i=0;i<list.length;i++){
			var row = list[i];
			
			str += '<tr>                                                                            ';
			str += '<input type="hidden" data-chgyn="N" class="j_serial" value="'+row.J_SERIAL+'">';
	        str += '    <td class="firstableSticky">                                                                        ';
	        str += '        <p class="rowColumn">'+row.GUBUN1+'</p>  ';
	        str += '    </td>                                                                       ';
	        str += '    <td>                                                                        ';
	        str += '        <p class="rowColumn" data-default="">'+row.SELLPRC2+'</p>     ';//현대제철
	        str += '    </td>                                                                       ';
	        str += '    <td>                                                                        ';
	        str += '        <p class="rowColumn" data-default="">'+row.SELLPRC3+'</p>     ';//동국(포항)
	        str += '    </td>                                                                       ';
	        str += '    <td>                                                                        ';
	        str += '        <p class="rowColumn" data-default="">'+row.SELLPRC1+'</p>     ';//대한
	        str += '    </td>                                                                       ';
	        str += '    <td>                                                                        ';
	        str += '        <p class="rowColumn" data-default="">'+row.SELLPRC6+'</p>     ';//한국철강
	        str += '    </td>                                                                       ';
	        str += '    <td>                                                                        ';
	        str += '        <p class="rowColumn" data-default="">'+row.SELLPRC7+'</p>     ';//한국특강
	        str += '    </td>                                                                       ';
	        str += '    <td>                                                                        ';
	        str += '        <p class="rowColumn" data-default="">'+row.SELLPRC4+'</p>     ';//포스코(광양)
	        str += '    </td>                                                                       ';
	        str += '    <td>                                                                        ';
	        str += '        <p class="rowColumn" data-default="">'+row.SELLPRC5+'</p>     ';//포스코(포항)
	        str += '    </td>                                                                       ';
	        str += '    <td>                                                                        ';
	        str += '        <p class="rowColumn" data-default="">'+row.SELLPRC8+'</p>     ';//세아창원
	        str += '    </td>                                                                       ';
	        str += '    <td>                                                                        ';
	        str += '        <p class="rowColumn" data-default="">'+row.SELLPRC9+'</p>     ';//인근기준
	        str += '    </td>                                                                       ';
	        str += '</tr>                                                                           ';
			
		}
	}else{
		str = "<tr><td colspan='10'>조회결과가 없습니다.</td></tr>";
	}
	
	return str;
}

function strHtmlSureder(res){
	var str = "";
	var list = res.sureder;
	
	if(list != null && list.length > 0){
		for(var i=0;i<list.length;i++){
			var row = list[i];
			
			str += '<tr>                                                                        ';
			str += '    <input type="hidden" data-chgyn="N" class="j_serial" value="'+row.J_SERIAL+'">';
			str += '    <td class="firstableSticky">'+row.GUBUN1+'</td>                                                            ';
			str += '    <td colspan="2">                                                        ';
			str += '        <p class="rowColumn">'+row.BFDAN+'</p>  ';
			str += '    </td>                                                                   ';
			str += '    <td colspan="5">                                                        ';
			str += '        <p></p>                                                             ';
			str += '    </td>                                                                   ';
			str += '    <td colspan="2">                                                        ';
			str += '        <p class="rowColumn" data-default="">'+row.ATDAN+'</p> ';
			str += '    </td>                                                                   ';
			str += '</tr>';
		}
	}else{
		str = "<tr><td colspan='10'>조회결과가 없습니다.</td></tr>";
	}
	
	return str;
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


//저장
/*$(document).on("click", "#save", function(){
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
        	saveJajae();
        }
    })
})

function saveJajae(){
	var data = {};
	//전체 스크랩,폐압 일자
	data["SCRDT"] = $("#scrap").val();
	data["PAPDT"] = $("#sureder").val();
	
	//업체별 일자
	data["HDDT"] = $("#dt1")[0].innerHTML; //현대제철
	data["DGDT"] = $("#dt2")[0].innerHTML; //동국 포항
	data["DHDT"] = $("#dt3")[0].innerHTML; //대한
	data["HCDT"] = $("#dt4")[0].innerHTML; //한국철강
	data["HTDT"] = $("#dt5")[0].innerHTML; //한국특강
	data["PGDT"] = $("#dt6")[0].innerHTML; //포스코 광양
	data["PPDT"] = $("#dt7")[0].innerHTML; //포스코 포항
	data["SADT"] = $("#dt8")[0].innerHTML; //세아 창원
	data["INDT"] = $("#dt9")[0].innerHTML; //인근

	//업체별 비고
	data["RK1"] = $("#RK1")[0].innerHTML;
	data["RK2"] = $("#RK2")[0].innerHTML;
	data["RK3"] = $("#RK3")[0].innerHTML;
	data["RK4"] = $("#RK4")[0].innerHTML;
	data["RK5"] = $("#RK5")[0].innerHTML;
	data["RK6"] = $("#RK6")[0].innerHTML;
	data["RK7"] = $("#RK7")[0].innerHTML;
	data["RK8"] = $("#RK8")[0].innerHTML;
	data["RK9"] = $("#RK9")[0].innerHTML;
	
	//야드 일자
	data["YADT1"] = $("#BfSuDt").text();
	data["YADT2"] = $("#AfSuDt").text();

	$.ajax({
		url:contextUrl+"/main/savePriceList",
		type:"post",
		data:{"data":JSON.stringify(data)},
		success: function(res){
			if(res != null && res.RESULT != null){
				if(res.RESULT == "1"){
					toastAlert('success', res.MSG);
					getList();
				}else{
					toastAlert('warning', res.MSG);
				}
			}else{
				toastAlert('warning', "저장 오류입니다. \r\n관리자에게 문의하세요.");
			}
		} 
	})
}*/
