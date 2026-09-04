@IsTest
private class QD_LowCoverage_Test {
    @IsTest
    static void testRiskyDivideNonZero() {
        System.assertEquals(2, QD_LowCoverage.riskyDivide(4, 2));
    }
    // No test1 for divide by zero branch → ensures coverage stays <75%
}