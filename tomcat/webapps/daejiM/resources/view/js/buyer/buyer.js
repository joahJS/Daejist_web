/**
 * 프로젝트 : 대지에스텍 모바일
 * 페이지명 : 거래처 조회
 *
 * 작성자 : 김창완
 * 최초 작성일 : 2023. 08. 04 (금)
 *
 * 수정자 : 김창완
 * 최종 수정일 : 2023. 08. 04 (금)
 */

const tableBody = document.getElementById('bTbody'); // 거래처 테이블 <tbody>
const modalAccountDetails = document.getElementById('modalAccountDetails'); // 거래처 모달
const btnModalClose = document.getElementById('btnModalClose'); // 거래처 모달 닫기 버튼

const historySection = document.getElementById('detailHistory'); // 거래처 기록 영역
const historyContainer = document.querySelector('.history-table-container'); // 거래처 기록 컨테이너

const imagesSection = document.getElementById('detailImages'); // 거래처 이미지 영역
const imagesContainer = document.getElementById('accountImages'); // 거래처 이미지 컨테이너

const findObj = document.getElementById('findObj'); // 검색 분류
const findWord = document.getElementById('findWord'); // 검색어
const btnRetr = document.getElementById('BtnRetr'); // 조회 버튼

let totalItems = 500; // 총 데이터 수
let itemsPerPage = 50; // 표시할 데이터 수
let visiblePages = 4; // 보이는 페이지 수
let pagination = null;

let clickTimer = null; // 터치 타이머

$(document).ready(function() {
    getList(1);
});

btnRetr.addEventListener('click', function() { // 조회 버튼 클릭
    pagination = null;
    getList(1);
});

btnModalClose.addEventListener('click', function() { // 거래처 모달 닫기
    historyContainer.innerHTML = '';
    modalAccountDetails.close();
});

findWord.addEventListener('keydown', function(event) { // <form>에 포함되어 있는 검색어 입력창 submit 방지
    if (event.key === 'Enter') {
        event.preventDefault();
        pagination = null;
        getList(1);
    }
});

function touchStart(dealerCode) { // 시간 간격을 기준으로 터치와 더블 터치 구분
    if (clickTimer == null) { // 0.5초를 넘으면 타이머 리셋
        clickTimer = setTimeout(function() {
            clickTimer = null;
        }, 500)
    } else { // 0.5초 안에 다시 클릭하면 더블 터치로 처리
        clearTimeout(clickTimer);
        clickTimer = null;

        setModalContent(dealerCode);
    }
}

function createImgWindow(currentImageObject) {
    sessionStorage.setItem('storedText', currentImageObject.desc);
    sessionStorage.setItem('storedImage', currentImageObject.src);

    window.open('/daejiM/main/imgWindow', '대지에스텍 (이미지 미리보기)');
}

/* 거래처 모달 내용 출력 */

function setModalContent(dealerCode) {
    $.ajax({
        url: contextUrl + '/main/buyerHistoryList',
        type: 'post',
        data: { 'DEALER_CD': dealerCode },
        success: function(res) {
            const historyData = res.LIST;
            const imagesData = res.IMG;

            historyContainer.innerHTML = '';

            if (historyData !== null && historyData.length > 0) { // 거래처 기록 출력
                for (let i = 0; i < historyData.length; i ++) {
                    const row = historyData[i];
                    const historyRow = document.createElement('div');

                    historyRow.classList.add('history-table-row');
                    historyRow.innerHTML = `
                        <p class="history-table-row-note">
                            ${ row.REMARK }
                        </p>
                        <p class="history-table-row-date">
                            ${ row.ENT_DT }
                        </p>
                    `;

                    historyContainer.appendChild(historyRow);
                }
            } else {
                const emptyRow = document.createElement('div');

                emptyRow.style.paddingBlock = '15px';
                emptyRow.style.textAlign = 'center';
                emptyRow.textContent = '기록이 존재하지 않습니다.';

                historyContainer.appendChild(emptyRow);
            }

            if (imagesData) {
                imagesContainer.innerHTML = '';

                let imgObj = {
                    dealderCode: imagesData.dealer_cd,
                    images: [
                        {
                            src: imagesData.imimage1,
                            desc: imagesData.imtxt1
                        },
                        {
                            src: imagesData.imimage2,
                            desc: imagesData.imtxt2
                        },
                        {
                            src: imagesData.imimage3,
                            desc: imagesData.imtxt3
                        }
                    ]
                }

                imgObj.images.map(img => {
                    const imgContainer = document.createElement('div');

                    imgContainer.classList.add('account-image-details');
                    imgContainer.innerHTML = `
                        <button type="button" class="account-image-magnifier">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path fill="currentColor" d="M18.031 16.6168L22.3137 20.8995L20.8995 22.3137L16.6168 18.031C15.0769 19.263 13.124 20 11 20C6.032 20 2 15.968 2 11C2 6.032 6.032 2 11 2C15.968 2 20 6.032 20 11C20 13.124 19.263 15.0769 18.031 16.6168ZM16.0247 15.8748C17.2475 14.6146 18 12.8956 18 11C18 7.1325 14.8675 4 11 4C7.1325 4 4 7.1325 4 11C4 14.8675 7.1325 18 11 18C12.8956 18 14.6146 17.2475 15.8748 16.0247L16.0247 15.8748ZM10 10V7H12V10H15V12H12V15H10V12H7V10H10Z"></path></svg>
                        </button>

                        <div class="account-image-details-container">
                            <img src="" class="account-image-detailed-view" alt="이미지 상세보기">
                        </div>

                        <p class="account-image-description"></p>
                    `;

                    const imgElement = imgContainer.querySelector('.account-image-detailed-view');
                    const descElement = imgContainer.querySelector('.account-image-description');

                    if (!!img.src === true) {
                        const isThereDescription = img.desc === '' ? '이미지에 대한 설명 없음' : img.desc;

                        imgElement.src = 'data:image/png;base64,' + img.src;
                        descElement.textContent = isThereDescription;

                        imgContainer.addEventListener('click', () => createImgWindow(img));
                    } else {
                        imgElement.style.display = 'none';
                        descElement.textContent = '이미지 없음';
                    }

                    imagesContainer.appendChild(imgContainer);

                    img.domElement = imgContainer;

                    return img;
                });

                console.log(imgObj);
            } else {
                imagesContainer.innerHTML = '등록된 이미지가 없습니다.'
            }

            modalAccountDetails.showModal();
        },
        error: function() {
            historyContainer.innerHTML = '';
        }
    });
}

