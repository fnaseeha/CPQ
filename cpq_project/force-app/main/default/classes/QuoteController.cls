public class QuoteController {
    
    private SBQQ__Quote__c quote;
    public List<SBQQ__QuoteLine__c> QuoteLineList;
    
     public QuoteController(ApexPages.StandardController controller)
    {
        quote=(SBQQ__Quote__c)controller.getrecord();                    
    }

     public List<SBQQ__QuoteLine__c> getQuoteLines()
    {
        List<SBQQ__QuoteLine__c> QuoteLines = [SELECT Id,SBQQ__Description__c,Part_Number__c,SBQQ__Quantity__c,SBQQ__NetTotal__c,SBQQ__Number__c
                                               FROM SBQQ__QuoteLine__c WHERE SBQQ__Quote__c =:quote.id ORDER BY SBQQ__Number__c ];
        return QuoteLines;
    }
}