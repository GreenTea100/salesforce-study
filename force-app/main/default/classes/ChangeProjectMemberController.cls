public with sharing class ChangeProjectMemberController {
    
    @AuraEnabled
    public static List<ProjectMember__c> getProjectMembers(String recordId){

        // 현재 프로젝트에 등록된 프로젝트 멤버 조회
        List<ProjectMember__c> listProjectMember = [
            SELECT Id, Name, Position__c, Employee__c, Employee__r.EmployeeName__c
            FROM ProjectMember__c
            WHERE Project__c = :recordId
            ORDER BY Name
        ];

        return listProjectMember;
    }


    @AuraEnabled
    public static List<Employee__c> getAvailableEmployees(){
        Date dateToday = Date.today();

        // 진행 중 프로젝트에 투입된 직원 Id
        Set<Id> setAssigendEmployeeId = new Set<Id>();

        List<ProjectMember__c> listAssignedMember = [
            SELECT Employee__c
            FROM ProjectMember__c
            WHERE Employee__c != null
            AND Project__r.StartDate__c <= :dateToday
            AND Project__r.EndDate__c >= :dateToday
        ];

        for(ProjectMember__c objMember : listAssignedMember) {
            setAssigendEmployeeId.add(objMember.Employee__c);
        }

        // 진행 중 프로젝트에 투입되지 않은 직원
        List<Employee__c> listEmployee = [
            SELECT Id, Name, EmployeeName__c
            FROM Employee__c
            WHERE Id NOT IN :setAssigendEmployeeId
            ORDER BY EmployeeName__c
        ];

        return listEmployee;
    }


    @AuraEnabled
    public static void changeProjectMember(
        String projectMemberId,
        String employeeId
    ){
        // 선택한 프로젝트 멤버의 직원 정보 변경
        ProjectMember__c objProjectMember = new ProjectMember__c(
            Id = projectMemberId,
            Employee__c = employeeId
        );

        // 프로젝트 멤버 업데이트
        update objProjectMember;
    }
}