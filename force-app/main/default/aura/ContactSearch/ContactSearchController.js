({
    fnInit : function(component, event, helper) {

        // Contact 검색 결과 컬럼 설정
        var listColumns = [
            {
               label: "Contact Id",
                fieldName: "Id",
                type: "button",
                typeAttributes: {
                    label: "View Details",
                    name: "detail",
                    variant: "neutral"
                }
            },
            {
                label: "Last Name",
                fieldName: "Last Name",
                type: "text"
            },
            {
                label: "Account Name",
                fieldName: "AccountName",
                type: "text"
            },
            {
                label: "Email",
                fieldName: "Email",
                type: "email"
            }
        ];

        // Datatable 컬럼 정보 저장
        component.set("v.Columns", listColumns);
    },

    fnSearch : function(component, event, helper){

        // 검색 조건 가져옴
        var strLastName = component.get("v.SearchLastName");
        var strAccountName = component.get("v.SearchAccountName");
        var strEmail = component.get("v.SearchEmail");

        // 검색 조건이 모두 없는 경우
        if(!strLastName && !strAccountName && !strEmail){
            helper.showToast(
                "error",
                "검색 조건을 입력해주세요."
            );

            return;
        }

        // 검색 조건이 있는 경우 Contact 조회
        helper.searchContacts(component);
    },

    fnRowAction : function(component, event, helper){
        // 클릭한 버튼 정보를 가져옴
        var action = event.getParam("action");

        // 클릭한 행의 Contact 정보를 가져옴
        var row = event.getParam("row");

        // Contact Id 버튼을 클릭한 경우 상세페이지 이동
        if(action.name == "detail"){
            var evtNavigate = $A.get("e.force:navigateToSObject");

           evtNavigate.setParams({
                recordId: row.Id,
                slideDevName: "detail"
            });

            evtNavigate.fire();
        }
    }
})