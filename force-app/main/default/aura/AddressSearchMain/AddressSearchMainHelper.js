({
    getContactAddress : function(component){

        // 주소 조회 메서드 호출
        var action = component.get("c.getContactAddress");

        action.setParams({
            recordId : component.get("v.record")
        });

        action.setCallback(this, function(response){
            var state = response.getState();
            
            if (state == "SUCCESS") {
                // 조회한 주소 정보 저장
                component.set("v.objContact", response.getReturnValue());
                
            } else if (state == "ERROR") {
                this.showToast(
                    "error",
                    "주소 정보를 불러오지 못했습니다.");
            }
        });
        
        $A.enqueueAction(action);
    },
    
    resetContactAddress: function (component) {
        // 주소 초기화 메서드 호출
        var action = component.get("c.resetContactAddress");
        
        action.setParams({
            recordId: component.get("v.recordId")
        });
        
        action.setCallback(this, function (response) {
            var state = response.getState();
            
            if (state == "SUCCESS") {
                component.set("v.objContact", response.getReturnValue());
                
                this.showToast(
                    "success",
                    "주소가 초기화되었습니다.");
                
            } else if (state == "ERROR") {
                this.showToast(
                    "error",
                    "주소 초기화에 실패했습니다.");
            }
        });
        
        $A.enqueueAction(action);
    },
    
    showToast: function (type, message) {
        // Toast 메시지
        var evt = $A.get("e.force:showToast");
        
        evt.setParams({
            type: type,
            message: message
        });
        
        evt.fire();
    }
})