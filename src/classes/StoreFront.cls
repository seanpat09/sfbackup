public class StoreFront {

  public String message { get; set; }
  public PageReference shop() {
  	message = 'You bought: ';
    for (DisplayMerchandise p: products) {
      if (p.count > 0) {
        message += p.merchandise.name + ' (' + p.count + ')    ';
      }
    }
  	return null;
  }
  DisplayMerchandise[] products;
  public class DisplayMerchandise {
  	public Merchandise__c merchandise {get; set;}
  	public Decimal count {get; set;}
  	public DisplayMerchandise(Merchandise__c item) {
  		this.merchandise = item;
   	}
  }
  public DisplayMerchandise[] getProducts() {
  	if (products == null) {
  		products = new DisplayMerchandise[]{};
  		for (Merchandise__c item : [SELECT id, name, description__c, price__c FROM Merchandise__c WHERE Total_Inventory__c > 0]) {
  			products.add(new DisplayMerchandise(item));
  		}
  	}
  	return products;
  }
}