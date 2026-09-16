List<Project__c> projectList = [
    SELECT Id, Name
    FROM Project__c
];

List<Expense__c> expenseList = [
    SELECT Id,
            Project__c,
            Description__c,
            UseDate__c,
            Spending__c
    FROM Expense__c
];

System.debug('projectList = ' + projectList);
System.debug('expenseList = ' + expenseList);





Map<Id, List<Expense__c>> projectExpenseMap = 
    new Map<Id, List<Expense__c>>();


for(project__c project : projectList){
    projectExpenseMap.put(
        project.Id,
        new List<Expense__c>()
    );
}



for(Expense__c expense : expenseList){
    if (expense.Project__c != null && projectExpenseMap.containsKey(expense.Project__c)) {
        projectExpenseMap
            .get(expense.Project__c)
            .add(expense);
    }
}


System.debug('projectExpenseMap = ' + projectExpenseMap);





Map<Id, Integer> projectExpenseSumMap = 
    new Map<Id, Integer>();


for(Expense__c expense : expenseList) {
    if(expense.Project__c == null) {
        continue;
    }

    Integer spending = 0;

    if(expense.Spending__c != null){
        spending = expense.Spending__c.intValue();
    }

    if(projectExpenseSumMap.containsKey(expense.Project__c)){
        Integer currentSum = projectExpenseSumMap.get(expense.Project__c);

        projectExpenseSumMap.put(expense.Project__c, currentSum + spending);
    } else {
        projectExpenseSumMap.put(expense.Project__c, spending);
    }
}


System.debug('projectExpenseSumMap = ' + projectExpenseSumMap);