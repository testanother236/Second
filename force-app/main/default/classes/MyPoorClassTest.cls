
@isTest
private class MyPoorClassTest {
    
    // Test method for positive scenario with valid string input
    @isTest
    static void testRiskyMethod_WithValidString() {
        // Setup test data
        String inputString = 'Hello';
        String expectedResult = 'Hello!';
        
        Test.startTest();
        // Execute method under test
        String actualResult = MyPoorClass.riskyMethod(inputString);
        Test.stopTest();
        
        // Verify results
        System.assertEquals(expectedResult, actualResult, 'The method should append an exclamation mark to the input string');
    }
    
    // Test method for negative scenario with null input
    @isTest
    static void testRiskyMethod_WithNullInput() {
        // Setup test data
        String inputString = null;
        String expectedResult = 'null';
        
        Test.startTest();
        // Execute method under test
        String actualResult = MyPoorClass.riskyMethod(inputString);
        Test.stopTest();
        
        // Verify results
        System.assertEquals(expectedResult, actualResult, 'The method should return "null" when input is null');
    }
    
    // Test method for edge case with empty string
    @isTest
    static void testRiskyMethod_WithEmptyString() {
        // Setup test data
        String inputString = '';
        String expectedResult = '!';
        
        Test.startTest();
        // Execute method under test
        String actualResult = MyPoorClass.riskyMethod(inputString);
        Test.stopTest();
        
        // Verify results
        System.assertEquals(expectedResult, actualResult, 'The method should append an exclamation mark to empty string');
    }
    
    // Test method for edge case with string containing only whitespace
    @isTest
    static void testRiskyMethod_WithWhitespaceString() {
        // Setup test data
        String inputString = '   ';
        String expectedResult = '   !';
        
        Test.startTest();
        // Execute method under test
        String actualResult = MyPoorClass.riskyMethod(inputString);
        Test.stopTest();
        
        // Verify results
        System.assertEquals(expectedResult, actualResult, 'The method should append an exclamation mark to whitespace string');
    }
    
    // Test method for typical use case with alphanumeric string
    @isTest
    static void testRiskyMethod_WithAlphanumericString() {
        // Setup test data
        String inputString = 'Test123';
        String expectedResult = 'Test123!';
        
        Test.startTest();
        // Execute method under test
        String actualResult = MyPoorClass.riskyMethod(inputString);
        Test.stopTest();
        
        // Verify results
        System.assertEquals(expectedResult, actualResult, 'The method should append an exclamation mark to alphanumeric string');
    }
}
