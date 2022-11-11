public class ConnectDriveV0 {
    
     /****get accesstoken to authorize Drive using the Azure_Active_Directory*****/
    public static String getAccessToken(){
        try{
          
            String grant_type = 'client_credentials';
            String client_id = '640a551a-2ae8-465d-86c4-f1348a26e38e';
            String client_secret = 'gqQ8Q~TWQifqSH.SJj3G4g-6H.SuddR2ViJOadfp';
            String redirect_uri = 'https://login.microsoftonline.com/common/oauth2/nativeclient';//'https://login.salesforce.com';
            //https://login.microsoftonline.com/common/oauth2/nativeclient
            String response_mode = 'fragment';
            String scope = 'https://graph.microsoft.com/.default';
            
            String accessToken = '';
            HttpRequest httpRequestObject = new HttpRequest();
            httpRequestObject.setmethod('POST');
            httpRequestObject.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            httpRequestObject.setEndPoint('https://login.microsoftonline.com/eed52b8a-0276-4b97-ba34-570af181b3d6/oauth2/v2.0/token');
            
            String body = 'grant_type='+grant_type+
            '&client_id='+ Encodingutil.urlencode(client_id, 'UTF-8')+
            '&client_secret='+ Encodingutil.urlencode(client_secret, 'UTF-8')+   
            '&redirect_uri='+ redirect_uri+
            '&response_mode=fragment'+
            '&scope='+scope;
         
            httpRequestObject.setBody(body);
            Http http = new Http();
            HttpResponse httpResponse ;
    
            httpResponse = http.send(httpRequestObject);
            
            if(httpResponse != null && httpResponse.getStatus() == 'OK' && httpResponse.getStatusCode() == 200) {
                Map<String,Object> resMap =  (Map<String,Object>)JSON.deserializeUntyped(httpResponse.getBody());
                accessToken = String.valueOf(resMap.get('access_token'));
                return accessToken;
            }else if(httpResponse != null) {
                System.debug('Server Error: Status '+ httpResponse.getStatus()+' Status Code '+ httpResponse.getStatusCode() +' Body '+httpResponse.getBody());
                return null;
            }
        }catch(CalloutException ce) {
             throw ce;
        } catch(Exception ex) {
            throw ex;
        }
        return null;
    }
    
     /****get accesstoken to authorize Drive using the Azure_Active_Directory*****/
    public static String getAccessToken1(){
        try{
          
            String code = '0.ARAAiivV7nYCl0u6NFcK8YGz1hpVCmToKl1GhsTxNIom444QAOE.AgABAAIAAAD--DLA3VO7QrddgJg7WevrAgDs_wQA9P-M9gpYWdLqeKbK8PVBPxVsbRWjJfg24DxESk4u7ztRfcytL3RqCF1Mg77MmLlYcjPWTc-gDMNf1P68Al6bTi1ijGmVfnqyMhMR_x6pU4U3VS3_svgO6eyBKqgjyomweBhYAQuBBvgT2dqfAc3BrGES96WohFfyoSfSS-UdRqi_trJeaJ9FdI8BgHJkTft_R5Hpn0MBHY6qMSnlNF-E_3jTGYeWtalamT-hZo5n24bVqJXIkq22zUUI31FRHhkTZu1u4QQYnZka8Et0xGRSOizBgUNp9SCUwfhoj6Cr8AazVhgqPrqsO-jQzic5ZGOoPU3QRdzyz2rLXtsxCuWfsa4mQHGLIfecYsnvSO-_FCaOoAskTaXXT6qoFX_wqlXuT2nFzhEb5da_57LXZ4NBujMZTxqdyeQWgTsGOuDENhc2e4Y5tRTWWKFFbC2Jv2OPSwR-8NTByfkAG00TTq95a5sjw8VuL7O1ZiC7xuaawp-dYIj6V0-UU-OeU4alA1nlw0q-oy52BGMaFCrVR5bwEaVvL6p_4SJcrBpoEULS30pnbAW6M4aLYRpVC10utORoLlVehky4mRddjX-PL8Yf-6ptMFT-2wWwv0IkRIcC22hET2eA4iWHaNJpyR2lWzwTuP9kZA';
            String grant_type = 'authorization_code';
            String client_id = '640a551a-2ae8-465d-86c4-f1348a26e38e';
            String client_secret = 'gqQ8Q~TWQifqSH.SJj3G4g-6H.SuddR2ViJOadfp';
            String redirect_uri = 'https://mobio--partial.sandbox.my.salesforce.com';
            String response_mode = 'fragment';
            String scope = 'files.readwrite.all';
            
            String accessToken = '';
            HttpRequest httpRequestObject = new HttpRequest();
            httpRequestObject.setmethod('POST');
            httpRequestObject.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            httpRequestObject.setEndPoint('https://login.microsoftonline.com/common/oauth2/v2.0/token');
            
            String body = 'grant_type='+grant_type+
            '&client_id='+ Encodingutil.urlencode(client_id, 'UTF-8')+
            '&client_secret='+ Encodingutil.urlencode(client_secret, 'UTF-8')+   
            '&redirect_uri='+ redirect_uri+
            '&response_mode=fragment'+
            '&scope='+scope+
            '&code='+code;

            /*client_id={client_id}&redirect_uri={redirect_uri}&client_secret={client_secret}
&code={code}&grant_type=authorization_code*/
            
            /*eyJ0eXAiOiJKV1QiLCJub25jZSI6ImplR1loOWZ5b3NFLXFiR3AzM0x0cWFvMmZRU1JQRkIya0FjUFlDX2JrcFUiLCJhbGciOiJSUzI1NiIsIng1dCI6IjJaUXBKM1VwYmpBWVhZR2FYRUpsOGxWMFRPSSIsImtpZCI6IjJaUXBKM1VwYmpBWVhZR2FYRUpsOGxWMFRPSSJ9.eyJhdWQiOiIwMDAwMDAwMy0wMDAwLTAwMDAtYzAwMC0wMDAwMDAwMDAwMDAiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC9lZWQ1MmI4YS0wMjc2LTRiOTctYmEzNC01NzBhZjE4MWIzZDYvIiwiaWF0IjoxNjYzOTE1ODg5LCJuYmYiOjE2NjM5MTU4ODksImV4cCI6MTY2MzkyMTIwNSwiYWNjdCI6MCwiYWNyIjoiMSIsImFjcnMiOlsidXJuOnVzZXI6cmVnaXN0ZXJzZWN1cml0eWluZm8iXSwiYWlvIjoiQVNRQTIvOFRBQUFBRWZqaWpqblQyS2VaVE5OSkY3c3NhV28vTW5pcnZYaHl3YXVKUDhETVlhMD0iLCJhbXIiOlsicHdkIl0sImFwcF9kaXNwbGF5bmFtZSI6Imludm9pY2VBcHAiLCJhcHBpZCI6IjY0MGE1NTFhLTJhZTgtNDY1ZC04NmM0LWYxMzQ4YTI2ZTM4ZSIsImFwcGlkYWNyIjoiMCIsImlkdHlwIjoidXNlciIsImlwYWRkciI6IjIwMy45NC43NC40MiIsIm5hbWUiOiJTYWxlc2ZvcmNlIiwib2lkIjoiNWQyZTE3OGItYWZmNy00NDhjLTk2MTctNGFjNTczYmVjYTY0IiwicGxhdGYiOiIzIiwicHVpZCI6IjEwMDMyMDAyMzM1RUI2OUIiLCJyaCI6IjAuQVJBQWlpdlY3bllDbDB1Nk5GY0s4WUd6MWdNQUFBQUFBQUFBd0FBQUFBQUFBQUFRQU9FLiIsInNjcCI6IkZpbGVzLlJlYWRXcml0ZS5BbGwgcHJvZmlsZSBvcGVuaWQgZW1haWwiLCJzdWIiOiJCYkx0Y0FnVVlQMlM4S0ltMnUzRnhJZWk1SlRLa093TGptb05UZU1oR0E4IiwidGVuYW50X3JlZ2lvbl9zY29wZSI6IkVVIiwidGlkIjoiZWVkNTJiOGEtMDI3Ni00Yjk3LWJhMzQtNTcwYWYxODFiM2Q2IiwidW5pcXVlX25hbWUiOiJzYWxlc2ZvcmNlQG1vYmlvLmJlIiwidXBuIjoic2FsZXNmb3JjZUBtb2Jpby5iZSIsInV0aSI6IlR2YWlnNklPYlV5elVfenFWM0lHQUEiLCJ2ZXIiOiIxLjAiLCJ4bXNfc3QiOnsic3ViIjoiQ0dhNDBWaXF0RmJqcHJEYXJYS3BGdmpDaXBGbWxfUjdyVEs5UFh3eC1SUSJ9LCJ4bXNfdGNkdCI6MTQ0MjkzMTkwOSwieG1zX3RkYnIiOiJFVSJ9.i3G92OtXzgzoZNyaXW6ozcACduJ6SLHGzEZg4EUd2jcsR9VLo1HpGts23ern3d5qEN-ChYTG2D-s2bquNI5LxKnQ4UCq5sA6DZjYxTsNnlCCVDNJfoWDpSsS4suYaBZUvmcdHrrcOMMWPquxn_8WWx86tHwjn8C8jfEJFHp8ph6Fqpw2TftH3lPdCHY5LyoIq6HWPcxWOjfDZq0TgWW1WbsDR4UeiDDqYErD9lPQA_d5kdr4ilNeQJYpv602vVbLZamyXnAk9n3frdFLkXrPK7FE3Yc8J8BJ29UW5ZM7p8noRsdVOX3cKO7dfdlyfJhc0E6c3o8NEP-Jlg-ahP3aqw*/
            httpRequestObject.setBody(body);
            Http http = new Http();
            HttpResponse httpResponse ;
    
            httpResponse = http.send(httpRequestObject);
            
            if(httpResponse != null && httpResponse.getStatus() == 'OK' && httpResponse.getStatusCode() == 200) {
                Map<String,Object> resMap =  (Map<String,Object>)JSON.deserializeUntyped(httpResponse.getBody());
                System.debug(' * refresh_token  : '+resMap.get('refresh_token'));
                accessToken = String.valueOf(resMap.get('access_token'));
                return accessToken;
            }else if(httpResponse != null) {
                System.debug('Server Error: Status '+ httpResponse.getStatus()+' Status Code '+ httpResponse.getStatusCode() +' Body '+httpResponse.getBody());
                return null;
            }
        }catch(CalloutException ce) {
             throw ce;
        } catch(Exception ex) {
            throw ex;
        }
        return null;
    }
    
    public static Map<String,Object> uploadFileToDrive(Blob blobBody,String fileName){
       
        String clientId = '58cbe7f8-9aff-42c1-94b0-1ff8dd72b345';
        String endPoint = 'https://graph.microsoft.com/v1.0/users/'+clientId+'/drive/items/root:/'+fileName+':/content';
        String accessToken = getAccessToken();
        try {
            HttpRequest httpRequestObject = new HttpRequest();
            httpRequestObject.setmethod('PUT');
            httpRequestObject.setEndPoint(endPoint);
            httpRequestObject.setHeader('Authorization', 'Bearer '+accessToken);
            httpRequestObject.setHeader('Content-Type', 'application/json');
            httpRequestObject.setHeader('Accept', 'application/json');
            if(blobBody != null){
                httpRequestObject.setBodyAsBlob(blobBody);
            }
          
            Http http = new Http();
            HttpResponse httpResponse;
            httpResponse = http.send(httpRequestObject);
			System.debug('httpResponse');
            System.debug(httpResponse);
            if(httpResponse != null && (httpResponse.getStatus() == 'Created' || httpResponse.getStatus() == 'OK')) {
                Map<String,Object> resMap =  (Map<String,Object>)JSON.deserializeUntyped(httpResponse.getBody());
                System.debug('resMap###' + resMap);
                return resMap;
            }else{
                System.debug('FAILED###' + httpResponse.getStatus() + httpResponse.getBody());
                return null;
            }
            
        }catch (Exception e) {
            System.debug('Exception###' + e.getLineNumber() + e.getMessage());
            return null;
        }
    }
    
     public Map<String,Object> uploadFileToDriveSharedDrive(Blob blobBody,String fileName){
      //sharedDriveId : get from https://graph.microsoft.com/v1.0/users/salesforce@mobio.be/drive/sharedWithMe?allowexternal=true?
        String filePath = 'Mobio Team Folder/Mobio/Invoices/'+system.today().year()+' invoices';
         
        String sharedDriveId = 'b!1xXAgAPLj0OWjK2SVk4sPmmJzr_hs45IvkNlF9xcX7vGzsgVQtQ6RphWmXYCXfxu';
         
        String endPoint = 'https://graph.microsoft.com/v1.0/drives/'+sharedDriveId+'/items/root:/'+filePath.replace(' ', '%20')+'/'+fileName+':/content';
   
        String accessToken = getAccessToken();
        if(accessToken != null){
            try {
                HttpRequest httpRequestObject = new HttpRequest();
                httpRequestObject.setmethod('PUT');
                httpRequestObject.setEndPoint(endPoint);
                httpRequestObject.setHeader('Authorization', 'Bearer '+accessToken);
                httpRequestObject.setHeader('Content-Type', 'application/json');
                httpRequestObject.setHeader('Accept', 'application/json');
                if(blobBody != null){
                    httpRequestObject.setBodyAsBlob(blobBody);
                }
              
                Http http = new Http();
                HttpResponse httpResponse;
                httpResponse = http.send(httpRequestObject);
                
                if(httpResponse != null && (httpResponse.getStatus() == 'Created' || httpResponse.getStatus() == 'OK')) {
                    Map<String,Object> resMap =  (Map<String,Object>)JSON.deserializeUntyped(httpResponse.getBody());
                    System.debug('resMap###' + resMap);
                    return resMap;
                }else{
                    System.debug('FAILED###' + httpResponse.getStatus() + httpResponse.getBody());
                    return null;
                }
                
            }catch (Exception e) {
                System.debug('Exception###' + e.getLineNumber() + e.getMessage());
                return null;
            }
        }else{
             System.debug('Exception### Access Token is null' );
            return null;
        }
        
    }

}