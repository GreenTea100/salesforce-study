({
    fnInit : function(component, event, helper){
        helper.getProjectMembers(component);
    },

    fnChangeMember : function(component, event, helper) {

        // 선택한 프로젝트 멤버 Id 가져옴
        var strMemberId = event.getParam("value");

        // 선택한 프로젝트 멤버 Id 저장
        component.set("v.ChangedMember", strMemberId);

        // 프로젝트 멤버 목록
        var listMember = component.get("v.ListMember");

        // 선택한 프로젝트 멤버 정보
        var objSelectedMember = null;

        for (var i = 0; i < listMember.length; i++) {
            if (listMember[i].value === strMemberId) {
                objSelectedMember = listMember[i];
                break;
            }
        }

        // 멤버 정보를 찾지 못하면 중단함
        if (objSelectedMember == null) {
            helper.showToast(
                "error",
                "프로젝트 멤버 정보를 찾지 못했습니다."
            );
            return;
        }

        // PM이면 초기화
        if (objSelectedMember.position === "PM") {
            helper.showToast(
                "error",
                "PM은 교체할 수 없습니다."
            );

            component.set("v.ChangedMember", "");
            component.set("v.SelectedEmployee", "");
            component.set("v.ShowEmployeeOption", false);

            return;
        }

        // 교체 가능한 직원 목록 조회
        helper.getAvailableEmployees(component);

        // 직원 선택 영역
        component.set("v.ShowEmployeeOption", true);
    },

    fnChange : function(component, event, helper){
        
        // 프로젝트 멤버 교체 확인
        var result = confirm("프로젝트 멤버를 교체하시겠습니까?");

        // 실제 교체 요청
        if(result) {
            helper.doChangedMember(component);
        }

    },

    fnCancel : function(component, event, helper){

        // 창 닫기
        $A.get("e.force:closeQuickAction").fire();
    }
})