public class ConnectDrive {
    
    private string clientId {get;set;}
    private string clientSecret {get;set;}
    private string scope {get;set;}
    private string grantType{get;set;}
    private string tokenUrl{get;set;}
    private string redirectUrl  {get;set;}
    private string userName  {get;set;}
    private string sharedDriveId  {get;set;}
    
    private static One_Drive_Auth_Setting__mdt setting;
    
    public ConnectDrive()
    {
        if(setting==null)
        {
            setting= MetadataTypeReader.OneDriveSetting;
        }
        if(setting!=null)
        {
            clientId=setting.Client_Id__c;
            clientSecret=setting.Client_Secret__c;
            scope=setting.Scope__c;
            grantType=setting.Auth_Grant_Type__c;
            redirectUrl=setting.Redirect_Url__c;
            tokenUrl=setting.Token_Url__c; 
            userName = setting.userName__c;
            sharedDriveId = setting.SharedDriveId__c;
        }
    }
    
     /****get accesstoken to authorize Drive using the Azure_Active_Directory*****/
    public String getAccessToken(){
        try{
          
            String accessToken = '';
            HttpRequest httpRequestObject = new HttpRequest();
            httpRequestObject.setmethod('POST');
            httpRequestObject.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            httpRequestObject.setEndPoint(tokenUrl);
            
            String body = 'grant_type='+grantType+
            '&client_id='+ Encodingutil.urlencode(clientId, 'UTF-8')+
            '&client_secret='+ Encodingutil.urlencode(clientSecret, 'UTF-8')+   
            '&redirect_uri='+ redirectUrl+
            '&response_mode=fragment'+
            '&scope='+scope;
         
            System.debug('* body '+body);
            httpRequestObject.setBody(body);
            Http http = new Http();
            HttpResponse httpResponse ;
    
            httpResponse = http.send(httpRequestObject);
            System.debug(' * httpResponse '+httpResponse.getBody());
            if(httpResponse != null && httpResponse.getStatus() == 'OK' && httpResponse.getStatusCode() == 200) {
                Map<String,Object> resMap =  (Map<String,Object>)JSON.deserializeUntyped(httpResponse.getBody());
                 System.debug(' * resMap '+resMap);
                accessToken = String.valueOf(resMap.get('access_token'));
                 System.debug(' * accessToken '+accessToken);
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
    
    public Map<String,Object> uploadFileToDrive(Blob blobBody,String fileName){
      
        String filePath = 'Mobio Team Folder/Mobio/Invoices/'+system.today().year()+' invoices';
        
        String endPoint = 'https://graph.microsoft.com/v1.0/drives/'+sharedDriveId+'/items/root:/'+filePath.replace(' ', '%20')+'/'+fileName+':/content';
   
        System.debug('* endPoint '+endPoint);
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
                    
                     System.debug('* httpResponse : '+httpResponse);
                     System.debug('* body : '+httpResponse.getBody());
                    
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