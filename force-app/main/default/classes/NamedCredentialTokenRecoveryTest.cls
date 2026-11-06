public with sharing class NamedCredentialTokenRecoveryTest {

    private static final String NAMED_PRINCIPAL_CREDENTIAL =
        'callout:Sandbox_Test_Named_Principal';

    private static final String PER_USER_CREDENTIAL =
        'callout:Sandbox_Test_Per_User';

    public static HttpRequest createNamedPrincipalRequest() {
        HttpRequest request = new HttpRequest();

        request.setEndpoint(
            NAMED_PRINCIPAL_CREDENTIAL + '/api/test'
        );
        request.setMethod('GET');

        return request;
    }

    public static HttpRequest createPerUserRequest() {
        HttpRequest request = new HttpRequest();

        request.setEndpoint(
            PER_USER_CREDENTIAL + '/api/user/test'
        );
        request.setMethod('GET');

        return request;
    }
}