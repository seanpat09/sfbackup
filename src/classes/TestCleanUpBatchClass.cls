@isTest
private class TestCleanUpBatchClass {
	static testmethod void test() {
		
		String query = 'SELECT Id, CreatedDate FROM Merchandise__c ' + 'WHERE Id NOT IN (SELECT Merchandise__c FROM Line_Item__c)';
		
	    Merchandise__c[] ml = new List<Merchandise__c>();
        for (Integer i=0;i<10;i++) {
           Merchandise__c m = new Merchandise__c(
               Name='Merchandise ' + i,
               Description__c='Some description',
               Price__c=2,
               Total_Inventory__c=100);
           ml.add(m);
       }
       insert ml;
       
       Test.startTest();
       CleanUpRecords c = new CleanupRecords(query);
       Database.executeBatch(c);
       Test.stopTest();
       
       Integer i = [SELECT COUNT() FROM Merchandise__c];
       System.assertEquals(i,0);
	}

}