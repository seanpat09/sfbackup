global class CleanUpRecords implements Database.Batchable<sObject> {
  global final String QUERY;
  
  global CleanUpRecords(String q) {
  	QUERY = q;
  }	
  
  global Database.QueryLocator start(Database.BatchableContext BC) {
  	return Database.getQueryLocator(QUERY);
  }
  
  global void execute(Database.BatchableContext BC, List<sObject> scope) {
  	delete scope;
  	Database.emptyRecycleBin(scope);
  }
  
  global void finish(Database.BatchableContext BC) {
  	AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id = :BC.getJobId()];
      
       Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       String[] toAddresses = new String[] {a.CreatedBy.Email};
       mail.setToAddresses(toAddresses);
       mail.setSubject('Record Clean Up Status: ' + a.Status);
       mail.setPlainTextBody
       ('The batch Apex job processed ' + a.TotalJobItems +
       ' batches with '+ a.NumberOfErrors + ' failures.');
       Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
  }
}