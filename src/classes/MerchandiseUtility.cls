public class MerchandiseUtility {
    public static void mainProcessing() {
        try {
            insertMerchandise();
        } catch(MerchandiseException me) {
            System.debug('Message: ' + me.getMessage());    
            System.debug('Cause: ' + me.getCause());    
            System.debug('Line number: ' + me.getLineNumber());    
            System.debug('Stack trace: ' + me.getStackTraceString());    
        }
    }
    
    public static void insertMerchandise() {
        try {
            // Insert merchandise without required fields 
    
            Merchandise__c m = new Merchandise__c();
            insert m;
        } catch(DmlException e) {
            // Something happened that prevents the insertion 
    
            // of Employee custom objects, so throw a more 
    
            // specific exception. 
    
            throw new MerchandiseException(
                'Merchandise item could not be inserted.', e);
        }
    }
}