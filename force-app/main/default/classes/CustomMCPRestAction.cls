@RestResource(urlMapping='/v1/CustomMCPRestAction/*')
global with sharing class CustomMCPRestAction {

    global class RequestWrapper {
        public String accountName;
        public String phone;
    }

    global class ResponseWrapper {
        public String accountId;
        public String status;
    }

    @HttpPost
    global static ResponseWrapper createAccount(RequestWrapper req) {
        Account acc = new Account(
            Name = req.accountName,
            Phone = req.phone
        );
        insert acc;
        
        ResponseWrapper res = new ResponseWrapper();
        res.accountId = acc.Id;
        res.status = 'Success';
        return res;
    }
}