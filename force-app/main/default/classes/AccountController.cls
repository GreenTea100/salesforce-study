public with sharing class AccountController {
  public static List<Account> getAllActiveAccounts() {
    return [SELECT Id, Name, Active__c FROM Account WHERE Active__c = 'Yes' WITH USER_MODE];
  }
  
  
  @AuraEnabled(cacheable=true)
  public static List<Account> getAccounts() {
    return [SELECT Id, Name FROM Account LIMIT 10];
  }
  
}