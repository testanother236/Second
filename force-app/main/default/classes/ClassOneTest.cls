
/**
 * Contains test methods for the ClassOne Apex class.
 */
@isTest
private class ClassOneTest 
{
    /**
     * Test method to verify the behavior of myMethod in ClassOne.
     */
    static testMethod void oneTest(){
        ClassOne controller = new ClassOne();
        controller.myMethod();
        //test
    }
}
