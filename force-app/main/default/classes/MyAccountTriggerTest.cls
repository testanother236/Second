@isTest
private class MyAccountTriggerTest {
    @isTest static void testTrigger() {
        Account a = new Account(Name='Test Account');
        insert a;
        // Re-query to get updated field values
        Account insertedAccount = [SELECT Description FROM Account WHERE Id = :a.Id];
        System.assertEquals('Trigger ran', insertedAccount.Description);
    }
}