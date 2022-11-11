public class InvoiceProcess {
    
  @InvocableMethod   
    public static void uploadQuoteDocumentToDrive(List<Id> quoteIds)  
    { 
        uploadQuoteDocument(quoteIds);
    }
    
    @future(callout=true)
    public static void uploadQuoteDocument (List<Id> quoteIds) {
       
        try{
            String quoteId = quoteIds.get(0);
            
            //get latest invoice Number
            Integer latestInvoiceNumber = InvoiceProcessHelper.getLatestInvoiceNumber();
          
            Quote currentQuote = [SELECT  Id,Contact.Language__c,Account__c,OpportunityId,Factuur_nr__c FROM Quote where id=:quoteId];
           
            //Get the Quote Template Id from Based on contact's language
            String quoteTemplateId =  InvoiceProcessHelper.getQuoteTemplateId(currentQuote.Contact.Language__c);
            
            //get the quotePdfBlob
            Blob quoteBlob =  InvoiceProcessHelper.generateQuoteBlob(quoteId, quoteTemplateId);
           
            //initialze the QuoteDocument to hold the quote pdf for insertion
            QuoteDocument quoteDoc = new QuoteDocument();
            quoteDoc.Document = quoteBlob;
            quoteDoc.QuoteId = quoteId;
            
            if(quoteBlob != null) {
                
                //get the subAccount Name
                String subAccountName =  InvoiceProcessHelper.getSubAccountName(currentQuote.Account__c).replaceAll('[^a-zA-Z0-9]', '%20');
              
                //INVOICE NUMBER – SUBACCOUNT NAME
                String fileName = latestInvoiceNumber+ '%20-%20' + subAccountName+'.pdf';
                
                //upload Document
                Map<String,Object> results = new ConnectDrive().uploadFileToDrive(quoteBlob,fileName);
                
                  List<Contact> mainContact = [SELECT Id,email,Language__c FROM Contact where AccountId =:currentquote.Account__c and main_contact__c = true and email != null];
        		String email = (mainContact != null && !mainContact.isEmpty() ) ? mainContact.get(0).email : '';
                String emailLanguage = (mainContact != null && !mainContact.isEmpty())? mainContact.get(0).Language__c:'NL';
        		
                if(results != null){
                    //update quote invoice Number
                    currentQuote.Factuur_nr__c = latestInvoiceNumber+'';
                    update currentQuote;
                    
                    //update opportunity closeDate
                    Opportunity currentOpportunity = new Opportunity(Id=currentQuote.OpportunityId,CloseDate = Date.today());
                    update currentOpportunity;
                    
                    insert quoteDoc;
                    
                    //Send Email to mainContact
                    if(currentquote.Account__c != null){
                        InvoiceProcessHelper.SendEmail(currentquote,email,emailLanguage);
                    }else{
                        System.debug('Account Id is null');
                    }
                        
                }else{
                    System.debug(' Uploading to Drive is failed');
                    if(email != ''){
                        InvoiceProcessHelper.sendErrorEmail(email);
                    }
                }
            }else{
                System.debug('Document Blob generation is failed');
            }
            
        }catch(Exception e){
            System.debug('Exception '+e.getMessage());
           
        }
    }
}