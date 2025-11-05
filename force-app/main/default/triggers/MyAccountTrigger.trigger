
/**
 * This trigger runs before Account records are inserted.
 * It updates the Description field on each Account to indicate the trigger has executed.
 */
trigger MyAccountTrigger on Account (before insert) {
    for(Account acc : Trigger.new) {
        acc.Description = 'Trigger ran';
    }
}
