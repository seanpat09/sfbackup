@isTest
public class TestInvoiceStatementDeletion {
  static testMethod void TestDeleteInvoiceWithLineItem() {
  	Invoice_Statement__c inv = TestDataFactory.createOneInvoiceStatement(true);
  	Test.startTest();
  	Database.DeleteResult result = Database.delete(inv, false);
  	Test.stopTest();
  	
  	System.assert(!result.isSuccess());
  }
  static testMethod void TestDeleteInvoiceWithoutLineItem() {
  	Invoice_Statement__c inv = TestDataFactory.createOneInvoiceStatement(false);
  	Test.startTest();
  	Database.DeleteResult result = Database.delete(inv, false);
  	Test.stopTest();
  	
  	System.assert(result.isSuccess());
  }
  
  static testMethod void TestBulkDeleteInvoices() {
  	List<Invoice_Statement__c> invList = new List<Invoice_Statement__c>();
  	invList.add(TestDataFactory.createOneInvoiceStatement(false));
  	invList.add(TestDataFactory.createOneInvoiceStatement(true));
  	
  	Test.startTest();
  	Database.Deleteresult[] results = Database.delete(invList, false);
  	Test.stopTest();
  	
  	System.assert(results[0].isSuccess());
  	
  	System.assert(!results[1].isSuccess());
  }
}