global class ExpenseDateDelete_sc implements Schedulable {
    private Date dateFrom;
    private Date dateTo;
    
    // 삭제할 경비의 시작일과 종료일
    global ExpenseDateDelete_sc(Date dateFrom, Date dateTo) {
        this.dateFrom = dateFrom;
        this.dateTo = dateTo;
    }
    
    global void execute(SchedulableContext sc){
        // 입력받은 날짜 Batch에 전달
        Database.executeBatch(
            new ExpenseDateDelete_ba(dateFrom, dateTo), 50
            );
    }
}

// 매일 오후 2시 실행 시 사용함
// Date dateFrom = Date.newInstance(2026, 9, 1);
// Date dateTo = Date.newInstance(2026, 9, 30);
// String strCRON = '0 0 14 * * ? *';
// System.schedule(
//     '기간 경비 삭제',
//     strCRON,
//     new ExpenseDateDelete_sc(dateFrom, dateTo)
// );