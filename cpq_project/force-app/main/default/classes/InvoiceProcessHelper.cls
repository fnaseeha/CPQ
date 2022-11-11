public class InvoiceProcessHelper {
    
    public static Blob generateQuoteBlob(String quoteId, String quoteTemplateId){
          
        //Initialize the quote url
        String quoteUrl = '/quote/quoteTemplateDataViewer.apexp?';
        
        quoteUrl += 'id=' + quoteId;
        quoteUrl += '&headerHeight=197&footerHeight=10';
        quoteUrl += '&summlid=' + quoteTemplateId;
        
        //call the quote url
        PageReference pageRef = new PageReference(quoteUrl);
        
        Blob quoteBlob;
        if(Test.isRunningTest()) {
           	quoteBlob = Blob.valueOf('Generate Pdf');
        }else{
            quoteBlob = pageRef.getContentAsPDF();
        }
        
        //get the quotePdf
        return  quoteBlob;
        
    }
    
    
  public static String getQuoteTemplateId(String language){
        
        //get language
        String quoteTemplateLanguage = (language != null && !String.isBlank(language) )? language : 'NL';
        
        //get custom template ID
        String instanceName = 'Invoice_'+quoteTemplateLanguage;
		
        String quoteTemplateId = MetadataTypeReader.getQuoteTemplateId(instanceName);
        return quoteTemplateId;
    }
    
    public static String getSubAccountName(String subAccountId){
          List<Account> subAccList = [SELECT Id,Name FROM Account WHERE Id=:subAccountId];
         return (subAccList!= null && !subAccList.isEmpty()) ? subAccList.get(0).Name : 'A';
    }
    
    public static Integer getLatestInvoiceNumber(){
        List<Quote> quoteList = [SELECT Id,Factuur_nr__c FROM Quote where Factuur_nr__c != null Order by Factuur_nr__c DESC ];
        return (quoteList!= null && !quoteList.isEmpty()) ? Integer.ValueOf(quoteList.get(0).Factuur_nr__c) + 1 : 1000000;
    }
    
    public static void SendEmail(Quote currentquote,String email, String emailLanguage){
      
        
        String emailTemplateName = 'Invoice_'+emailLanguage;
        //get email template
        List<EmailTemplate> emailTemplates = [SELECT Id,Subject, Body FROM EmailTemplate where DeveloperName = :emailTemplateName];
        EmailTemplate template = (emailTemplates!= null && !emailTemplates.isEmpty())? emailTemplates.get(0) : null;
        //send email
        if(template != null && email != null && !String.isBlank(email)){
            List<string> toAddress = new List<string>();
            toAddress.add(email);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTemplateId(template.Id);
            mail.setToAddresses(toAddress);
            mail.setSubject( template.subject.replace('{!Quote.Factuur_nr__c}',currentQuote.Factuur_nr__c));
            mail.setHTMLBody(template.Body.replace('{!Quote.Factuur_nr__c}',currentQuote.Factuur_nr__c));
            mail.setSaveAsActivity(false);
            mail.setUseSignature(false);
            
            Messaging.SendEmailResult[] emailResults = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
            for(Messaging.SendEmailResult er:emailResults){
                if(!er.isSuccess()){
                    System.debug('Email failed: ' + er.getErrors());
                }else{
                    System.debug('Email has sent successfully ');
                }
                
            }
        }
    }
    
    public static void sendErrorEmail(String email){
        try{
            Messaging.SingleEmailMessage semail = new Messaging.SingleEmailMessage();
            String[] sendingTo = new String[]{email}; 
            semail.setToAddresses(sendingTo);
            semail.setSubject('Invoice Process Failed'); 
            semail.setHTMLBody('Hi,<br/> There is an error while uploading file to OneDrive. <br/> Please try again or contact System Administrator <br/> Thanks'); 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] {semail});
        }catch(Exception e){
            System.debug('Exception###' + e.getLineNumber() + e.getMessage());
        }
         
    }

}