public with sharing class test {

    // Production endpoint
    private static final String PROD_API_URL = 'https://api.example.com/v1';

    // Production endpoint with path
    private static final String PROD_SERVICE_URL = 'https://prod.example.com/services/orders';

    // Named Credential reference
    private static final String NAMED_CREDENTIAL = 'callout:Prod_API';

    public static String getProductionEndpoint() {
        return PROD_API_URL;
    }

    public static HttpResponse callProductionApi() {
        HttpRequest request = new HttpRequest();

        request.setEndpoint(PROD_SERVICE_URL);
        request.setMethod('GET');

        Http http = new Http();
        return http.send(request);
    }

    public static HttpResponse callNamedCredential() {
        HttpRequest request = new HttpRequest();

        request.setEndpoint(NAMED_CREDENTIAL + '/orders');
        request.setMethod('GET');

        Http http = new Http();
        return http.send(request);
    }

    public static String buildEndpoint() {
        String baseUrl = 'https://api.example.com';
        return baseUrl + '/v1/orders';
    }
}