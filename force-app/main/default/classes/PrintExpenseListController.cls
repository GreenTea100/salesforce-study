public with sharing class PrintExpenseListController {

    // PDF 페이지 별 경비 목록
    public List<List<Expense__c>> listExpensePage{get; set;}

    public PrintExpenseListController(){
        // URL에서 현재 프로젝트 Id 가져옴
        Id recordId = ApexPages.currentPage().getParameters().get('recordId');

        // 페이지 별 경비 목록 초기화
        listExpensePage = new List<List<Expense__c>>();

        // 현재 프로젝트의 경비 목록 조회
        List<Expense__c> listExpense = [
            SELECT Id, Name, Description__c, Spending__c
            FROM Expense__c
            WHERE Project__c = :recordId
        ];

        // 한 페이지에 들어갈 경비 목록 생성
        List<Expense__c> listPage = new List<Expense__c>();

        for(Integer i = 0; i < listExpense.size(); i++){
            // 20건 마다 새로운 페이지 생성
            if(i != 0 && Math.Mod(i, 20) == 0){
                listExpensePage.add(listPage);
                listPage = new List<Expense__c>();
            }

            listPage.add(listExpense[i]);
        }

        // 마지막 페이지 목록 추가
        listExpensePage.add(listPage);
    }


}