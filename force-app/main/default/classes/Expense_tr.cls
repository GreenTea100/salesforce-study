public with sharing class Expense_tr extends TriggerHandler {
   private List<Expense__c> listNew{get; set;}
   
   public Expense_tr() {
      // 새로운 경비 목록
      listNew = (List<Expense__c>)Trigger.new;
   }
   
   public override void afterInsert(){
      updateLastExpenseDate();
   }
   
   
   public void updateLastExpenseDate(){
      Set<Id> setProjectId = new Set<id>();
      
      for(Expense__c objExpense : listNew){
         if(objExpense.Project__c != null){
            setProjectId.add(objExpense.Project__c);
         }
      }
      
      if(setProjectId.isEmpty()){
         return;
      }
      
      // 프로젝트의 최근경비사용일 조회
      List<Project__c> listProject = [
         select Id, LastExpenseDate__c
         from Project__c
         where Id in :setProjectId
      ];
      
      // 프로젝트별 가장 최근 경비사용일 저장
      Map<Id, Date> mapLastExpenseDate = new Map<Id, Date>();
      
      for(Expense__c objExpense : listNew){
         if(objExpense.Project__c == null || objExpense.UseDate__c == null){
            continue;
         }
         
         // 기존 날짜보다 최신이면 교체
         if(!mapLastExpenseDate.containsKey(objExpense.Project__c)
            || mapLastExpenseDate.get(objExpense.Project__c) < objExpense.UseDate__c
         ){
            mapLastExpenseDate.put(objExpense.Project__c, objExpense.UseDate__c);
         }
      }


      // 기존 최근경비사용일보다 최신일 경우 변경
      List<Project__c> listUpdateProject = new List<Project__c>();

      for(Project__c objProject : listProject){
         Date dateLastExpense = mapLastExpenseDate.get(objProject.Id);

         if(dateLastExpense != null
         && (
            objProject.LastExpenseDate__c == null || objProject.LastExpenseDate__c < dateLastExpense
            )
         ){
            objProject.LastExpenseDate__c = dateLastExpense;
            listUpdateProject.add(objProject);
         }
      }

      // 변경할 프로젝트가 있다면 업데이트
      if(!listProject.isEmpty()){
         update listUpdateProject;
      }
   }
}