
/**
 * Batch class that links random ContentDocument records to Account records.
 */
public class ContentLink implements Database.Batchable<SObject>, Database.Stateful {

    /**
     * List of ContentDocument records used as source for random linking.
     */
    private List<ContentDocument> contentDocuments;

    /**
     * Constructs a ContentLink batch and retrieves up to 500 ContentDocument records.
     */
    public ContentLink() {
        this.contentDocuments = [
            SELECT Id
            FROM ContentDocument
            LIMIT 500
        ];
    }

    /**
     * Returns a QueryLocator for Account records to be processed.
     */
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id FROM Account LIMIT 900000
        ]);
    }

    /**
     * Executes the batch logic by linking random ContentDocument records to each Account in the scope.
     */
    public void execute(Database.BatchableContext bc, List<SObject> scope) {
        List<Account> accounts = (List<Account>) scope;
        List<ContentDocumentLink> links = new List<ContentDocumentLink>();

        Integer docsCount = contentDocuments.size();
        if (docsCount == 0) {
            System.debug('No content documents available.');
            return;
        }

        for (Account acc : accounts) {
            Integer rnd = Math.abs(Crypto.getRandomInteger());
            Integer randomIndex = Math.mod(rnd, docsCount); // используем Math.mod вместо %

            links.add(new ContentDocumentLink(
                ContentDocumentId = contentDocuments[randomIndex].Id,
                LinkedEntityId = acc.Id,
                ShareType = 'V',
                Visibility = 'AllUsers'
            ));
        }

        if (!links.isEmpty()) {
            insert links;
        }
    }

    /**
     * Logs a debug message upon batch completion.
     */
    public void finish(Database.BatchableContext bc) {
        System.debug('Batch finished.');
    }
}
