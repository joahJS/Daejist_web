
//기본url
//url : contextUrl+"/*.do",
const contextUrl = "/scm";

/* default javascript */

/* ---------- jQuery basics ---------- */

$(window).on('load', function() {

}); // 페이지 로딩이 끝났을 때

$(document).ready(function() {
    /* 툴팁 */
    const toolTipWindow = $('#toolTip');
    const toolTipText = $('[data-tooltip-text]');

    $(document).on('mousemove', function(e) {
        var pointX = e.pageX;
        var pointY = e.pageY + 35;

        toolTipWindow.css({
            'top': pointY,
            'left': pointX - (toolTipWindow.width() / 2)
        });
    })

    $(document).on('mouseover', '[data-tooltip]', function() {
        toolTipText.text($(this).data('tooltip'));
        toolTipWindow.fadeIn(150);
    });

    $(document).on('mouseout', '[data-tooltip]', function() {
        toolTipWindow.hide();
    });
    /* 툴팁 끝 */
}); // 페이지가 시작될 때

/* ---------- Plain Javascripts ---------- */

/* 커스텀 멀티 셀렉트 */
/* 멀티 셀렉트 사용시 아래의 구조 참조 */
/*

<div data-form-object="multiselect">
	<div data-part-role="select-container">
		<div data-part-role="select-label" data-placeholder="목록에서 불러오기..." data-tailholder="개의 아이템 선택됨">
			<hr class="vf">
			<div data-part-role="dropdown-button"></div>
			<div data-part-role="item-list">
				<span data-part-role="option" data-value="65535">옵션</span>
			</div>
		</div>
		<div data-part-role="item-container"></div>
	</div>
</div>

*/

const multiSelect = document.querySelectorAll('[data-form-object="multiselect"]');

multiSelect.forEach(function(e) {
	const selectLabel = e.querySelector('[data-part-role="select-label"]');
	const selectList = e.querySelector('[data-part-role="item-list"]');
	const selectOptions = selectList.querySelectorAll('[data-part-role="option"]');
	const selectChosen = e.querySelector('[data-part-role="item-container"]');
	const placeHolder = selectLabel.dataset.placeholder;
	const tailHolder = selectLabel.dataset.tailholder;
	var chosenValues = [];

	if (selectChosen.childElementCount == 0) {
		selectChosen.style.display = 'none';
	} else {
		selectChosen.style.display = 'flex';
	}

	selectLabel.addEventListener('click', function() {
		selectList.classList.add('on');
	});

	selectOptions.forEach(function(item) {
		item.addEventListener('click', function(x) {
			var self = x.target;
			const copiedItem = self.cloneNode(true);
			const deleteBtn = document.createElement('a');

			chosenValues.push(self.getAttribute('data-value'));
			console.table(chosenValues);

			deleteBtn.classList.add('delete_option');
			deleteBtn.setAttribute('href', 'javascript:void(0)');
			deleteBtn.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="1em" height="1em"><path fill="none" d="M0 0h24v24H0z"/><path fill="currentColor" d="M12 22C6.477 22 2 17.523 2 12S6.477 2 12 2s10 4.477 10 10-4.477 10-10 10zm0-11.414L9.172 7.757 7.757 9.172 10.586 12l-2.829 2.828 1.415 1.415L12 13.414l2.828 2.829 1.415-1.415L13.414 12l2.829-2.828-1.415-1.415L12 10.586z"/></svg>';
			copiedItem.append(deleteBtn);
			selectChosen.append(copiedItem);

			selectLabel.dataset.placeholder = selectChosen.childElementCount + tailHolder;

			if (selectChosen.childElementCount == 0) {
				selectChosen.style.display = 'none';
			} else {
				selectChosen.style.display = 'flex';
			}
		});
	});

	$(document).on('click', '.delete_option', function() {
		var findIndex = chosenValues.indexOf(this.parentNode.getAttribute('data-value'));

		chosenValues.splice(findIndex, 1);
		this.parentNode.remove();

		console.table(chosenValues);

		selectLabel.dataset.placeholder = selectChosen.childElementCount + tailHolder;

		if (selectChosen.childElementCount == 0) {
			selectChosen.style.display = 'none';
			selectLabel.dataset.placeholder = placeHolder;
		} else {
			selectChosen.style.display = 'flex';
		}
	});
});

