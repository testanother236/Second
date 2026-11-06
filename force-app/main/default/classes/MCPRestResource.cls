@RestResource(urlMapping='/customMCP/deleteBranchByName/*')
global with sharing class MCPRestResource {
    @HttpPost
    global static void deleteBranch() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String branchName = req.params.get('branchName');
        Set<Id> selectedIdSet = new Set<Id>();
        /*List<Flosum__Branch__c> brList = [
            SELECT Id, Flosum__Branch_Name__c
            FROM Flosum__Branch__c
            WHERE Flosum__Branch_Name__c = :branchName
        ];
        for (Flosum__Branch__c br : brList) {
            selectedIdSet.add(br.Id);
        }*/
        if (!selectedIdSet.isEmpty()) {
            /*Map<String, Object> dataMap = new Map<String, Object>();
            dataMap.put('selectedIdSet', selectedIdSet);
            dataMap.put('batchType', Flosum.MassDeleteSnapshotController.DELETE_SNAPSHOT_BATCH);
            Database.executeBatch(new Flosum.MassDeleteSnapshotController(dataMap), 500);*/
            //delete brList;
            res.responseBody = Blob.valueOf('Success');
            res.statusCode = 200;
        } else {
            res.responseBody = Blob.valueOf('Branch not found with name ' + branchName + '.');
            res.statusCode = 500;
        }
    }
}