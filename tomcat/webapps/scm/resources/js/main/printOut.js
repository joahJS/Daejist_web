/* javascript (print out) */

/* ---------- jQuery basics ---------- */

$(window).on('load', function() {
	listSum();
    
}); // 페이지 로딩이 끝났을 때

$(document).ready(function() {
	
}); // 페이지가 시작될 때

/* ---------- Plain Javascripts ---------- */

const btnPrint = document.querySelector('.print_page');

btnPrint.addEventListener('click', function() {
    window.print();
});

/* 기초 데이터 (상단 테이블) */
const pvdNo = document.querySelector('[data-pvd-no]');
const supNo = document.querySelector('[data-sup-no]');

const pvdCo = document.querySelector('[data-pvd-co]');
const supCo = document.querySelector('[data-sup-co]');

const pvdName = document.querySelector('[data-pvd-name]');
const supName = document.querySelector('[data-sup-name]');

const pvdAddr = document.querySelector('[data-pvd-addr]');
const supAddr = document.querySelector('[data-sup-addr]');

const pvdDid = document.querySelector('[data-pvd-did]');
const supDid = document.querySelector('[data-sup-did]');

const pvdCat = document.querySelector('[data-pvd-cat]');
const supCat = document.querySelector('[data-sup-cat]');
/* 기초 데이터 끝 */

/* 배열 데이터 (하단 테이블) */
const rowTemplate = document.querySelector('[data-table-row]');
const rowContainer = document.querySelector('[data-row-list]');

/* 배열 데이터 끝 */

function listSum() {
    const totalLine = document.getElementById('tfoot');
    const totalCar = totalLine.querySelector('[data-sum-car]');
    const totalWgt = totalLine.querySelector('[data-sum-totwgt]');
    const totalRdc = totalLine.querySelector('[data-sum-rdcwgt]');
    const totalSuprice = totalLine.querySelector('[data-sum-suprice]');
    const totalTax = totalLine.querySelector('[data-sum-tax]');
    const totalSales = totalLine.querySelector('[data-sum-totsales]');

    var arrWeight = document.querySelectorAll('[data-row-totwgt]');
    var arrRdcWgt = document.querySelectorAll('[data-row-rdcwgt]');
    var arrSuprice = document.querySelectorAll('[data-row-suprice]');
    var arrTax = document.querySelectorAll('[data-row-tax]');
    var arrTotSales = document.querySelectorAll('[data-row-totsales]');

    var totLength = $('[data-row-list] tr').length;
    
    if(totLength != null && totLength != ''){
    	totalCar.dataset.sumCar = $('[data-row-list] tr').length - 2;
    }else{
    	totalCar.dataset.sumCar = '';
    }

    totalWgt.innerHTML = sumOfAllFears(arrWeight);
    totalRdc.innerHTML = sumOfAllFears(arrRdcWgt);
    totalSuprice.innerHTML = sumOfAllFears(arrSuprice);
    totalTax.innerHTML = sumOfAllFears(arrTax);
    totalSales.innerHTML = sumOfAllFears(arrTotSales);
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

    return (sumResult+"").replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
}
/* 배열의 숫자 총합 리턴 끝 */

$("#btnClose").on("click", function(){
	location.href="/scm/member/table.do";
})