document.addEventListener('click', function(f) {
	var multiSelect = $('[data-form-object="multiselect"]');
	var selectList = $('[data-part-role="item-list"]');

	if (multiSelect.has(f.target).length === 0) {
		selectList.removeClass('on');
	}
});
/* 커스텀 멀티 셀렉트 끝 */

/* 커스텀 파일 업로더 */
/* 업로더 사용시 아래의 구조 참조 */
/*

<div data-form-object="file-uploader">
	<div data-part-role="uploader-container">
		<div data-part-role="uploader-label" data-placeholder="선택된 파일 없음" data-tailholder="개의 파일 선택됨">
			<hr class="vf">
			<div data-part-role="dropdown-button"></div>
			<input type="file" name="filePict" id="filePict" accept="image/jpg, image/png, image/gif" hidden="true" multiple>
		</div>

		<div data-part-role="file-container"></div>
	</div>

	<template data-workpict>
		<a href="javascript:void(0)">
			<img src="" data-fileno="" data-file="" class="upload-file">
		</a>
	</template>
</div>

*/

const customUploader = document.querySelectorAll('[data-form-object="file-uploader"]');

customUploader.forEach(function(e) {
	const uploaderLabel = e.querySelector('[data-part-role="uploader-label"]');
	const placeHolder = uploaderLabel.dataset.placeholder;
	const tailHolder = uploaderLabel.dataset.tailholder;
	const uploaderFile = e.querySelector('[type="file"]');
	const fileContainer = e.querySelector('[data-part-role="file-container"]');
	const fileTemplate = e.querySelector('[data-pictfile]');

	uploaderLabel.dataset.placeholder = placeHolder;

	uploaderLabel.addEventListener('click', function() {
		uploaderFile.click();
	});
});
/* 커스텀 파일 업로더 끝 */

/* 커스텀 토글 버튼 */
/* 토글 버튼 사용시 아래의 구조 참조 */
/*

<div data-form-object="toggle" data-value="false">
	<div data-part-role="toggle-container">
		<div data-part-role="toggle-handle"></div>
	</div>
	<p data-part-role="toggle-label" data-placeholder="동의하지 않음" data-tailholder="동의함"></p>
</div>

*/

const toggleButton = document.querySelectorAll('[data-form-object="toggle"]');

toggleButton.forEach(function(e) {
	const toggleLabel = e.querySelector('[data-part-role="toggle-label"]');
	const placeHolder = toggleLabel.dataset.placeholder;
	const tailHolder = toggleLabel.dataset.tailholder;

	checkToggle();

	function checkToggle() {
		if (e.classList.contains('on')) {
			toggleLabel.textContent = tailHolder;
			e.dataset.value = true;
		} else {
			toggleLabel.textContent = placeHolder;
			e.dataset.value = false;
		}
	}

	e.addEventListener('click', function() {
		e.classList.toggle('on');
		checkToggle();
	});
});
/* 커스텀 토글 버튼 끝 */

/* 커스텀 체크 */
/* 사용시 아래의 구조 참조 */
/* 아이콘 사이즈 변경시 style="--object-size: 수치;" */
/* 아이콘의 선 두께와 밑줄 두께 변경시 style="--linewidth: 수치;" */
/*

<div data-form-object="agreement">
	<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 60 60">
		<circle fill="none" cx="30" cy="30" r="20" stroke-linecap="round" stroke-dasharray="130" />
		<path fill="none" d="M 32 18 L 21 29 L 50 50" stroke-linecap="round" stroke-dasharray="52" stroke-dashoffset="52" />
	</svg>
	<p data-part-role="agree-label">동의합니다.</p>
</div>

*/

