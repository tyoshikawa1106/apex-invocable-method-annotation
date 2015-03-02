public with sharing class AccountQueryAction {

    @InvocableMethod(label='Get Account Names' description='Returns the list of account names corresponding to the specified account IDs.')
    public static List<String> getAccountNames(List<ID> ids) {
        List<String> accountNames = new List<String>();
        List<Account> accounts = [SELECT Name FROM Account WHERE Id in :ids];
        for (Account account : accounts) {
            accountNames.add(account.Name);
        }
        return accountNames;
    }
}