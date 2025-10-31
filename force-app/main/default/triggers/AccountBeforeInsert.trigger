
/**
 * This trigger is executed before Account records are inserted.
 * It ensures that every Account has a valid Name by setting a default value if the Name field is null or empty.
 */
trigger AccountBeforeInsert on Account (before insert) {
 for (Account acc : Trigger.new) {
        if (acc.Name == null || acc.Name == '') {
            acc.Name = 'Default Name';
        }
    }
}