const checkAgreement = document.querySelectorAll('[data-form-object="agreement"]');

checkAgreement.forEach(function(e) {
	e.addEventListener('click', function() {
		if (e.classList.contains('on')) {
			this.classList.remove('on');
			this.dataset.value = false;
		} else {
			this.classList.add('on');
			this.dataset.value = true;
		}
	});
});
/* 커스텀 체크 끝 */

/* 커스텀 타입 셀렉터 */
/* 타입 셀렉터 사용시 아래의 구조 참조 */
/* 아이콘 사이즈 변경시 style="--object-size: 수치;" */
/*

<div data-form-object="risk-indicator" data-value="">
	<div data-part-role="indicator-container">
		<button type="button" data-part-role="indicator-low" data-chosen="false"></button>
		<button type="button" data-part-role="indicator-mid" data-chosen="false"></button>
		<button type="button" data-part-role="indicator-high" data-chosen="false"></button>
	</div>
	<p data-part-role="indicator-label"></p>
</div>

*/

const riskIndicator = document.querySelectorAll('[data-form-object="risk-indicator"]');

riskIndicator.forEach(function(e) {
	const idcLow = e.querySelector('[data-part-role="indicator-low"]');
	const idcMid = e.querySelector('[data-part-role="indicator-mid"]');
	const idcHigh = e.querySelector('[data-part-role="indicator-high"]');
	const riskLabel = e.querySelector('[data-part-role="indicator-label"]');

	idcLow.addEventListener('click', function() {
		e.dataset.value = 'low';
		riskLabel.textContent = '위험도 낮음';
		this.dataset.chosen = true;
		idcMid.dataset.chosen = false;
		idcHigh.dataset.chosen = false;
	});

	idcMid.addEventListener('click', function() {
		e.dataset.value = 'mid';
		riskLabel.textContent = '위험함';
		this.dataset.chosen = true;
		idcLow.dataset.chosen = false;
		idcHigh.dataset.chosen = false;
	});

	idcHigh.addEventListener('click', function() {
		e.dataset.value = 'high';
		riskLabel.textContent = '매우 위험함';
		this.dataset.chosen = true;
		idcLow.dataset.chosen = false;
		idcMid.dataset.chosen = false;
	});
});
/* 커스텀 타입 셀렉터 끝 */

/* 모달 선언 */
const modalWindow = document.querySelector('[data-layer-type="modal"]'); // 레이어 타입이 모달일 때 모달로 지정
const modalContent = modalWindow.querySelector('[data-modal-content]');
const modalClose = modalWindow.querySelector('[data-modal-close]');

modalWindow.addEventListener('click', function(e) {
	console.log(e.target.nodeName);

	if (e.target.nodeName === 'DIALOG') {
		modalWindow.close();
	}

	if (e.target == modalClose) {
		modalWindow.close();
	}
});
/* 모달 선언 끝 */

/* CSRF 토큰 */
var _header = $('meta[name="_csrf_name"]').attr('content'); 
var _token = $('meta[name="_csrf"]').attr('content');
/* CSRF 토큰 끝 */

/* AJAX */
$.ajaxSetup({
	// statusCode: {
	// 	400 : function() {
	// 		errorAlert("400 : Bad Request.");
	// 	},
	// 	404 : function() {
	// 		errorAlert("404 : Page Not Found.");
	// 	},
	// 	500 : function() {
	// 		errorAlert("500 : Server Error.");
	// 	}
	// },
	beforeSend : function(xhr) {
		xhr.setRequestHeader(_header, _token);
	},
	complete : function() {

	},
	error : function(xhr, ajaxOptions, thrownError) {
		var errorMessage = xhr.responseText;

		if (errorMessage.indexOf('"Error"') > -1) {
			errorMessage = errorMessage.substring(errorMessage.indexOf('", "') + 4, errorMessage.indexOf('", "red"'));
			alert(errorMessage);
		} else {
			alert(xhr.status + ' : ' + xhr.statusText);
		}

		// 이 에러메시지를 보면 500 에러도 상세 내용 확인 가능 
		//errorAlert(xhr.statusCode + '\r\n' + thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
	},
	cache: false
});
/* AJAX 끝 */

