global with sharing class CustomMCPActions {
    @AuraEnabled
    global static void deleteAccountByID(String acountID) {
        delete [SELECT ID FROM Account WHERE Id = :acountID];
    }

    @AuraEnabled
    global static void deleteSnapshotsByID(String snapshotIdSetStr) {
        Map<String, Object> dataMap = new Map<String, Object>();
        Set<Id> selectedIdSet = (Set<Id>) JSON.deserialize(snapshotIdSetStr, Set<Id>.class);
        dataMap.put('selectedIdSet', selectedIdSet);
        dataMap.put('batchType', Flosum.MassDeleteSnapshotController.DELETE_SNAPSHOT_BATCH);
        Database.executeBatch(new Flosum.MassDeleteSnapshotController(dataMap), 500);
    }

    @AuraEnabled
    global static void deleteBranchesByID(String branchIdSetStr) {
        Map<String, Object> dataMap = new Map<String, Object>();
        Set<Id> selectedIdSet = (Set<Id>) JSON.deserialize(branchIdSetStr, Set<Id>.class);
        dataMap.put('selectedIdSet', selectedIdSet);
        dataMap.put('batchType', Flosum.MassDeleteSnapshotController.DELETE_SNAPSHOT_BATCH);
        Database.executeBatch(new Flosum.MassDeleteSnapshotController(dataMap), 500);
    }

    @AuraEnabled
    global static Boolean deleteBranchByName(String branchName) {
        Set<Id> selectedIdSet = new Set<Id>();
        for(Flosum__Branch__c br: [SELECT Id FROM Flosum__Branch__c WHERE Flosum__Branch_Name__c = :branchName]) {
            selectedIdSet.add(br.Id);
        }
        if(!selectedIdSet.isEmpty()) {
            Map<String, Object> dataMap = new Map<String, Object>();
            dataMap.put('selectedIdSet', selectedIdSet);
            dataMap.put('batchType', Flosum.MassDeleteSnapshotController.DELETE_SNAPSHOT_BATCH);
            Database.executeBatch(new Flosum.MassDeleteSnapshotController(dataMap), 500);
            return true;
        }
        return false;
    }
}