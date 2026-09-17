// 삭제할 경비의 기간 지정
Date dateFrom = Date.newInstance(2027, 1, 1);
Date dateTo = Date.newInstance(2027, 1, 31);

// 매일 오후 2시에 실행하도록 설정
String strCRON = '0 0 14 * * ? *';

// 기간 경비 삭제 Schedule 등록
System.schedule(
    '기간 경비 삭제',
    strCRON,
    new ExpenseDateDelete_sc(dateFrom, dateTo)
);