@isTest
private class FilteredRelatedListHelperTest
{
    public class TestData
    {
        public Account hamburgerInc;
        public Contact joe;
        public Contact jamby;
        public void setup()
        {
            hamburgerInc = new Account( Name = 'Hamburger Assistant');
            insert hamburgerInc;

            joe = new Contact( LastName = 'Joe Joe', AccountId = hamburgerInc.Id, DoNotCall = false );
            jamby = new Contact( LastName = 'Shabadu', AccountId = hamburgerInc.Id, DoNotCall = true );
            insert new List<Contact>{ joe, jamby };
        }
    }

    static testMethod void buildQueryString_WithFilter()
    {
        TestData testData = new TestData();
        testData.setup();

        String filterString = 'DoNotCall = false';
        String sObjectName = 'Contact';
        String sObjectLookup = 'AccountId';
        String sObjectId = testData.hamburgerInc.Id;

        Test.startTest();
            String query = FilteredRelatedListHelper.buildQueryString( sObjectType.Contact.FieldSets.Test_Field_Set,
                                                                       sObjectId,
                                                                       sObjectName,
                                                                       sObjectLookup,
                                                                       filterString );
        Test.stopTest();

        QueryException unexpectedQueryException;
        List<Contact> contacts;
        try
        {
            contacts = Database.query( query );
        }
        catch( QueryException queryEx )
        {
            unexpectedQueryException = queryEx;
        }

        System.assertEquals( NULL, unexpectedQueryException, 'There should be no query exception: ' + unexpectedQueryException );
        System.assertEquals( 1, contacts.size(), 'Only matching objects should be returned' );
        System.assertEquals( testData.joe.Id, contacts[0].Id, 'Only matching objects should be returned' );
    }

    static testMethod void buildQueryString_NoFilter()
    {
        TestData testData = new TestData();
        testData.setup();

        String sObjectName = 'Contact';
        String sObjectLookup = 'AccountId';
        String sObjectId = testData.hamburgerInc.Id;

        Test.startTest();
            String query = FilteredRelatedListHelper.buildQueryString( sObjectType.Contact.FieldSets.Test_Field_Set,
                                                                       sObjectId,
                                                                       sObjectName,
                                                                       sObjectLookup,
                                                                       null );
        Test.stopTest();

        QueryException unexpectedQueryException;
        List<Contact> contacts;
        try
        {
            contacts = Database.query( query );
        }
        catch( QueryException queryEx )
        {
            unexpectedQueryException = queryEx;
        }

        System.assertEquals( NULL, unexpectedQueryException, 'There should be no query exception: ' + unexpectedQueryException );
        System.assertEquals( 2, contacts.size(), 'Only matching objects should be returned' );
        Set<Id> returnedAttachmentIds = new Map<Id,Contact>( contacts ).keySet();
        System.assert( returnedAttachmentIds.contains( testData.joe.Id ), 'Only matching objects should be returned' );
        System.assert( returnedAttachmentIds.contains( testData.jamby.Id ), 'Only matching objects should be returned' );
    }
}