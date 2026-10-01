public with sharing class ProjectMemberSearchBar {

    @AuraEnabled(cacheable=true)
    public static List<String> getIndustryType() {
        List<String> listString = new List<String>();
        listString.add('기술');
        listString.add('제조');
        listString.add('미디어');
        listString.add('제약');
        listString.add('기타');
        return listString;
    }

    @AuraEnabled(cacheable=true)
    public static List<Project__c> getProjectList(String strIndustryType) {
        if (strIndustryType == null || strIndustryType == '') {
            return new List<Project__c>();
        } else {
            List<Project__c> listProjects = [
                    SELECT Id, Name
                    FROM Project__c
                    WHERE IndustryType__c = :strIndustryType
                    AND EndDate__c >= : Date.today()
            ];
            return listProjects;
        }
    }
}