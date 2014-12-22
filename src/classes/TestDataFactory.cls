@isTest
public class TestDataFactory {
	public static Invoice_Statement__c createOneInvoiceStatement (Boolean withLineItem) {
		Invoice_Statement__c testInvoice = createInvoiceStatement();
		if (withLineItem == true) {
			Merchandise__c m = createMerchandiseItem('Orange Juice');
			
			AddLineItem(testInvoice, m);
		}
		return testInvoice;
	}
	
	private static Merchandise__c createMerchandiseItem(String merchName) {
		Merchandise__c m = new Merchandise__c(Name=merchName, Description__c='Fresh Juice', Price__c=2, Total_Inventory__c=1000);
		insert m;
		return m;
	}
	
	private static Invoice_Statement__c createInvoiceStatement() {
		Invoice_Statement__c inv = new Invoice_Statement__c(Description__c='Test Invoice');
		insert inv;
		return inv;
	}
	
	private static Line_Item__c AddLineItem (Invoice_Statement__c inv, Merchandise__c m) {
		Line_Item__c lineItem = new Line_Item__c(Invoice_Statement__c = inv.Id, Merchandise__c = m.Id, Unit_Price__c = m.Price__c, Units_Sold__c = (Double)(10*Math.random()+1));
		insert lineItem;
		return lineItem;
	}
}