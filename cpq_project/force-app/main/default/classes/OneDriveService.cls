public class OneDriveService {
    private string clientId {get;set;}
    private string clientSecret {get;set;}
    private string scope {get;set;}
    private string grantType{get;set;}
    private string tokenUrl{get;set;}
    private string redirectUrl  {get;set;}
    private string graphUrl{get;set;}
  //  private string authUrl{get;set;}
    private string adminConsentUrl{get;set;}
    
    private static One_Drive_Auth_Setting__mdt setting;
    
    public OneDriveService()
    {
        if(setting==null)
        {
            //Games__mdt mc = Games__mdt.getInstance('m00000000000001');

            setting=One_Drive_Auth_Setting__mdt.getInstance('OneDriveService');
            System.debug('* setting '+setting);
        }
        if(setting!=null)
        {
            clientId=setting.Client_Id__c;
            clientSecret=setting.Client_Secret__c;
            scope=setting.Scope__c;
            grantType=setting.Auth_Grant_Type__c;
            redirectUrl=setting.Redirect_Url__c;
          //  authUrl=setting.Authorization_Endpoint__c.replace('{tenant}', setting.TenantId__c); 
            tokenUrl=setting.Token_Url__c; 
        }
    }
    
    //use when Admin Consent required using Salesforce App
    public String createAuthURL() {
        String key = EncodingUtil.urlEncode(clientId,'UTF-8');
        String authuri = '';
        authuri = adminConsentUrl+'?'+
            'client_id='+key+
            '&redirect_uri='+redirectUrl+
            '&state=12345';
        return authuri;
    }
    
    
    //Content Type based on Content Version
    public static string ContentType(string fileType)
    {
        switch on fileType.toLowerCase()
        {
            when 'docx'
            {
                return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
            }
            when 'csv'
            {
                return 'application/vnd.ms-excel';
            }
            when 'wav'
            {
                return 'audio/wav';
            }
            when 'wmv'
            {
                return 'video/x-ms-wmv';
            }
            when 'mp3'
            {
                return 'audio/mpeg';
            }
            when 'mp4'
            {
                return 'video/mp4';
            }
            when 'png'
            {
                return 'image/png';
                
            }
            when 'pdf'
            {
                return 'application/pdf';
                
            }
            when 'txt'
            {
                return 'text/plain';
                
            }
            when else {
                return 'image/jpeg';
            }
        }
    }
    
    //Upload Documents of passed record id
    public void UploadDocuments(Blob recordData,String title)
    {
        //string accessToken='EwB4A8l6BAAUkj1NuJYtTVha+Mogk+HEiPbQo04AAS2uvY/PypeacSLy4QMhrJZrh2CZSTv+U4H/F7Fv42jEjxz5tUMq2iRDOOIJtPBcBYYW4U3uQS+grFpj/ohtE6OSK3WrBSi+D7RLrQyeYcE0yLLeXTzgHNUofWi7UV2t4PNHCxgI33zQQOVZ+R8APHJlM1aUwCnm89tR33fb5OuqGjJ6qZW2gVhx+arWf7cOm+DgL6AON6LZab6SID7FctbrYh8ntnLM4Smt9gntNcSEP8T6M83lVqaCPCSKaDWGcuPlqLb0g2uhmNHvj+mQENcmBQphWuHfuLVhewhhVDdpc7ut5Ve+r1ThOQm1H8uU8CkZtxuBSo3COHpZJjHxLVUDZgAACJmH6wLestjNSALN6xUQ/0CAg0i65Z82ItxjZ79uyYnKZDofMlTO5IAy5rQCE7ILCJSY01y8EZ9z5o0mpdfuk10gTP1/J/uqhEatPh1Y2ouBobvlAxDsjwW3gxLZAfETQNH9HD25LtzeUXjh74mxkkUEqc1nDxm4zR18C8loObL1QnTmdXwZqFhOB+w5Cz/CEkel6p24yYEagf06t1CfuizxTNP66FDhPGN4OBjOMlXTp5V3uVBqwDmodEE0ER2J/0wzHCVVaTkgRf9PApI/LeYCpVBTH7tBJuq0uJ+56UjCFv2e4uxvuUFFDmTHQ0dUf7RhTJgPlgQvRojC3L93+KvC3LIHsd8wyuCm/JBb3xQ3G79HuCQXcIBmkS+xBviQKuGtbtwB/stilRuRav1VkmewV6sA5Fyw5OQR87uqQsdLKRTVRgWSVNXzO66LYtenHlJXp8GDH+uofYb0M/3zCAiaCI3aY58hWS2NYA+wBSHQwN57BH6xjuGOWqd8nh5L6MF+Or4tzU5ESyRlkNATqpi0vZQNCOfS43YPknbp0/FxTD4O0x2Ic59PNNtqafIaOpZ01loOuqyCI5LTdGm05Zxz7dnnjvCOJO388bWlAp2m/6o0y6VxYph7oFlG1jiA17MOOBI4Vy94YNeW6K8vNBq6gmqbcnRNdPYwCMV93coOuTsuvgupi9BbAWg43ZFgUfRcgIMbHdLLHg/kFoAq0f6c6wklwmBFZVq+T/qym2lJccOBQhShZihd9NfboGg2szguOx45BpabUxkutnBZIiZBxoQC';//getmyAccessToken();
          string accessToken=getmyAccessToken();
        if(string.isBlank(accessToken))
        {
           // throw new BaseException('Issue in Authentication');
            System.debug('Issue in Authentication');
        }//ContentDocumentId or LinkedEntityId using ContentVersionDocumentId
       /* List<ContentDocumentLink> links=[SELECT ContentDocumentId,LinkedEntityId FROM ContentDocumentLink where LinkedEntityId=:recordId];
        Set<Id> ids=new Set<Id>();
        for(ContentDocumentLink link:links)
        {
            ids.add(link.ContentDocumentId);
        }*/
      //  List<ContentVersion> versions=[SELECT VersionData,Title,ContentDocumentId,FileExtension FROM ContentVersion WHERE ContentDocumentId = :recordId AND IsLatest = true];
        
      //  for(ContentVersion attach:versions)
     //   {
            try
            {
                //string accessToken,blob versionData,string title,string extn
                uploadFile(accessToken, recordData, title, 'pdf');
            }
            catch(Exception ex)
            {
                System.debug('ex : '+ex.getMessage());
          //      throw new BaseException(ex);
            }
      //  }
    }
    
     //Get access Token
    public string getmyAccessToken()
    {
         String code = 'M.R3_BAY.3c6c8e88-7d24-4f33-4fa7-6c7534de8ad6';
        
        clientId = '58cbe7f8-9aff-42c1-94b0-1ff8dd72b345';
        tokenUrl = 'https://login.microsoftonline.com/common/oauth2/v2.0/token';
        redirectUrl = 'https://pr1652113784409.my.salesforce.com';
       
        clientSecret = 'V3s8Q~.mgnkmnsF.sdgbMcbuYc5VFc~GMNSFsbsD';
        
        
        String key = EncodingUtil.urlEncode(clientId,'UTF-8');
        String secret = EncodingUtil.urlEncode(clientSecret,'UTF-8');
        //Getting access token from google
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');//files.readwrite.all
        req.setEndpoint(tokenUrl);
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        System.debug('key '+key);
        System.debug('secret '+secret);
        String messageBody='client_id='+key+
            '&scope=files.readwrite.all'+
            '&client_secret='+secret+
            '&redirect_uri='+redirectUrl+
            '&code='+code+
            '&grant_type=authorization_code';        
        
        req.setHeader('Content-length', String.valueOf(messageBody.length()));
        req.setBody(messageBody);
        req.setTimeout(60*1000);
        
        Http callout = new Http();
        String responseText;
        HttpResponse response = callout.send(req);
        
        system.debug('response:' + response.getBody());
        if(response.getStatusCode()==200)
        {            
            responseText = response.getBody();
            Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(responseText) ;  
            string token=String.valueOf(responseMap.get('access_token'));
            system.debug('responseMap:' + responseMap);
            return token;
        }
        return '';
    }
    
    //Get access Token
    public string getAccessToken()
    {
        String key = EncodingUtil.urlEncode(clientId,'UTF-8');
        String secret = EncodingUtil.urlEncode(clientSecret,'UTF-8');
        //Getting access token from google
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');//files.readwrite.all
        req.setEndpoint(tokenUrl);
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        System.debug('key '+key);
        System.debug('secret '+secret);
        String messageBody='client_id='+key+
            '&scope=https://graph.microsoft.com/.default'+
            '&client_secret='+secret+
            '&redirect_uri='+redirectUrl+
            '&grant_type=client_credentials';        
        
        req.setHeader('Content-length', String.valueOf(messageBody.length()));
        req.setBody(messageBody);
        req.setTimeout(60*1000);
        
        Http callout = new Http();
        String responseText;
        HttpResponse response = callout.send(req);
        
        system.debug('response:' + response.getBody());
        if(response.getStatusCode()==200)
        {            
            responseText = response.getBody();
            Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(responseText) ;  
            string token=String.valueOf(responseMap.get('access_token'));
            system.debug('responseMap:' + responseMap);
            return token;
        }
        return '';
    }
    
   	//@Future(callout=true)
    public static void uploadFile(string accessToken,blob versionData,string title,string extn){
        //File Content
        String attachmentBody = EncodingUtil.base64Encode(versionData);
        
        String filename = title;
        string contentType=ContentType(extn);
        
        string file=EncodingUtil.URLENCODE(filename,'UTF-8').replace('+', '%20');
       
        string endpointUrl='https://graph.microsoft.com/v1.0/users/58cbe7f8-9aff-42c1-94b0-1ff8dd72b345/drive/root:/{file}:/content';
        
        endpointUrl=endpointUrl.replace('{file}',file+'.'+extn);
        System.debug(versionData);
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpointUrl);
        req.setMethod('PUT'); 
        req.setHeader('Authorization','Bearer ' + accessToken);
        req.setHeader('Content-Encoding', 'UTF-8');
        req.setHeader('Content-type', contentType);
        req.setHeader('accept', 'application/json');
        Http http = new Http();
        system.debug('getBody1 '+req);
        req.setBodyAsBlob(versionData);
        req.setTimeout(120000);
        
        HTTPResponse res = http.send(req);
        system.debug('getBody2 '+res.getBody());
        
        if(res.getStatusCode()==200)
        {
            system.debug('getBody '+res.getBody());
        }else{
            System.debug('re '+res.getStatus());
        }
        System.debug('response '+res);
    }   
}