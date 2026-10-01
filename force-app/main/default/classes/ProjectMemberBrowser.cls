public with sharing class ProjectMemberBrowser {

    @AuraEnabled(cacheable=true)
    public static List<Employee__c> getEmployee(String projectId) {

        //해당 프로젝트 기간에 프로젝트를 진행하고 있지 않은 직원을 조회해야함
        List<Project__c> listProjects = new List<Project__c>();
        listProjects = [
                SELECT Id, StartDate__c, EndDate__c
                FROM Project__c
                WHERE Id = :projectId
        ];

        Date dateStart = listProjects[0].StartDate__c < Date.today() ? Date.today() : listProjects[0].StartDate__c;
        Date dateEnd = listProjects[0].EndDate__c;

        List<ProjectMember__c> listPM = new List<ProjectMember__c>();
        listPM = [
                SELECT Id, Employee__c
                FROM ProjectMember__c
                WHERE (Project__r.StartDate__c >= :dateStart AND Project__r.StartDate__c <= :dateEnd)
                OR (Project__r.EndDate__c >= :dateStart AND Project__r.EndDate__c <= :dateEnd)
        ];

        Set<Id> setEmployeeIds = new Set<Id>();
        for(ProjectMember__c objPM : listPM){
            setEmployeeIds.add(objPM.Employee__c);
        }

        List<Employee__c> listEmployees = new List<Employee__c>();
        listEmployees = [
                SELECT Id, EmployeeName__c, JobLevel__c
                FROM Employee__c
                WHERE Id NOT IN :setEmployeeIds
                ORDER BY JobLevel__c DESC
        ];
        System.debug('listEmployees :: ' + listEmployees);
        return listEmployees;
    }

}