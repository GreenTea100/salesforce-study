@IsTest
private class Account_tr_test {

    /**
     * 각 테스트 메서드에서 공통으로 사용할 Account 테스트 데이터 생성
     */
    @TestSetup
    static void createTestData() {
        Account testAccount = new Account(
            Name = 'Test Account'
        );

        insert testAccount;
    }

    /**
     * Account 등록 테스트
     */
    @IsTest
    static void testAccountInsert() {
        Account accountToInsert = new Account(
            Name = 'Insert Test Account'
        );

        System.Test.startTest();

        insert accountToInsert;

        System.Test.stopTest();

        Account insertedAccount = [
            SELECT Id, Name
            FROM Account
            WHERE Id = :accountToInsert.Id
        ];

        System.assertNotEquals(
            null,
            insertedAccount.Id,
            'Account가 정상적으로 등록되어야 합니다.'
        );

        System.assertEquals(
            'Insert Test Account',
            insertedAccount.Name,
            'Account 이름이 입력한 값과 동일해야 합니다.'
        );
    }

    /**
     * Account 수정 테스트
     */
    @IsTest
    static void testAccountUpdate() {
        Account accountToUpdate = [
            SELECT Id, Name, Rating
            FROM Account
            WHERE Name = 'Test Account'
            LIMIT 1
        ];

        accountToUpdate.Rating = 'Hot';

        System.Test.startTest();

        update accountToUpdate;

        System.Test.stopTest();

        Account updatedAccount = [
            SELECT Id, Rating
            FROM Account
            WHERE Id = :accountToUpdate.Id
        ];

        System.assertEquals(
            'Hot',
            updatedAccount.Rating,
            'Account의 Rating이 Hot으로 변경되어야 합니다.'
        );
    }       
}