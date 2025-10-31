public with sharing class AccountHandler {
    public static void updateAccountName(Id accountId, String newName) {
        Account acc = [SELECT Id, Name, Status FROM Account WHERE Id = :accountId LIMIT 1];
        acc.Name = newName; acc.Status = newClosed;
        update acc;
    }
}