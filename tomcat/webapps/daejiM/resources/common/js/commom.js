const contextUrl = "/daejiM";

window.addEventListener('load', function () {
    $("#lodingView").css("display", "none");
})

// csrf 토큰값
var _header = $("meta[name='_csrf_name']").attr('content');
var _token = $("meta[name='_csrf']").attr('content');

/*
* 세션관련
*/

// 세션값 가져오기
function getItem(key) {
    const value = sessionStorage.getItem(key);

    if (key === 'data') return value === null ? null : JSON.parse(value);
    else return value === null ? [] : JSON.parse(value);
}

// 세션값 저장
function setItem(key, value) {
    if (value === null || value === undefined) return;

    const toJson = JSON.stringify(value);

    sessionStorage.setItem(key, toJson);
}

/*
* 쿠키관련
*/

function setCookie(cookieName, value, exdays) {
    var exdate = new Date();

    exdate.setDate(exdate.getDate() + exdays);

    var cookieValue = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());

    document.cookie = cookieName + "=" + cookieValue;
}

function deleteCookie(cookieName) {
    var expireDate = new Date();

    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}

function getCookie(cookieName) {
    cookieName = cookieName + '=';

    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';

    if (start != -1) {
        start += cookieName.length;

        var end = cookieData.indexOf(';', start);

        if (end == -1) end = cookieData.length;

        cookieValue = cookieData.substring(start, end);
    }

    return unescape(cookieValue);
}

/* url값 가져오기
* example.com?param1=name&amp;param2=&amp;id=6
* $.urlParam('param1'); // name
* $.urlParam('id');     // 6
* $.urlParam('param2'); // null
*/

$.urlParam = function (name) {
    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);

    if (results == null) {
        return null;
    } else {
        return results[1] || 0;
    }
}

