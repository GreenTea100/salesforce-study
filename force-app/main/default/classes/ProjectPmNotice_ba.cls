global with sharing class ProjectPmNotice_ba implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext BC){
        // 알림 날짜 계산
        Date DateToday = Date.today();
        Date Date10 = DateToday.addDays(10);    // StartDate__c == Date10 이면 오늘이 10일 전이라는 뜻
        Date Date40 = DateToday.addDays(40);
        Date Date50 = DateToday.addDays(50);
        
        // 알림 대상의 PM 정보 조회
        String strQuery =   'SELECT Id, Project__c, Employee__c, Position__c, ';
        strQuery +=         'Project__r.Name, Project__r.StartDate__c, Project__r.EndDate__c, ';
        strQuery +=         'Employee__r.Name, Employee__r.Email__c ';
        strQuery +=         'FROM ProjectMember__c ';
        strQuery +=         'WHERE Position__c = \'PM\' ';
        strQuery +=         'AND (Project__r.StartDate__c = :Date10 ';
        strQuery +=         'OR Project__r.EndDate__c = :Date40 ';
        strQuery +=         'OR Project__r.EndDate__c = :Date50)';
        
        return Database.getQueryLocator(strQuery);
    }
    global void execute(
        Database.BatchableContext BC,
    List<ProjectMember__c> listTarget
    ) {
        // 발송할 메일 목록
        List<Messaging.SingleEmailMessage> listMail =
            new List<Messaging.SingleEmailMessage>();
        
        // 알림 날짜 계산
        Date DateToday = Date.today();
        Date Date10 = DateToday.addDays(10);    // StartDate__c == Date10 이면 오늘이 10일 전이라는 뜻
        Date Date40 = DateToday.addDays(40);
        Date Date50 = DateToday.addDays(50);
        
        for(ProjectMember__c objProjectMember : listTarget) {
            String strSubject = '';
            String strBody = '';
            
            // 이메일 내용
            if(objProjectMember.Project__r.StartDate__c == Date10){
                strSubject = '[프로젝트 시작 10일 전] ' + objProjectMember.Project__r.Name;
                strBody = objProjectMember.Project__r.Name + ' 프로젝트가 10일 후 시작됩니다.';
            } else if (objProjectMember.Project__r.EndDate__c == Date40) {
                strSubject = '[프로젝트 종료 40일 전] ' + objProjectMember.Project__r.Name;
                strBody = objProjectMember.Project__r.Name + ' 프로젝트가 40일 후 종료됩니다.';
            } else if (objProjectMember.Project__r.EndDate__c == Date50) {
                strSubject = '[프로젝트 종료 50일 전] ' + objProjectMember.Project__r.Name;
                strBody = objProjectMember.Project__r.Name + ' 프로젝트가 50일 후 종료됩니다.';
            }
            
            // PM 이메일이 있는 경우 발송할 메일 구성
            if(
                String.isNotBlank(objProjectMember.Employee__r.Email__c)
                && String.isNotBlank(strSubject)
            ){
                Messaging.SingleEmailMessage objMail = new Messaging.SingleEmailMessage();
                
                objMail.setToAddresses(
                new List<String>{objProjectMember.Employee__r.Email__c}
                );
                
                objMail.setSubject(strSubject);
                objMail.setPlainTextBody(strBody);
                
                listMail.add(objMail);
            }
        } // for문 end
        
        
        // 발송
        if (!listMail.isEmpty()) {
            Messaging.sendEmail(listMail);
        }
        
    }
    global void finish(Database.BatchableContext BC){
        
    }
}