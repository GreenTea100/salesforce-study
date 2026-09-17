global class ExpenseInfoDelete_sc implements Schedulable{
    global void execute(SchedulableContext sc) {
        // 경비 내용 초기화 Batch를 50건 단위로 실행
        Database.executeBatch(new ExpenseInfoDelete_ba() , 50);
    }
}

// Scheduled job 등록할 때는 아래와 같이 입력
// CRON example ) '0 30 16 * * ? *'  //16:30pm everyday
// String CRON = '0 0 22 * * ? *'; 
// System.schedule('스케줄 이름 및 설명', CRON, new ExpenseInfoDelete_sc ());