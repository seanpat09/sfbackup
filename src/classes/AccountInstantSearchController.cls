public with sharing class AccountInstantSearchController {

    public String username { get; set; }
    
    public class AccountWrapper
    {
        public string id;
        public string name;
        public AccountWrapper( String name, String id )
        {
            this.name = name;
            this.id = id;
        }
    }
    
    @RemoteAction
    public static List<Account> getAccounts( String searchTerm )
    {
        String searchString = '%' + String.escapeSingleQuotes(searchTerm) + '%';
        return [ SELECT Id, Name, BillingStreet FROM Account WHERE Name LIKE :searchString LIMIT 100 ];
    }
    //New Comment
}