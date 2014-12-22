@isTest
private class FilteredRelatedListControllerTest
{
    public class TestData
    {
        public Account hamburgerInc;
        public void setup()
        {
            hamburgerInc = new Account( Name = 'Hamburger Assistant');
            insert hamburgerInc;

            Contact joe = new Contact( LastName = 'Joe Joe', AccountId = hamburgerInc.Id );
            Contact jamby = new Contact( LastName = 'Shabadu', AccountId = hamburgerInc.Id );
            insert new List<Contact>{ joe, jamby };
        }
    }

    static testMethod void getSObjects_FieldSetFound()
    {
        TestData testData = new TestData();
        testData.setup();

        FilteredRelatedListController controller = new FilteredRelatedListController();
        controller.sObjectName = 'Contact';
        controller.sObjectLookup = 'AccountId';
        controller.sObjectId = testData.hamburgerInc.Id;
        controller.fieldSetName = 'Test_Field_Set';
        
        Test.startTest();
            List<sObject> sObjects = controller.getSObjects();
        Test.stopTest();

        System.assertEquals( false, ApexPages.hasMessages(), 'There should be no error messages' );
        System.assertEquals( false, sObjects.isEmpty(), 'sObjects should have been found' );
    }

    static testMethod void getSObjects_FieldSetNotFound()
    {
        TestData testData = new TestData();
        testData.setup();

        FilteredRelatedListController controller = new FilteredRelatedListController();
        controller.sObjectName = 'Contact';
        controller.sObjectLookup = 'AccountId';
        controller.sObjectId = testData.hamburgerInc.Id;
        controller.fieldSetName = 'Dummy';
        
        Test.startTest();
            List<sObject> sObjects = controller.getSObjects();
        Test.stopTest();

        System.assertEquals( 1, ApexPages.getMessages().size(), 'There should be error messages on the page' );

        String expectedError = String.format( FilteredRelatedListController.ERROR_TEMPLATE, new List<String>{ controller.fieldSetName, controller.sObjectName } );
        System.assertEquals( expectedError, ApexPages.getMessages()[0].getDetail(), 'The correct error messages on the page' );
    }
}