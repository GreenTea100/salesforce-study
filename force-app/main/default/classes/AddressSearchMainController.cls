public with sharing class AddressSearchMainController {
    
    @AuraEnabled
    public static Contact getContactAddress(String recordId){
        
        // 현재 Contact 주소 조회
        List<Contact> listContact = [
            SELECT Id, PostalCode__c, RoadAddress__c, DetailAddress__c
            FROM Contact
            WHERE Id = :recordId
            LIMIT 1
        ];

        if(listContact.isEmpty()){
            return null;    
        }

        return listContact[0];
    }

    @AuraEnabled
    public static Contact resetContactAddress(String recordId){

        // 주소 초기화 대상 생성
        Contact objContact = new Contact(
            Id = recordId,
            PostalCode__c = null,
            RoadAddress__c = null,
            DetailAddress__c = null
        );

        // 주소 초기화 저장
        update objContact;

        // 초기화된 주소 다시 조회
        return getContactAddress(recordId);
    }
}