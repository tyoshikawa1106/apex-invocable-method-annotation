@isTest
private class ConvertLeadActionTest {

    private static User testAdminUser = new User(Id = UserInfo.getUserId());

    /**
     * convertLeadsTest1
     */
    static testMethod void convertLeadsTest1() {

        System.runAs(testAdminUser) {

            List<ConvertLeadAction.ConvertLeadActionRequest> requests = new List<ConvertLeadAction.ConvertLeadActionRequest>();

            Test.startTest();

            List<ConvertLeadAction.ConvertLeadActionResult> results = ConvertLeadAction.convertLeads(requests);

            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * convertLeadsTest2
     */
    static testMethod void convertLeadsTest2() {

        System.runAs(testAdminUser) {

            Lead lead = new Lead(
                 Company = 'Sample Comapnay'
                ,LastName = 'Sample LastName'
                ,Email = 'dev@sfdcdevelopers.com.test'
            );
            insert lead;

            LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted = true LIMIT 1];

            ConvertLeadAction.ConvertLeadActionRequest request = new ConvertLeadAction.ConvertLeadActionRequest();
            request.leadId = lead.Id;
            request.convertedStatus = convertStatus.MasterLabel;
            request.accountId = null;
            request.contactId = null;
            request.overWriteLeadSource = false;
            request.createOpportunity = false;
            request.ownerId = null;
            request.sendEmailToOwner = false;

            List<ConvertLeadAction.ConvertLeadActionRequest> requests = new List<ConvertLeadAction.ConvertLeadActionRequest>();
            requests.add(request);

            Test.startTest();

            List<ConvertLeadAction.ConvertLeadActionResult> results = ConvertLeadAction.convertLeads(requests);

            Test.stopTest();

            System.assertEquals(String.isNotEmpty(results[0].accountId), true);
            System.assertEquals(String.isNotEmpty(results[0].contactId), true);
            System.assertEquals(String.isEmpty(results[0].opportunityId), true);
        }
    }

    /**
     * convertLeadsTest3
     */
    static testMethod void convertLeadsTest3() {

        System.runAs(testAdminUser) {

            Account account = new Account(Name = 'Sample Company');
            insert account;

            Contact contact = new Contact(LastName = 'Sample LastName', AccountId = account.Id);
            insert contact;

            Lead lead = new Lead(
                 Company = account.Name
                ,LastName = contact.LastName
                ,Email = 'dev@sfdcdevelopers.com.test'
            );
            insert lead;

            LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted = true LIMIT 1];

            ConvertLeadAction.ConvertLeadActionRequest request = new ConvertLeadAction.ConvertLeadActionRequest();
            request.leadId = lead.Id;
            request.convertedStatus = convertStatus.MasterLabel;
            request.accountId = account.Id;
            request.contactId = contact.Id;
            request.overWriteLeadSource = true;
            request.createOpportunity = true;
            request.opportunityName = 'Sample Opportunity';
            request.ownerId = UserInfo.getUserId();
            request.sendEmailToOwner = true;

            List<ConvertLeadAction.ConvertLeadActionRequest> requests = new List<ConvertLeadAction.ConvertLeadActionRequest>();
            requests.add(request);

            Test.startTest();

            List<ConvertLeadAction.ConvertLeadActionResult> results = ConvertLeadAction.convertLeads(requests);

            Test.stopTest();

            System.assertEquals(String.isNotEmpty(results[0].accountId), true);
            System.assertEquals(String.isNotEmpty(results[0].contactId), true);
            System.assertEquals(String.isNotEmpty(results[0].opportunityId), true);
        }
    }
}