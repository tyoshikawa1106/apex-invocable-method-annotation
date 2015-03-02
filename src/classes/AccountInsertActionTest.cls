@isTest
private class AccountInsertActionTest {

    private static User testAdminUser = new User(Id = UserInfo.getUserId());

    /**
     * insertAccountsTest1
     */
    static testMethod void insertAccountsTest1() {

        System.runAs(testAdminUser) {

            List<Account> accounts = new List<Account>();

            Test.startTest();

            List<ID> results = AccountInsertAction.insertAccounts(accounts);

            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * insertAccountsTest2
     */
    static testMethod void insertAccountsTest2() {

        System.runAs(testAdminUser) {

            List<Account> accounts = new List<Account>();
            accounts.add(new Account(Name = 'Sample'));

            Test.startTest();

            List<ID> results = AccountInsertAction.insertAccounts(accounts);

            Test.stopTest();

            System.assertEquals(results.size(), 1);
        }
    }
}