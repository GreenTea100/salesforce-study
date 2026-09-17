// 삭제할 경비의 테스트 기간 지정함
Date dateFrom = Date.newInstance(2027, 1, 1);
Date dateTo = Date.newInstance(2027, 1, 31);

// 기간 내 경비 삭제 Batch 실행함
Database.executeBatch(
    new ExpenseDateDelete_ba(dateFrom, dateTo),
    50
);