({
    searchAddress: function (component, targetPage) {
        // 입력한 검색어 가져옴
        var strKeyword = component.get("v.SearchKeyword");
        
        // 조회할 페이지 결정
        var page = targetPage || component.get("v.CurrentPage");
        
        // 주소 검색 메서드
        var action = component.get("c.searchAddress");
        
        // 검색어 전달
        action.setParams({
            keyword: strKeyword,
            currentPage: page,
            countPerPage: component.get("v.CountPerPage")
        });
        
        // 검색 중 Spinner 노출
        component.set("v.ShowSpinner", true);
        
        action.setCallback(this, function (response) {
            var state = response.getState();
            
            // 검색 완료 후 Spinner 숨김
            component.set("v.ShowSpinner", false);
            
            if (state == "SUCCESS") {
                var returnValue = response.getReturnValue();

                // 전체 검색 건수 가져옴
                var totalCount =
                    parseInt(returnValue.results.common.totalCount, 10) || 0;

                // 새로운 주소 목록 저장
                component.set(
                    "v.ListAddress",
                    returnValue.results.juso || []
                );

                // 현재 페이지 변경함
                component.set("v.CurrentPage", page);

                // 전체 검색 건수 저장
                component.set("v.TotalCount", totalCount);

                // 전체 페이지 수 계산
                var countPerPage = component.get("v.CountPerPage");

                component.set(
                    "v.TotalPages",
                    Math.max(1, Math.ceil(totalCount / countPerPage))
                );

                // 검색 결과 영역 노출함
                component.set("v.ShowSearchResult", true);
            } else if (state == "ERROR") {

            }
        });
        
        $A.enqueueAction(action);
    },
    
    saveAddress: function (component) {
        var recordId = component.get("v.recordId");
        var postalCode = component.get("v.SelectedZipNo");
        var roadAddress = component.get("v.SelectedRoadAddr");
        var detailAddress = component.get("v.DetailAddress");
        
        var action = component.get("c.saveAddress");
        
        // 저장할 주소 값 전달
        action.setParams({
            recordId: recordId,
            postalCode: postalCode,
            roadAddress: roadAddress,
            detailAddress: detailAddress      
        });
        
        // Spinner 노출
        component.set("v.ShowSpinner", true);
        
        // 주소 저장 결과 확인
        action.setCallback(this, function (response) {
            var state = response.getState();
            
            // Spinner 숨김
            component.set("v.ShowSpinner", false);
            
            if (state == "SUCCESS") {
                this.showToast(
                    "success",
                    "주소 설정이 완료되었습니다."
                );
                
                // 모달 닫음
                component.set("v.showModal", false);

            } else if (state == "ERROR") {
                var errors = response.getError();

                if (errors && errors[0] && errors[0].message) {
                    this.showToast("error", errors[0].message);
                } else {
                    this.showToast("error", "주소 저장 중 오류가 발생했습니다.");
                }
            }
        });
                
        $A.enqueueAction(action);
    },
    
    showToast: function (type, message) {
        var evt = $A.get("e.force:showToast");
        
        evt.setParams({
            type: type,
            message: message
        });
        
        evt.fire();
    }
})