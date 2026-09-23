({
    searchAddress: function (component) {
        // 입력한 검색어 가져옴
        var strKeyword = component.get("v.SearchKeyword");
        
        // 주소 검색 메서드
        var action = component.get("c.searchAddress");
        
        // 검색어 전달
        action.setParams({
            keyword: strKeyword
        });
        
        action.setCallback(this, function (response) {
            var state = response.getState();
            
            if (state == "SUCCESS") {
                var returnValue = response.getReturnValue();
                
                // 검색된 주소 목록 저장
                component.set("v.ListAddress", returnValue.results.juso || []);
                
            } else if (state == "ERROR") {

            }
        });
        
        $A.enqueueAction(action);
    }
})