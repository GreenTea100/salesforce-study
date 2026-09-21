public with sharing class ContactSearchController {
    
    @AuraEnabled
    public static List<Contact> searchContacts(
        String strLastName,
        String strAccountName,
        String strEmail
    ){
        String strQuery =   'SELECT Id, LastName, AccountId, Account.Name, Email ';
        strQuery +=         'FROM Contact ';
        strQuery +=         'WHERE Id != null';


        // Last Name 조건
        if (String.isNotBlank(strLastName)) {
            strQuery +=
                ' AND LastName LIKE \'%' +
                String.escapeSingleQuotes(strLastName) +
                '%\'';
        }

        // Account Name 조건
        if (String.isNotBlank(strAccountName)) {
            strQuery +=
                ' AND Account.Name LIKE \'%' +
                String.escapeSingleQuotes(strAccountName) +
                '%\'';
        }

        // Email 조건
        if (String.isNotBlank(strEmail)) {
            strQuery +=
                ' AND Email LIKE \'%' +
                String.escapeSingleQuotes(strEmail) +
                '%\'';
        }

         return Database.query(strQuery);
    }
}