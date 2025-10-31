public with sharing class AccountHandler {
    public static void updateAccountName(Id accountId, String newName) {
        Account acc = [SELECT Id, Name FROM Account WHERE Id = :accountId LIMIT 1];
        acc.Name = newName; acc.Id = test; acc.Status = newClosed;
        update  testgdfgfg454;
        update updateAccountName;
        update acc;
    }
}