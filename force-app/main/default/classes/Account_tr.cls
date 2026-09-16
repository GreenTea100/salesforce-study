public with sharing class Account_tr extends TriggerHandler {
    private List<Account> listNew {get; set;}
    private List<Account> listOld {get; set;}
    private Map<Id, Account> mapNew {get; set;}
    private Map<Id, Account> mapOld {get; set;}
    
    public Account_tr(){
        listNew = (List<Account>)Trigger.new;
        listOld = (List<Account>)Trigger.old;
        mapNew = (Map<Id,Account>)Trigger.newMap;
        mapOld = (Map<Id,Account>)Trigger.oldMap;
    }
    
    public override void beforeInsert(){
        doInsertAccount();
    }
    
    public override void afterInsert(){
        
    }
    
    public override void beforeUpdate(){
        doUpdateAccount();
    }
    
    public override void afterUpdate(){
        //doUpdateAccount();
    }
    
    public override void beforeDelete(){
        
    }
    
    //Account 생성 시, Rating의 값을 'Cold'로 지정
    public void doInsertAccount() {
        if(acc.Rating == null){
            for(Account acc : listNew){
                acc.Rating = 'Cold';
            }
        }
        
    }
    
    
    //Trigger.newMap(mapNew)을 이용하여 addError() 발생
    public void doUpdateAccount() {
        for(Account acc : listNew){
            if(mapOld.get(acc.Id).Rating == 'Hot' && acc.Rating == 'Cold'){
                acc.addError('Rating을 Hot에서 Cold로 변경할 수 없습니다.');
            }
        }
    }
    
    //Account 삭제 시, Rating 값이 'Hot'일 경우 삭제 불가
    public void doDeleteAccount() {
        //Code Block
    }
}