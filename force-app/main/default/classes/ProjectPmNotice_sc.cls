global class ProjectPmNotice_sc implements Schedulable {

    global void execute(SchedulableContext sc) {
        // PM 알림 Batch를 50건 단위로 실행
        Database.executeBatch(new ProjectPmNotice_ba(), 50);
    }
}

// 매일 오후 2시 실행 시 사용
// String CRON = '0 0 14 * * ? *';
// System.schedule('프로젝트 PM 일정 알림', CRON, new ProjectPmNotice_sc());