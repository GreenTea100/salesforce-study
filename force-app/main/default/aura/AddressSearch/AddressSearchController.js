({
    fnClose: function (component, event, helper) {
        // 모달 노출 false
        component.set("v.showModal", false);
    },

    fnKeyDown: function (component, event, helper) {
        if (event.keyCode === 13) {
            // 새로운 검색은 첫 페이지부터 조회
            component.set("v.CurrentPage", 1);

            helper.searchAddress(component);
        }
    },

    fnSelectAddress: function (component, event, helper) {

        // 선택한 주소 순번
        var index = event.getSource().get("v.value");

        // 선택한 주소
        var listAddress = component.get("v.ListAddress");
        var selectedAddress = listAddress[index];

        // 선택한 주소값 저장
        component.set("v.SelectedZipNo", selectedAddress.zipNo);
        component.set("v.SelectedRoadAddr", selectedAddress.roadAddr);

        // 상세주소 화면 전환
        component.set("v.ShowAddressDetail", true);
    },

    fnPrevious: function (component, event, helper) {
        // 이전
        component.set("v.ShowAddressDetail", false);
    },

    fnSaveAddress: function (component, event, helper) {
        helper.saveAddress(component);
    },

    fnPreviousPage: function (component, event, helper) {
        // 이전 페이지
        var currentPage = component.get("v.CurrentPage");

        if (currentPage > 1) {
            helper.searchAddress(component, currentPage - 1);
        }
    },

    fnNextPage: function (component, event, helper) {
        // 다음 페이지
        var currentPage = component.get("v.CurrentPage");
        var totalPages = component.get("v.TotalPages");

        if (currentPage < totalPages) {
            helper.searchAddress(component, currentPage + 1);
        }
    }


})