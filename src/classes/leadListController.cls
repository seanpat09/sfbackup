public class leadListController {

  public leadListController(){}
 
  public static List<Lead> getLeads() {
    List<Lead> leads = [SELECT Id, Name, State, Company, Email, LastModifiedDate FROM Lead WHERE Status = 'Open - Not Contacted' ORDER BY LastModifiedDate DESC];
    return leads;
  }
  
  @isTest (SeeAllData=true)
  public static void testLeadListController() { 
    leadListController llc = new leadListController(); 
    System.assertEquals(true, (leadListController.getLeads().size() > 0));
  }

}