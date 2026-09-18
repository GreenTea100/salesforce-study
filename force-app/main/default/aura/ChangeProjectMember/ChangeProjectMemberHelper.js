({
    getProjectMembers : function(component) {

        // 프로젝트 멤버 조회 메서드 가져옴
        var action = component.get("c.getProjectMembers");

        // 프로젝트 Id 전달
        action.setParams({
            recordId : component.get("v.recordId")
        });

        // 실행 결과 처리
        action.setCallback(this, function(response){

            var state = response.getState();

            if(state == "SUCCESS"){

                // 조회된 프로젝트 멤버 목록
                var listProjectMember = response.getReturnValue();

                // 콤보박스에서 사용할 형태 변환
                var listMemberOption = [];

                listProjectMember.forEach(function(objProjectMember){
                    listMemberOption.push({
                        label : objProjectMember.Employee__r.Name,
                        value : objProjectMember.Id,
                        position : objProjectMember.Position__c
                    });
                });

                // 멤버 목록 저장
                component.set("v.ListMember", listMemberOption);


            } else if (state == "ERROR"){
                console.log(response.getError());
            }
        });

        // 요청 실행
        $A.enqueueAction(action);

    },

    getAvailableEmployees : function(component) {
        var action = component.get("c.getAvailableEmployees");

        action.setCallback(this, function(response){
            var state = response.getState();

            if(state == "SUCCESS"){

                // 조회된 직원 목록
                var listEmployee = response.getReturnValue();

                // 콤보박스에서 사용할 형태
                var listEmployeeOption = [];

                listEmployee.forEach(function(objEmployee){
                    listEmployeeOption.push({
                        label: objEmployee.Name,
                        value: objEmployee.Id
                    });
                });

                component.set("v.ListEmployee", listEmployeeOption);
                
            } else if(state == "ERROR"){
                // 조회 실패 토스트
                this.showToast(
                    "error",
                    "직원 목록을 조회하지 못했습니다."
                );
            }
        });

        // 요청 실행
        $A.enqueueAction(action);
    },

    showToast : function(type, message){

        // Toast 이벤트 가져옴
        var evt = $A.get("e.force:showToast");

        // Toast 내용
        evt.setParams({
            type: type,
            message: message
        });

        evt.fire();
    },

    doChangeMember : function(component) {
        // 프로젝트 멤버 교체 메서드 가져옴
        var action = component.get("c.changeProjectMember");

        // 프로젝트 멤버와 직원 Id 전달
        action.setParams({
            projectMemberId : component.get("v.ChangeMember"),
            employeeId : component.get("v.Selectemployee")
        });

        action.setCallback(this, function(response){
            var state = response.setState();

            if(state == "SUCCESS"){
                // 교체 성공 토스트
                this.showToast(
                    "success",
                    "프로젝트 멤버가 교체되었습니다."
                );

                // 창 닫기
                $A.get("e.force:closeQuickAction").fire();

            } else if(state == "ERROR"){
                // 교체 실패 토스트
                this.showToast(
                    "error",
                    "프로젝트 멤버 교체에 실패했습니다."
                )
            }
        });

        // 요청 실행
        $A.enqueueAction(action);
    }
})