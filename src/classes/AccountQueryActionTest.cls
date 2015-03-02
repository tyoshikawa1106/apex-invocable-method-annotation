@isTest
private class AccountQueryActionTest {

    private static User testAdminUser = new User(Id = UserInfo.getUserId());

    @testSetup
    static void setup() {
        
        System.runAs(testAdminUser) {
 
            // Create common test accounts
            Account testAccount = new Account(Name = 'Sample Account');
            insert testAccount;
        }
    }

    /**
     * getAccountNamesTest1
     */
    static testMethod void getAccountNamesTest1() {

        System.runAs(testAdminUser) {

            List<Id> ids = new List<Id>();

            Test.startTest();

            List<String> results = AccountQueryAction.getAccountNames(ids);

            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * getAccountNamesTest2
     */
    static testMethod void getAccountNamesTest2() {

        System.runAs(testAdminUser) {

            List<Account> accounts = [SELECT Id,Name FROM Account LIMIT 200];
            System.assertEquals(accounts.size(), 1);

            List<Id> ids = new List<Id>();
            for (Account a : accounts) {
                ids.add(a.Id);
            }

            Test.startTest();

            List<String> results = AccountQueryAction.getAccountNames(ids);

            Test.stopTest();

            System.assertEquals(results.size(), 1);
            System.assertEquals(results[0], accounts[0].Name);
        }
    }
}