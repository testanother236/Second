
@isTest
public with sharing class AccountHandlerTest {
    
    @isTest
    static void testUpdateAccountName_PositiveScenario() {
        // Create test data - a sample account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        Test.startTest();
        // Test the positive scenario: updating account name with valid data
        AccountHandler.updateAccountName(testAccount.Id, 'Updated Test Account');
        Test.stopTest();
        
        // Verify the account name was updated correctly
        Account updatedAccount = [SELECT Id, Name FROM Account WHERE Id = :testAccount.Id LIMIT 1];
        System.assertEquals('Updated Test Account', updatedAccount.Name, 'Account name should be updated to the new value');
    }
    
    @isTest
    static void testUpdateAccountName_NegativeScenario_InvalidId() {
        // Test negative scenario: passing invalid account ID
        Boolean exceptionThrown = false;
        
        Test.startTest();
        try {
            // Attempt to update with non-existent account ID
            AccountHandler.updateAccountName('001000000000000', 'Should Fail');
        } catch (Exception e) {
            exceptionThrown = true;
            // Verify it's the expected query exception
            System.assert(e instanceof System.QueryException, 'Should throw QueryException for invalid account ID');
        }
        Test.stopTest();
        
        System.assert(exceptionThrown, 'An exception should be thrown for invalid account ID');
    }
    
    @isTest
    static void testUpdateAccountName_NegativeScenario_NullId() {
        // Test negative scenario: passing null account ID
        Boolean exceptionThrown = false;
        
        Test.startTest();
        try {
            // Attempt to update with null account ID
            AccountHandler.updateAccountName(null, 'Should Fail');
        } catch (Exception e) {
            exceptionThrown = true;
            // Verify it's the expected query exception
            System.assert(e instanceof System.QueryException, 'Should throw QueryException for null account ID');
        }
        Test.stopTest();
        
        System.assert(exceptionThrown, 'An exception should be thrown for null account ID');
    }
    
    @isTest
    static void testUpdateAccountName_NegativeScenario_EmptyName() {
        // Test negative scenario: updating account name with empty string
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        Test.startTest();
        // Test updating with empty name
        AccountHandler.updateAccountName(testAccount.Id, '');
        Test.stopTest();
        
        // Verify the account name was updated to empty string
        Account updatedAccount = [SELECT Id, Name FROM Account WHERE Id = :testAccount.Id LIMIT 1];
        System.assertEquals('', updatedAccount.Name, 'Account name should be updated to empty string');
    }
    
    @isTest
    static void testUpdateAccountName_BulkScenario() {
        // Test bulk update scenario to ensure the method handles multiple records
        List<Account> testAccounts = new List<Account>();
        
        // Create multiple test accounts
        for(Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' + i));
        }
        insert testAccounts;
        
        Test.startTest();
        // Update each account with a new name
        for(Account acc : testAccounts) {
            AccountHandler.updateAccountName(acc.Id, 'Bulk Updated ' + acc.Name);
        }
        Test.stopTest();
        
        // Verify all accounts were updated correctly
        List<Account> updatedAccounts = [SELECT Id, Name FROM Account WHERE Id IN :testAccounts];
        for(Account acc : updatedAccounts) {
            System.assert(acc.Name.startsWith('Bulk Updated'), 'All account names should be updated with bulk prefix');
        }
    }
}