/* ---------- Functions ---------- */

/* 배열에서 중복 체크하기 */
function isDuplicate(array) {
	const isDup = array.some(function(e) {
		return array.indexOf(e) !== array.lastIndexOf(e);
	});

	return isDup;
}
/* 배열에서 중복 체크하기 끝 */

/* 세션 가져오기 */
function getItem(key) {
    const value = sessionStorage.getItem(key);

    if (key === 'data') return value === null ? null : JSON.parse(value);
    else return value === null ? [] : JSON.parse(value);
}
/* 세션 가져오기 끝 */

/* 세션 저장 */
function setItem(key, value) {
    if (value === null || value === undefined) return;

    const toJson = JSON.stringify(value);

    sessionStorage.setItem(key, toJson);
}
/* 세션 저장 끝 */

/* 세션 삭제 */
function delSetItem(key){
	sessionStorage.removeItem(key);
}
/* 세션 삭제 끝*/

/* 쿠키 */
function setCookie(cookieName, value, exdays) {
    var exdate = new Date();

    exdate.setDate(exdate.getDate() + exdays);

    var cookieValue = escape(value) + ((exdays == null) ? '' : '; expires=' + exdate.toGMTString());

    document.cookie = cookieName + '=' + cookieValue;
}

function deleteCookie(cookieName) {
    var expireDate = new Date();

    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + '= ' + '; expires=' + expireDate.toGMTString();
}

function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';

    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if (end == -1) end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}
/* 쿠키 끝 */

/* URL 가져오기 */
$.urlParam = function(name){
    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);

    if (results == null){
        return null;
    } else {
        return results[1] || 0;
    }
}
/* URL 가져오기 끝 */

/* 존재하지 않는 이미지 대체 */
function notFound(target) {
    $(target).attr('src', '/resources/images/common/not_exist.png');
}
/* 존재하지 않는 이미지 대체 끝 */

/* 얼럿 메시지 띄우기 */
function createAlert(layerType, alertMsg) {
    const newAlert = document.createElement('div');
    const newAlertMsg = document.createElement('p');
    const existAlert = document.querySelector('[data-layer-type="' + layerType + '"]');

    // 왼쪽 상단 = toast
    // 오른쪽 하단 = banner
    // 모달 = modal
    // 중앙 하단 = alert

    if (existAlert) {
        existAlert.remove();
    }

    newAlert.dataset.layerType = layerType;
    newAlert.classList.add('on');
    newAlert.appendChild(newAlertMsg);
    newAlertMsg.textContent = alertMsg;
    document.body.appendChild(newAlert);

    setTimeout(function() {
        newAlert.remove();
    }, 5500);
}
/* 얼럿 메시지 띄우기 끝 */

/* 콤마 변환 */
$.round_comma = function(str, decimal, keyupCheck, roundCheck) {
	if (str != '') {
		str = str.replace(/,/gi, ''); // 콤마 제거
		/*if (roundCheck) {
			str = round(str, decimal);
		}*/
		var regx = new RegExp(/(-?\d+)(\d{3})/);
		var bExists = str.indexOf('.', 0);
		var strArr = str.split('.');
		while (regx.test(strArr[0])) {
			strArr[0] = strArr[0].replace(regx, '$1,$2');
		}
		var result = strArr[0];

		if (keyupCheck) {
			if (bExists > -1 && decimal > 0) {
				if (strArr[1].length > decimal) {
					if (!roundCheck) {
						strArr[1] = strArr[1].substring(0, decimal);
					}
				}
				result += '.' + strArr[1];
			}
		} else {
			if (bExists > -1) { // 소수점이 있는 경우
				if (strArr[1].length >= decimal) {
					if (!roundCheck) {
						strArr[1] = strArr[1].substring(0, decimal);
					}
				} else if (strArr[1].length < decimal) {
					for (var i = 0, e = decimal - strArr[1].length; i < e; i ++) strArr[1] += '0';
				}
				result += '.' + strArr[1];
			} else { // 소수점이 없는 경우
				if (decimal > 0) {
					for (var i = 0, e = decimal; i < e; i ++) {
						if (i == 0) result += '.';
						result += '0';
					}
				}
			}
		}
		return result;
	} else {
		return '';
	}
};