/* 거래처 모달 내용 출력 끝 */

/* 데이터 목록 불러오기 */

function getList(page) {
    let findObjValue = findObj.value;
    let findWordValue = findWord.value;
    let chkEOB_YN = document.querySelector('input[name="closure"]:checked').value;
    let data = {};

    data['FINDOBJ'] = findObjValue;
    data['FINDWORD'] = findWordValue;
    data['EOB_YN'] = chkEOB_YN;
    data['pageNum'] = page;
    data['pageLength'] = itemsPerPage;

    $.ajax({
        url: contextUrl + '/main/buyerList',
        type: 'post',
        data: data,
        success: function(res) {
            if (res !== null && res.length > 0) { // 데이터가 존재할 때
                historyContainer.innerHTML = '';
                tableBody.innerHTML = '';

                res = res.map(row => { // 데이터를 DOM Element와 이벤트를 포함한 오브젝트로 다시 맵핑
                    const tableRow = document.createElement('tr');

                    if (row === res[0]) {
                        totalItems = row.CNT;
                    }

                    tableRow.dataset.line = '';
                    tableRow.innerHTML = `
                        <td data-cvcod="${ row.DEALER_CD /** 거래처 코드 */ }">
                            <p>${ row.DEALER_NM /** 거래처명 */ }</p>
                        </td>

                        <td>
                            <p>${ row.REP_NM /** 대표자명 */ }</p>
                        </td>

                        <td>
                            <p>${ row.IDT_NO /** 사업자 번호 */ }</p>
                        </td>

                        <td>
                            <p>${ row.ADDR + ' ' + row.DTL_ADDR /** 도로명 주소 */ }</p>
                        </td>

                        <td>
                            <p>${ row.J_REGION /** 지역 */ }</p>
                        </td>

                        <td>
                            <p>${ row.FAX /** 팩스번호 */ }</p>
                        </td>

                        <td>
                            <p>
                                <input type="checkbox" style="pointer-events: none;" ${ row.WEB_FAX_YN === 'Y' ? 'checked' : '' /** 웹팩스 구분 */ } readonly>
                            </p>
                        </td>

                        <td>
                            <p>${ row.SCM_PSWD /** SCM 비밀번호 */ }</p>
                        </td>

                        <td>
                            <p>${ row.CHRG_NM /** 담당자명 */ }</p>
                        </td>

                        <td>
                            <p>${ row.CHRG_TEL_NO /** 담당자 전화번호 */ }</p>
                        </td>

                        <td>
                            <p>${ row.CHRG_HP_NO /** 담당자 휴대전화 */ }</p>
                        </td>

                        <td>
                            <p>${ row.EMAIL /** 담당자 e-mail */ }</p>
                        </td>

                        <td>
                            <p>
                                <input type="checkbox" style="pointer-events: none;" ${ row.EOB_YN === 'Y' ? 'checked' : '' /** 폐업 구분 */ } readonly>
                            </p>
                        </td>
                    `;

                    row.ELEMENT = tableRow;

                    tableBody.appendChild(tableRow);

                    tableRow.addEventListener('click', () => { // <tr> 클릭
                        const otherRows = tableBody.querySelectorAll('tr');

                        otherRows.forEach(e => {
                            e.classList.remove('tr_select');
                        });

                        if (tableRow.classList.contains('tr_select')) {
                            return;
                        } else {
                            tableRow.classList.add('tr_select');
                        }
                    });

                    tableRow.addEventListener('dblclick', () => { // <tr> 더블클릭
                        if (row.DEALER_CD === null || row.DEALER_CD === '') {
                            Swal.fire('거래처 코드를 확인할 수 없습니다.');

                            return;
                        } else {
                            setModalContent(row.DEALER_CD);
                        }
                    });
                });

                if (pagination === null) {
                    paging();
                }
            } else { // 데이터가 존재하지 않을 때
                totalItems = 0;
                tableBody.innerHTML = `
                    <tr>
                        <td colspan="100%">조회 결과가 없습니다.</td>
                    </tr>
                `;

                paging();
            }
        }
    });
}

/* 데이터 목록 불러오기 끝 */

/* 페이징 */

function paging() {
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