
@isTest
private class ContentLink_Test {

    // Utility method to create test ContentDocuments
    private static List<ContentDocument> createTestContentDocuments(Integer numDocs) {
        List<ContentVersion> contentVersions = new List<ContentVersion>();
        for (Integer i = 0; i < numDocs; i++) {
            contentVersions.add(new ContentVersion(
                Title = 'TestDoc' + i,
                PathOnClient = 'TestDoc' + i + '.txt',
                VersionData = Blob.valueOf('TestDocumentData' + i)
            ));
        }
        insert contentVersions;
        
        // Get ContentDocument Ids from ContentVersion
        List<ContentVersion> savedCVs = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id IN :contentVersions];
        Set<Id> cdIds = new Set<Id>();
        for(ContentVersion cv : savedCVs) {
            cdIds.add(cv.ContentDocumentId);
        }
        return [SELECT Id FROM ContentDocument WHERE Id IN :cdIds];
    }

    // Utility method to create test Accounts
    private static List<Account> createTestAccounts(Integer numAccts) {
        List<Account> accounts = new List<Account>();
        for (Integer j = 0; j < numAccts; j++) {
            accounts.add(new Account(Name = 'Test Account ' + j));
        }
        insert accounts;
        return accounts;
    }

    /**
     * Test: Positive scenario - batch job runs, accounts get ContentDocumentLinks assigned (happy path)
     */
    @isTest
    static void testBatchable_Execute_Positive() {
        // Setup test ContentDocuments and Accounts
        List<ContentDocument> cdList = createTestContentDocuments(2);
        List<Account> acctList = createTestAccounts(5);

        Test.startTest();

        // Run batch process
        ContentLink batch = new ContentLink();
        // Emulate batch chunk by executing execute() with our test accounts
        batch.execute(null, acctList);

        Test.stopTest();

        // Assertions: All accounts should have a ContentDocumentLink to the test ContentDocument(s)
        List<ContentDocumentLink> cdlLinks = [SELECT Id, LinkedEntityId, ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId IN :acctList];
        System.assertEquals(acctList.size(), cdlLinks.size(), 'Each account should have one ContentDocumentLink.');
        Set<Id> linkedContentDocIds = new Set<Id>();
        for(ContentDocument cd : cdList) {
            linkedContentDocIds.add(cd.Id);
        }
        for(ContentDocumentLink cdl : cdlLinks) {
            System.assert(linkedContentDocIds.contains(cdl.ContentDocumentId), 'Link must reference a valid test ContentDocument');
        }
    }

    /**
     * Test: Negative scenario - No ContentDocument records present, so nothing is linked
     */
    @isTest
    static void testBatchable_Execute_NoContentDocs() {
        // Setup: Create test Accounts but NO ContentDocument or ContentVersion
        List<Account> acctList = createTestAccounts(3);

        // Override query in ContentLink by using Test.isRunningTest() and DML for test setup
        Test.startTest();

        // Use an inner class to subclass and override the constructor to simulate 0 documents
        ContentLink batch = new ContentLink();
        // Manually set contentDocuments to empty via Reflection (since private), or simulate via no data

        // Remove all content documents to simulate empty scenario (useful on scratch org/tests only)
        // but in real orgs, the list will simply be empty if none exist.

        // Emulate batch chunk by executing execute() with our test accounts
        batch.execute(null, acctList);

        Test.stopTest();

        // Assertions: No ContentDocumentLinks should have been created for these accounts
        List<ContentDocumentLink> cdlLinks = [SELECT Id FROM ContentDocumentLink WHERE LinkedEntityId IN :acctList];
        System.assertEquals(0, cdlLinks.size(), 'No links should be created if no ContentDocuments present.');
    }

    /**
     * Test: Positive scenario - start() returns valid QueryLocator
     */
    @isTest
    static void testBatchable_Start() {
        ContentLink batch = new ContentLink();
        // Act
        Database.QueryLocator locator = batch.start(null);
        // Assert
        System.assertNotEquals(null, locator, 'start() should return a query locator.');
    }

    /**
     * Test: finish() just logs message. Smoke test for invocation.
     */
    @isTest
    static void testBatchable_Finish() {
        ContentLink batch = new ContentLink();
        // Just call finish and ensure no exceptions
        Test.startTest();
        batch.finish(null);
        Test.stopTest();
        // No assertions as finish just debugs
    }

}
