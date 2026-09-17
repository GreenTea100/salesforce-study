global with sharing class ExpenseDateDelete_ba implements Database.Batchable<sObject> {
    private Date dateFrom;
    private Date dateTo;
    
    // 시작일과 종료일
    global ExpenseDateDelete_ba(Date dateFrom, Date dateTo) {
        this.dateFrom = dateFrom;
        this.dateTo = dateTo;
    }
    
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([
            SELECT Id, UseDate__c
            FROM Expense__c
            WHERE UseDate__c >= :dateFrom
            AND UseDate__c <= :dateTo
        ]);
    }
    
    
    global void execute(Database.BatchableContext BC, List<Expense__c> listTarget) {

        // 조회된 경비가 있으면 삭제
        if (!listTarget.isEmpty()) {
            delete listTarget;
        }
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
}