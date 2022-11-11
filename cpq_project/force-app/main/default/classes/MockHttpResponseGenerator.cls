@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('POST', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"@odata.context":"http://salesforce.grouphaelterman.be:12348/HLT_BC20_CU0_TEST_NU/ODataV4/$metadata#Edm.String","value":"transactionNo: 1660"}');
        res.setStatusCode(200);
        return res;
    }
    
     public static void setupResponseMock(String resourseName,Integer statusCode){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource(resourseName);
        mock.setStatusCode(statusCode);
        mock.setHeader('Content-Type', 'application/json');
        mock.setHeader('Accept', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);
    }
}