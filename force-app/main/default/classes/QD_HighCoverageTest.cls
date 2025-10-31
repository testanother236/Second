
@isTest
public class QD_HighCoverageTest {
    
    // Test method for positive scenario - doubling a positive number
    @isTest
    static void testDoubleItPositiveNumber() {
        // Setup: Define a positive input value
        Integer inputValue = 5;
        Integer expectedResult = 10;
        
        Test.startTest();
        // Execute: Call the method under test
        Integer actualResult = QD_HighCoverage.doubleIt(inputValue);
        Test.stopTest();
        
        // Verify: Check that the result matches expected value
        System.assertEquals(expectedResult, actualResult, 'The method should double the positive input value');
    }
    
    // Test method for negative scenario - doubling a negative number
    @isTest
    static void testDoubleItNegativeNumber() {
        // Setup: Define a negative input value
        Integer inputValue = -3;
        Integer expectedResult = -6;
        
        Test.startTest();
        // Execute: Call the method under test
        Integer actualResult = QD_HighCoverage.doubleIt(inputValue);
        Test.stopTest();
        
        // Verify: Check that the result matches expected value
        System.assertEquals(expectedResult, actualResult, 'The method should double the negative input value');
    }
    
    // Test method for edge case - doubling zero
    @isTest
    static void testDoubleItZero() {
        // Setup: Define zero as input value
        Integer inputValue = 0;
        Integer expectedResult = 0;
        
        Test.startTest();
        // Execute: Call the method under test
        Integer actualResult = QD_HighCoverage.doubleIt(inputValue);
        Test.stopTest();
        
        // Verify: Check that doubling zero returns zero
        System.assertEquals(expectedResult, actualResult, 'The method should return zero when input is zero');
    }
    
    // Test method for edge case - doubling a large number
    @isTest
    static void testDoubleItLargeNumber() {
        // Setup: Define a large input value
        Integer inputValue = 1000000;
        Integer expectedResult = 2000000;
        
        Test.startTest();
        // Execute: Call the method under test
        Integer actualResult = QD_HighCoverage.doubleIt(inputValue);
        Test.stopTest();
        
        // Verify: Check that the method handles large numbers correctly
        System.assertEquals(expectedResult, actualResult, 'The method should double large numbers correctly');
    }
}