$.input_comma = function(str, decimal, keyupCheck) {
	if (str != '') {
		str = str.replace(/,/gi, ''); // 콤마 제거
		var regx = new RegExp(/(-?\d+)(\d{3})/);
		var bExists = str.indexOf('.', 0);
		var strArr = str.split('.');
		while (regx.test(strArr[0])) {
			strArr[0] = strArr[0].replace(regx, '$1,$2');
		}
		var result = strArr[0];

		if (keyupCheck) {
			if (bExists > -1 && decimal > 0) {
				if (strArr[1].length > decimal) {
					strArr[1] = strArr[1].substring(0, decimal);
				}
				result += '.' + strArr[1];
			}
		} else {
			if (bExists > -1) { // 소수점이 있는 경우
				if (strArr[1].length >= decimal) {
					strArr[1] = strArr[1].substring(0, decimal);
				} else if (strArr[1].length < decimal) {
					for (var i = 0, e = decimal - strArr[1].length; i < e; i ++) strArr[1] += '0';
				}
				result += '.' + strArr[1];
			} else { // 소수점이 없는 경우
				if (decimal > 0) {
					for (var i = 0, e = decimal; i < e; i ++) {
						if (i == 0) result += '.';
						result += '0';
					}
				}
			}
		}
		return result;
	} else {
		return '';
	}
};

$.fn.comma = function() {
	return this.each(function() {
		var $this = jQuery(this);
		var type = $this.prop('nodeName');
		$this.css('ime-mode', 'disabled');
		var decimal = $this.data('decimal');
		if (decimal == undefined || decimal == '') {
			decimal = $this.attr('data-decimal');
			if (decimal == undefined || decimal == '') {
				decimal = 0; //소수점 자릿수
			} else {
				decimal = parseInt(decimal);
			}
		} else {
			decimal = parseInt(decimal);
		}

		var str;
		if (type == 'INPUT') {
			str = '' + $this.val();
		} else {
			str = '' + $this.text();
		}

		var result = $.round_comma(str, decimal, false, true);
		// result = result.replace('.00', '');
		// if (result == '0.00') result = '0';
		if (type == 'INPUT') {
			$this.val(result);
		} else {
			$this.text(result);
		}

		if (type == 'INPUT') {
			$this.bind('keypress', function(e) {
				if ((e.which < 48 || e.which > 57) && e.which != 8 && e.which != 9 && e.which != 13 && e.which != 27
					&& e.which != 37 && e.which != 38 && e.which != 39 && e.which != 40 && e.which != 46 && e.which != 45) {
					return false;
				}
			}).bind('keyup', function(e) {
				$this.val($.input_comma($this.val(), decimal, true));
				//$this.val($this.val().replace('.00', ''));
			}).bind('blur', function(e) {
				$this.val($.input_comma($this.val(), decimal, false));
				//$this.val($this.val().replace('.00', ''));
			});
		} else {
			$this.text($.round_comma($this.text(), decimal, false, true));
			//$this.text($this.text().replace('.00', ''));
		}
	});
};
/* 콤마 변환 끝 */

