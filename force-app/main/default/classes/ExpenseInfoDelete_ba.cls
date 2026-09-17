global with sharing class ExpenseInfoDelete_ba implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{

    global Database.QueryLocator start(Database.BatchableContext BC) {
        Date dateSevenMonthAgo = Date.today().addMonths(-7);
        
        // 종료일이 7개월 이상 지난 프로젝트의 경비 조회
        String strQuery = '   SELECT Id ';
        strQuery       += '   FROM   Expense__c';
        strQuery       += '   WHERE Project__r.EndDate__c <= :dateSevenMonthAgo';
        return DataBase.getQueryLocator(strQuery);
    }

    global void execute(Database.BatchableContext BC, List<Expense__c> listTarget){
        System.debug('listTarget >> ' + listTarget);
         try {
            // 조회된 경비의 내용을 비움
            List<Expense__c> listDelete = new List<Expense__c>();
            for(Expense__c exp : listTarget) {
                exp.Description__c = null;
            }
            update listTarget;
            
        }catch(Exception e) {
            System.debug('Error ===================> Error : ' + e.getMessage() + '/' + e.getLineNumber());
        }
    }

    global void finish(Database.BatchableContext BC) {
    }
}