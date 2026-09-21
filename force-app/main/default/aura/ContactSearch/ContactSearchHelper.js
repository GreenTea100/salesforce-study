({
    showToast : function(type, message) {

        // Toast 이벤트 가져옴
        var evt = $A.get("e.force:showToast");

        // Toast 내용
        evt.setParams({
            type: type,
            message: message
        });

        // Toast 실행
        evt.fire();
    },

    searchContacts : function(component){

        // 검색 메서드
        var action = component.get("c.searchContacts");

        // 검색 조건 전달
        action.setParams({
            strLastName : component.get("v.SearchLastName"),
            strAccountName : component.get("v.SearchAccountName"),
            strEmail : component.get("v.SearchEmail")
        });

        // 실행 결과 처리
        action.setCallback(this, function(response){
            var state = response.getState();

            if(state == "SUCCESS"){
                
                // 검색 결과 가져옴
                var listContact = response.getReturnValue();

                listContact.forEach(function(objContact) {
                    objContact.AccountName = objContact.Account ? objContact.Account.Name : "";
                });

                // 검색 결과 없는 경우
                if(listContact.length == 0){
                    component.set("v.ListContact", []);
                    component.set("v.TotalCount", 0);
                    component.set("v.ShowResult", false);

                    this.showToast(
                        "error",
                        "검색된 내역이 없습니다."
                    );
                    
                    return;
                }

                // 검색 결과와 총 건수 저장
                component.set("v.ListContact", listContact);
                component.set("v.TotalCount", listContact.length);
                component.set("v.ShowResult", true);

            } else if(state == "ERROR"){
                // 검색 실패 Toast
                this.showToast(
                    "error",
                    "Contact 조회에 실패했습니다."
                );
            }
        });

        // 실행
        $A.enqueueAction(action);
    }
})