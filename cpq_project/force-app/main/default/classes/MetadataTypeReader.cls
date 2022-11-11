public class MetadataTypeReader {
	public static One_Drive_Auth_Setting__mdt OneDriveSetting {
         get {
             return  One_Drive_Auth_Setting__mdt.getInstance('OneDriveService');
          }
   	}
    
    public static String getQuoteTemplateId(String instanceName) {
          QuoteTemplate__mdt mtData = QuoteTemplate__mdt.getInstance(instanceName);
          return mtData.QuoteTemplateId__c;
   	}
}