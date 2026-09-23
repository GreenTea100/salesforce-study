({
    fnInit : function(component, event, helper){
        // 현재 Contact 주소 조회
        helper.getContactAddress(component);
    },

    fnResetAddress : function(component, event, helper){
        // 주소 초기화
        helper.resetContactAddress(component);
    },

    fnOpenAddressSearch : function(component, event, helper){
        // 모달 노출
        component.set("v.ShowAddressSearch", true);
    }
})