$.ajaxSetup({
    /*statusCode: {
        400: function () {
            errorAlert("400 : Bad Request.");
        },
        404: function () {
            errorAlert("404 : Page Not Found.");
        },
        500: function () {
            errorAlert("500 : Server Error.");
        }
    },*/
    beforeSend: function (xhr) {
        // 로딩이미지 보여주기
        $("#lodingView").css("display", "block");

        //csrf 토큰 보내기
        xhr.setRequestHeader(_header, _token);
    },
    complete: function () {
        // 로딩이미지 숨기기
        $("#lodingView").css("display", "none");

        //
    },
    error: function (xhr, ajaxOptions, thrownError) {
        /*var errorMessage = xhr.responseText;
        if (errorMessage.indexOf("'Error'") > -1) {
            errorMessage = errorMessage.substring(errorMessage.indexOf("', '") + 4, errorMessage.indexOf("', 'red'"));
            alert(errorMessage);
        } else {
            alert(xhr.status + " : " + xhr.statusText);
        }*/

        if (xhr.status == 401) {
            //인증실패 로그인페이지로 이동
            toastAlert('warning', "인증에 실패했습니다. 로그인페이지로 이동합니다.");
            setTimeout(function () {
                location.href = "/daejiM";
            }, 4000)
        } else if (xhr.status == 403) {
            //세션만료 로그인 페이지로
            toastAlert('warning', "세션이 만료가 되었습니다. 로그인페이지로 이동합니다.");
            setTimeout(function () {
                location.href = "/daejiM";
            }, 4000)
        } else if (xhr.status == 0) {
            //ajax 통신 취소
            toastAlert('warning', "재 로그인이 필요합니다. 로그인페이지로 이동합니다.");
            setTimeout(function () {
                location.href = "/daejiM";
            }, 4000)
        }

        // 이 에러 메시지를 보면 500 에러도 상세 내용 확인 가능
        // errorAlert(xhr.statusCode + "\r\n" + thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    },
    cache: false
});

$.round_comma = function (str, decimal, keyupCheck, roundCheck) {
    if (str != "") {
        str = str.replace(/,/gi, ''); // 콤마 제거
        /*if (roundCheck) {
            str = round(str, decimal);
        }*/
        var regx = new RegExp(/(-?\d+)(\d{3})/);
        var bExists = str.indexOf(".", 0);
        var strArr = str.split('.');

        while (regx.test(strArr[0])) {
            strArr[0] = strArr[0].replace(regx, "$1,$2");
        }

        var result = strArr[0];

        if (keyupCheck) {
            if (bExists > -1 && decimal > 0) {
                if (strArr[1].length > decimal) {
                    if (!roundCheck) {
                        strArr[1] = strArr[1].substring(0, decimal);
                    }
                }

                result += "." + strArr[1];
            }
        } else {
            if (bExists > -1) {
                // 소수점이 있는 경우
                if (strArr[1].length >= decimal) {
                    if (!roundCheck) {
                        strArr[1] = strArr[1].substring(0, decimal);
                    }
                } else if (strArr[1].length < decimal) {
                    for (var i = 0, e = decimal - strArr[1].length; i < e; i++) strArr[1] += "0";
                }

                result += "." + strArr[1];
            } else {
                // 소수점이 없는 경우
                if (decimal > 0) {
                    for (var i = 0, e = decimal; i < e; i++) {
                        if (i == 0) result += ".";

                        result += "0";
                    }
                }
            }
        }

        return result;
    } else {
        return "";
    }
};

$.input_comma = function (str, decimal, keyupCheck) {
    if (str != "") {
        str = str.replace(/,/gi, ''); // 콤마 제거

        var regx = new RegExp(/(-?\d+)(\d{3})/);
        var bExists = str.indexOf(".", 0);
        var strArr = str.split('.');

        while (regx.test(strArr[0])) {
            strArr[0] = strArr[0].replace(regx, "$1,$2");
        }

        var result = strArr[0];

        if (keyupCheck) {
            if (bExists > -1 && decimal > 0) {
                if (strArr[1].length > decimal) {
                    strArr[1] = strArr[1].substring(0, decimal);
                }

                result += "." + strArr[1];
            }
        } else {
            if (bExists > -1) {
                // 소수점이 있는 경우
                if (strArr[1].length >= decimal) {
                    strArr[1] = strArr[1].substring(0, decimal);
                } else if (strArr[1].length < decimal) {
                    for (var i = 0, e = decimal - strArr[1].length; i < e; i++) strArr[1] += "0";
                }

                result += "." + strArr[1];
            } else {
                // 소수점이 없는 경우
                if (decimal > 0) {
                    for (var i = 0, e = decimal; i < e; i++) {
                        if (i == 0) result += ".";

                        result += "0";
                    }
                }
            }
        }

        return result;
    } else {
        return "";
    }
};

// 천단위 콤마 처리. -(음수), 소수점 사용 가능

$.fn.comma = function () {
    return this.each(function () {
        var $this = jQuery(this);
        var type = $this.prop('nodeName');

        $this.css('ime-mode', 'disabled');

        var decimal = $this.data('decimal');

        if (decimal == undefined || decimal == '') {
            decimal = $this.attr('data-decimal');
            if (decimal == undefined || decimal == '') {
                // decimal = 2; // 소수점 2자리
                decimal = 0;
            } else {
                decimal = parseInt(decimal);
            }
        } else {
            decimal = parseInt(decimal);
        }

        var str;

        if (type == 'INPUT') {
            str = "" + $this.val();
        } else {
            str = "" + $this.text();
        }

        var result = $.round_comma(str, decimal, false, true);
        // result = result.replace(".00", "");
        // if (result == "0.00") result = "0";
        if (type == 'INPUT') {
            $this.val(result);
        } else {
            $this.text(result);
        }

        if (type == 'INPUT') {
            $this.bind('keypress', function (e) {
                if ((e.which < 48 || e.which > 57) && e.which != 8 && e.which != 9 && e.which != 13 && e.which != 27
                    && e.which != 37 && e.which != 38 && e.which != 39 && e.which != 40 && e.which != 46 && e.which != 45) {
                    return false;
                }
            }).bind('keyup', function (e) {
                $this.val($.input_comma($this.val(), decimal, true));
                // $this.val($this.val().replace(".00", ""));
            }).bind('blur', function (e) {
                $this.val($.input_comma($this.val(), decimal, false));
                // $this.val($this.val().replace(".00", ""));
            });
        } else {
            $this.text($.round_comma($this.text(), decimal, false, true));
            // $this.text($this.text().replace(".00", ""));
        }
    });
};

// 숫자만 입력 가능 (Backspace:8, Tab:9, Enter:13, ESC:27, A:65, Z:90, a:97, z:122, 0:48, 9:57, +:43, -:45, =:61, 방향키:37~40)

$.fn.only_no = function () {
    return this.each(function () {
        var $this = $(this);

        $this.css('ime-mode', 'disabled');

        var min = $this.data("min");
        var max = $this.data("max");
        var regexp = /[^0-9]/gi;

        $this.bind('keypress', function (e) {
            if ((e.which < 48 || e.which > 57) && e.which != 8 && e.which != 9 && e.which != 13 && e.which != 27 && e.which != 37 && e.which != 38 && e.which != 39 && e.which != 40) {
                return false;
            }
        }).bind('keyup', function (e) {
            if (regexp.test($this.val())) {
                $this.val($this.val().replace(regexp, ""));
            }

            if (min != undefined) {
                var v = $this.val();

                if (v == "") v = 0;

                if (v < parseInt(min)) {
                    $this.val(min);
                }
            }

            if (max != undefined) {
                var v = $this.val();

                if (v == "") v = 0;

                if (v > parseInt(max)) {
                    $this.val(max);
                }
            }
        });
    });
};


/* 폰번호 하이픈(-) 자동
* var phoneNum = document.getElementById('phoneNum');
* phoneNum.onkeyup = function(){
* 	this.value = autoHypenPhone( this.value ) ;
* }
*/

var autoHypenPhone = function (str) {
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


/*
* 이메일체크
*/

function CheckEmail(str) {
    var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;

    if (!reg_email.test(str)) {
        return false;
    } else {
        return true;
    }
}

// alert 창

/*
* toastAlert('success', '성공');
* toastAlert('warning', '실패');
*/

function toastAlert(type, msg) {
    const Toast = Swal.mixin({
        toast: true,
        position: 'center-center',
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: false,
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer)
            toast.addEventListener('mouseleave', Swal.resumeTimer)
        }
    });

    Toast.fire({
        icon: type,
        title: msg
    });
}

