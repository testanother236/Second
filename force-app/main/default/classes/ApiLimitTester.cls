public class ApiLimitTester {
    public static void simulateApiCalls(Integer numberOfCalls) {
        // Ensure Remote Site Settings are configured for the target URL
        String url = 'https://webhook.site/f812be3d-abdc-4ec2-9aac-dbb9cef74644';
        for (Integer i = 0; i < numberOfCalls; i++) {
            try {
                Http http = new Http();
                HttpRequest request = new HttpRequest();
                request.setEndpoint(url);
                request.setMethod('GET');
                HttpResponse response = http.send(request);
                System.debug('Response Status: ' + response.getStatusCode());
            } catch (Exception e) {
                System.debug('Error during HTTP callout: ' + e.getMessage());
            }
        }
    }
}