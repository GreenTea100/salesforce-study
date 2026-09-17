public with sharing class ProjectMember_tr extends TriggerHandler{
    private List<ProjectMember__c> listNew {get; set;}
    
    public ProjectMember_tr() {
        listNew = (list<ProjectMember__c>)Trigger.new;
    }
    
    // 생성되는 프로젝트 멤버의 Name 설정
    public override void beforeInsert(){
        doInsert();
    }
    
    
    
    public void doInsert(){
        
        // 프로젝트와 직원 정보 Id 수집
        Set<Id> projectIdSet = new Set<Id>();
        set<Id> employeeIdSet = new Set<Id>();
        
        for(ProjectMember__c member : listNew){
            if(member.Project__c != null){
                projectIdSet.add(member.Project__c);
            }
            
            if(member.Employee__c != null){
                employeeIdSet.add(member.Employee__c);
            }
        }
        
        System.debug('projectIdSet = ' + projectIdSet);
        System.debug('employeeIdSet = ' + employeeIdSet);
        
        // Id를 기준으로 프로젝트 정보 수집
        Map<Id, Project__c> projectMap =
            new Map<Id, Project__c>([
                Select Id, Name
                From Project__c
                Where Id In :projectIdSet
            ]);
        
        // Id를 기준으로 직원 정보 수집
        Map<Id, employee__c> employeeMap =
            new Map<Id, Employee__c>([
                Select Id, EmployeeName__c
                From Employee__c
                Where Id In :employeeIdSet
            ]);
        
        System.debug('projectMap = ' + projectMap);
        System.debug('employeeMap = ' + employeeMap);


        for(ProjectMember__c member : listNew){
            Project__c project = projectMap.get(member.Project__c);
            Employee__c employee = employeeMap.get(member.Employee__c);

            if(project != null
                && employee != null
                && member.Position__c != null
            ) {
                member.Name = project.Name + '_' +  member.Position__c + '_' + employee.EmployeeName__c;
            }
        }
    }// doInsert() end
}