// 이미지 체크

function isImage(url, target) {
    var img = new Image();

    img.onload = function () {
        target.attr("src", url);
    }

    img.onerror = function () {
        target.attr("src", '/daejiM/resources/common/img/no_image.jpg');
    }

    img.src = url;
}

/* 디바이스 체크 */

function deviceCheck() {
    let pointerCoarse = window.matchMedia('(pointer: coarse)').matches ? true : false;
    let windowSize = window.matchMedia('only screen and (max-width: 1024px').matches ? true : false;
    let screenOrient = window.matchMedia('only screen and (orientation: portrait)').matches ? true : false;

    if (window.navigator.userAgent.match(/MSIE | Internet Explorer | Trident/i)) {
        alert('인터넷 익스플로러는 더이상 지원되지 않는 브라우저입니다.');
        window.location = 'microsoft-edge:' + window.location.href;
    }

    if (pointerCoarse == false) {
        console.log('Device check : %c사용하는 기기의 조작성이 정확합니다. PC 화면을 표시합니다.', 'color: mediumslateblue');

        return false;
    }

    if (windowSize == true) {
        console.log('Device check : %c사용하는 기기의 조작성이 정확하지 않습니다. 모바일 화면을 표시합니다.', 'color: mediumslateblue');

        return screenOrient;
    } else {
        console.log('Device check : %c사용하는 기기의 화면이 충분히 큽니다. PC 화면을 표시합니다.', 'color: mediumslateblue');

        return false;
    }
}

/* 디바이스 체크 끝 */


/* 데스크탑 / 모바일 구분 */
function windowSizeAdjust() {
    if (deviceCheck() == false) {
        document.documentElement.dataset.deviceType = 'desktop';
    } else {
        document.documentElement.dataset.deviceType = 'mobile';
    }
}

document.addEventListener('DOMContentLoaded', () => {
    windowSizeAdjust();
});

window.addEventListener('resize', () => {
    if (window.innerWidth <= 425) {
        document.documentElement.dataset.deviceType = 'mobile'
    } else {
        windowSizeAdjust();
    }
});