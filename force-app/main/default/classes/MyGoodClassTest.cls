
@isTest
public class MyGoodClassTest {
    
    // Test method for positive addition scenario
    @isTest
    static void testAddPositiveNumbers() {
        // Setup test data
        Integer num1 = 5;
        Integer num2 = 10;
        Integer expectedResult = 15;
        
        Test.startTest();
        // Execute the method being tested
        Integer actualResult = MyGoodClass.add(num1, num2);
        Test.stopTest();
        
        // Verify the result matches expected value
        System.assertEquals(expectedResult, actualResult, 'The sum of 5 and 10 should be 15');
    }
    
    // Test method for negative addition scenario
    @isTest
    static void testAddNegativeNumbers() {
        // Setup test data with negative numbers
        Integer num1 = -5;
        Integer num2 = -10;
        Integer expectedResult = -15;
        
        Test.startTest();
        // Execute the method being tested
        Integer actualResult = MyGoodClass.add(num1, num2);
        Test.stopTest();
        
        // Verify the result matches expected value
        System.assertEquals(expectedResult, actualResult, 'The sum of -5 and -10 should be -15');
    }
    
    // Test method for mixed positive and negative numbers
    @isTest
    static void testAddMixedNumbers() {
        // Setup test data with one positive and one negative number
        Integer num1 = 15;
        Integer num2 = -5;
        Integer expectedResult = 10;
        
        Test.startTest();
        // Execute the method being tested
        Integer actualResult = MyGoodClass.add(num1, num2);
        Test.stopTest();
        
        // Verify the result matches expected value
        System.assertEquals(expectedResult, actualResult, 'The sum of 15 and -5 should be 10');
    }
    
    // Test method for zero values
    @isTest
    static void testAddWithZero() {
        // Setup test data including zero
        Integer num1 = 0;
        Integer num2 = 7;
        Integer expectedResult = 7;
        
        Test.startTest();
        // Execute the method being tested
        Integer actualResult = MyGoodClass.add(num1, num2);
        Test.stopTest();
        
        // Verify the result matches expected value
        System.assertEquals(expectedResult, actualResult, 'The sum of 0 and 7 should be 7');
    }
    
    // Test method for maximum integer values
    @isTest
    static void testAddMaximumValues() {
        // Setup test data with maximum integer values
        Integer num1 = Integer.valueOf(2147483647);
        Integer num2 = 0;
        Integer expectedResult = 2147483647;
        
        Test.startTest();
        // Execute the method being tested
        Integer actualResult = MyGoodClass.add(num1, num2);
        Test.stopTest();
        
        // Verify the result matches expected value
        System.assertEquals(expectedResult, actualResult, 'The sum of maximum integer and 0 should be the maximum integer value');
    }
}
