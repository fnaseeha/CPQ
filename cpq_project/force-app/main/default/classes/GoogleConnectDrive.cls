public class GoogleConnectDrive {

    private string key = '197334734975-bh20jru8e874hae2r2mm2rog6o76q9qq.apps.googleusercontent.com';
 
 	private string secret = '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';
 
 	private string refresh_token = '1//04hobcZHZH64sCgYIARAAGAQSNwF-L9IrmiMchXkGDzuiyja5m0B1GjP8-_XQ63hPy4tiCjzwE-0-88xhXXit-_C3hA4r7i-GNuk';
 
 	private string refreshToken;
 
 	private String accesstoken;
 
 	private Integer expiresIn;
 
 	private String tokentype;
 
 	public GoogleConnectDrive() {
 
 		AccessToken();
 
 	}
    
    public void AccessToken() {
 
 		//Getting access token from google
 
 		HttpRequest req = new HttpRequest();
 
 		req.setMethod('POST');
 
 		req.setEndpoint('https://accounts.google.com/o/oauth2/token');
 
 		req.setHeader('content-type', 'application/x-www-form-urlencoded');
 
 		String messageBody = 'client_secret=' + secret + '&grant_type=refresh_token' + '&refresh_token=' + refresh_token + '&client_id=' + key;
 
 		System.debug('messageBody===>' + messageBody);
 
 		req.setHeader('Content-length', String.valueOf(messageBody.length()));
 
 		req.setBody(messageBody);
 
 		req.setTimeout(60 * 1000);
 
 		Http h = new Http();
 
 		HttpResponse res = h.send(req);
 
 		String resp = res.getBody();
 
 		System.debug('resp=====>' + resp);
 
 		JSONParser parser = JSON.createParser(resp);
 
 		while (parser.nextToken() != null) {
 
 			if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)) {
 
 				String fieldName = parser.getText();
 
 				parser.nextToken();
 
 				if (fieldName == 'access_token') {
 
 					accesstoken = parser.getText();
 
 				} else if (fieldName == 'expires_in') {
 
 					expiresIn = parser.getIntegerValue();
 
 				} else if (fieldname == 'token_type') {
 
 					tokentype = parser.getText();
 
 				}
 
 			}
 
 		}
 
 		System.debug('accesstoken162==>' + accesstoken);
 
 		System.debug(' You can parse the response to get the access token ::: ' + resp);
 
 	}
    
    public void uploadFileToDrive(Blob blobBody,String fileName){
 
 		try
 
 		{
 				/*String reportId = (String) reportList.get(0).get('Id');
 
 				string reportName = (String) reportList.get(0).get('Name');
 
 				string url = '/' + reportId + '?csv=1&isdtp=p1';
 
 				System.debug('url-->' + url);
 
 				ApexPages.PageReference objPage = new ApexPages.PageReference(url);*/
 
 				blob urlStor = blobBody;
 
 				System.debug('urlStor--->' + urlStor);
 
 				String boundary = 'SalesforceNewsTechnologyStuff9889464542212';
 
 				String delimiter = '\r\n--' + boundary + '\r\n';
 
 				String close_delim = '\r\n--' + boundary + '--';
 
 				String bodyEncoded = EncodingUtil.base64Encode(urlStor);
 
 				System.debug('bodyEncoded--->' + bodyEncoded);
 
 				String folderId = '1l0R5tnmoXYmO7cqWR3odnNq_9ZOuGTDh';
 
 				//String driveId = '1DVRPlthRkYBeGAGGPt-TW_tVrEpa_A9x';
 
 				String body = delimiter + 'Content-Type: application/json\r\n\r\n' + '{ "name" : "' + fileName +  '",' + ' "mimeType" : "application/pdf",' +
                    
                    '"\n  "parents":[\n	"' + folderId + '"\n	]}' +
 
 				//	'"teamDriveId": "' + driveId + '",\n  "driveId": "' + driveId + '",\n  "parents":[\n	"' + folderId + '"\n	]}' +
 
 					delimiter + 'Content-Type: text/application/vnd.ms-excel' + '\r\n' + 'Content-Transfer-Encoding: base64\r\n' + '\r\n'
 
 					+
 					bodyEncoded + close_delim;
 
 				String endpoint = 'https://www.googleapis.com/upload/drive/v3/files?&uploadType=multipart';
 								//https://www.googleapis.com/upload/drive/v3/files?uploadType=resumable&upload_id=xa298sd_sdlkj2
 				system.debug('endpoint==>' + endpoint);
 
 				System.debug('body--->' + body);
 
 				System.debug('body--->' + JSON.serializePretty(body));
 
 				System.debug('accesstoken466==>' + accesstoken);
 
 				Http http = new Http();
 
 				HttpRequest req = new HttpRequest();
 
 				req.setEndpoint(endpoint);
 
 				req.setHeader('Authorization', 'Bearer ' + accesstoken);
 
 				req.setHeader('Content-Type', 'multipart/mixed; boundary="' + boundary + '"');
 
 				req.setHeader('Content-length', String.valueOf(body.length()));
 
 				req.setBody(body);
 
 				req.setMethod('POST');
 
 				req.setTimeout(60 * 1000);
 
 				HttpResponse resp = http.send(req);
 
 				system.debug('reqreqreqreqreq' + req);
 
 				String resp2 = resp.getBody();
 
 				System.debug('resp2==>' + resp2);
 
 
 		} catch (Exception ex)
 
 		{
 
 			system.debug(ex.getMessage());
 
 		}
 
 	}
}