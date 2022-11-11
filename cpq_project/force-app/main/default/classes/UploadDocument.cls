public class UploadDocument {
    
    @InvocableMethod   
    public static void CreateQuote(List<Id> quoteIds)  
    { 
        createQuoteFutureMethod(quoteIds);
    }
    
   @future(callout=true)
    public static void createQuoteFutureMethod (List<Id> quoteIds) {
        //Initialize the quote url
        String quoteUrl = '/quote/quoteTemplateDataViewer.apexp?';
        
        //Get the Quote Template Id from Custom Settings
        String quoteTemplateId = '0EH5e000000FsnG';
        
        //List variable to get all the Quote Documents
        List<QuoteDocument> lstQuoteDoc = new List<QuoteDocument>();
        String quoteId = quoteIds.get(0);
        
        quoteUrl += 'id=' + quoteId;
        quoteUrl += '&headerHeight=197&footerHeight=10';
        quoteUrl += '&summlid=' + quoteTemplateId;
        
         //call the quote url
        PageReference pageRef = new PageReference(quoteUrl);
        
        //get the quotePdf
        Blob quoteBlob;
        
        if(Test.isRunningTest()) {
            quoteBlob = Blob.valueOf('Generate Pdf');
        } else {
            quoteBlob = pageRef.getContentAsPDF();
        }
        
        //initialze the QuoteDocument to hold the quote pdf for insertion
        QuoteDocument quoteDoc = new QuoteDocument();
        quoteDoc.Document = quoteBlob;
        quoteDoc.QuoteId = quoteId;
        lstQuoteDoc.add(quoteDoc);
        
       // datetime myDateTime = datetime.now();
        String num = String.valueOf(Math.random()).substring(2, 6);
        String fileName = 'Quote_'+num+'.pdf';
        new ConnectDrive().uploadFileToDrive(quoteBlob,fileName);
       // new GoogleConnectDrive().uploadFileToDrive(quoteBlob,fileName);
        
        if(!lstQuoteDoc.isEmpty() && lstQuoteDoc.size() > 0) {
            Database.insert(lstQuoteDoc);
        }
        
    }

}