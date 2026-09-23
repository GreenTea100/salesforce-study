({
    fnClose: function (component, event, helper) {
        // 부모와 연결된  모달 노출 값 false 
        component.set("v.showModal", false);
    },

    fnKeyDown: function (component, event, helper) {

        // Enter 입력 시 주소 검색
        if (event.keyCode === 13) {
            helper.searchAddress(component);
        }
    },
    
    fnSelectAddress: function (component, event, helper) {
        
        // 선택한 주소 순번
        var index = event.getSource().get("v.value");
        
        // 선택한 주소
        var listAddress = component.get("v.ListAddress");
        component.set("v.SelectedAddress", listAddress[index]);
        
        // 상세주소 화면 전환
        component.set("v.ShowAddressDetail", true);
    }
    
    
})