/* 숫자 입력 강제 */
/* (Backspace:8, Tab:9, Enter:13, ESC:27, A:65, Z:90, a:97, z:122, 0:48, 9:57, +:43, -:45, =:61, 방향키:37~40) */
$.fn.only_no = function() {
	return this.each(function() {
		var $this = $(this);
		$this.css('ime-mode', 'disabled');
		var min = $this.data('min');
		var max = $this.data('max');

		var regexp = /[^0-9]/gi;
		$this.bind('keypress', function(e) {
			if ((e.which < 48 || e.which > 57) && e.which != 8 && e.which != 9 && e.which != 13 && e.which != 27
				&& e.which != 37 && e.which != 38 && e.which != 39 && e.which != 40) {
				return false;
			}
		}).bind('keyup', function(e) {
			if (regexp.test($this.val())) {
				$this.val($this.val().replace(regexp, ''));
			}
			if (min != undefined) {
				var v = $this.val();
				if (v == '') v =0;
				if (v < parseInt(min)) {
					$this.val(min);
				}
			}
			if (max != undefined) {
				var v = $this.val();
				if (v == '') v = 0;
				if (v > parseInt(max)) {
					$this.val(max);
				}
			}
		});
	});
};
/* 숫자 입력 강제 끝 */

/* 전화번호 자동 하이픈 */
// var phoneNum = document.getElementById('phoneNum');

// phoneNum.onkeyup = function() {
// 	this.value = autoHypenPhone(this.value);
// }

var autoHypenPhone = function(str) {
    str = str.replace(/[^0-9]/g, '');
    var tmp = '';
    if (str.length < 4) {
        return str;
    } else if (str.length < 7) {
        tmp += str.substr(0, 3);
        tmp += '-';
        tmp += str.substr(3);
        return tmp;
    } else if (str.length < 11) {
        tmp += str.substr(0, 3);
        tmp += '-';
        tmp += str.substr(3, 3);
        tmp += '-';
        tmp += str.substr(6);
        return tmp;
    } else {              
        tmp += str.substr(0, 3);
        tmp += '-';
        tmp += str.substr(3, 4);
        tmp += '-';
        tmp += str.substr(7);
        return tmp;
    }

    return str;
}
/* 전화번호 자동 하이픈 끝 */

/* 사업자 등록번호 자동 하이폰 */
function bizNoFormatter(num, type) {    
	var formatNum = '';     
	
	try {          
		if (num.length == 10) {               
			if (type == 0) {                    
				formatNum = num.replace(/(\d{3})(\d{2})(\d{5})/, '$1-$2-*****');               
			} else {                     
				formatNum = num.replace(/(\d{3})(\d{2})(\d{5})/, '$1-$2-$3');               
			}          
		}    
	} catch(e) {          
		formatNum = num;          
		console.log(e);     
	}     
	
	return formatNum;
}

/* 빈 입력값 체크 */
function emptyValChk(elmt) {
	var val = elmt.value;
	var label = elmt.dataset.label;

	if (val == null || val == '') {
		createAlert('alert', label + '를(을) 입력해 주세요.');
		elmt.focus();

		return false;
	}

	return true;
}
/* 빈 입력값 체크 끝 */

/* 클립보드에 URL 복사 */
function copyIt(toCopy) {
	var copyTaker = document.createElement('input');
	var copyValue = '';

	copyTaker.setAttribute('type', 'text');
	document.body.appendChild(copyTaker);

	if (toCopy = 'URL') {
		copyValue = window.document.location.href;
	}

	copyTaker.value = copyValue;
	copyTaker.select();
	document.execCommand('copy');
	document.body.removeChild(copyTaker);

	createAlert('alert', 'URL이 복사되었습니다.');
}
/* 클립보드에 URL 복사 끝 */

function callUpModal(title) {
	const newModal = document.createElement('dialog');
	const modalTitle = document.createElement('h2');
	const innerContent = document.createElement('div');
	const modalControl = document.createElement('div');

	newModal.id = 'winModal';
	newModal.dataset.layerType = 'modal';

	modalTitle.id = 'modalTitle';
	modalTitle.textContent = title;

	innerContent.id = 'modalContent';
	innerContent.dataset.modalContent = '';

	modalControl.id = 'modalControl';

	document.body.appendChild(newModal);
	newModal.appendChild(modalTitle);
	newModal.appendChild(innerContent);
	newModal.appendChild(modalControl);

	newModal.showModal();
}