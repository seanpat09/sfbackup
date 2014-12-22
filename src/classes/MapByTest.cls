@isTest
private class MapByTest
{
    static testMethod void MapBy_ids()
    {
        final Id WAYNE_CORP_ACCOUNT_ID = '0010000000XXXXX';
        final Id DAILY_PLANET_ACCOUNT_ID = '0010000000XXXXY';
        final Id AMAZON_ACCOUNT_ID = '0010000000XXXXZ';

        Contact bruce = new Contact( Id = '0030000000XXXXX', AccountId = WAYNE_CORP_ACCOUNT_ID );
        Contact clark = new Contact( Id = '0030000000XXXXy', AccountId = DAILY_PLANET_ACCOUNT_ID );
        Contact diana = new Contact( Id = '0030000000XXXXz', AccountId = AMAZON_ACCOUNT_ID );
        Contact noAccount = new Contact( Id = '0030000000XXXXr', AccountId = NULL );

        List<Contact> allContacts = new List<Contact>{ bruce, clark, diana, noAccount };
        Map<Id,Contact> accountIdToContact = new Map<Id,Contact>();
        Test.startTest();
            MapBy.ids( 'AccountId', allContacts, accountIdToContact);
        Test.stopTest();

        System.assertEquals( 3, accountIdToContact.size(), 'There should be an entry for all of the foreign key ids' );
        Set<Id> keys = accountIdToContact.keySet();

        System.assert( keys.contains( WAYNE_CORP_ACCOUNT_ID ), 'Each of the foreign key ids should be keys in the map' );
        System.assert( keys.contains( DAILY_PLANET_ACCOUNT_ID ), 'Each of the foreign key ids should be keys in the map' );
        System.assert( keys.contains( AMAZON_ACCOUNT_ID ), 'Each of the foreign key ids should be keys in the map' );
        System.assert( !keys.contains( NULL ), 'Null should not be mapped' );

        System.assertEquals( bruce.Id, accountIdToContact.get( WAYNE_CORP_ACCOUNT_ID ).Id,
            'Each foreign key id should be mapped the correct record id' );
        System.assertEquals( clark.Id, accountIdToContact.get( DAILY_PLANET_ACCOUNT_ID ).Id,
            'Each foreign key id should be mapped the correct record id' );
        System.assertEquals( diana.Id, accountIdToContact.get( AMAZON_ACCOUNT_ID ).Id,
            'Each foreign key id should be mapped the correct record id' );
    }

    static testMethod void MapBy_strings()
    {
        final String BRUCE_LAST_NAME = 'Wayne';
        final String CLARK_LAST_NAME = 'Kent';
        final String DIANA_LAST_NAME = 'Prince';

        Contact bruce = new Contact( Id = '0030000000XXXXX', LastName = BRUCE_LAST_NAME);
        Contact clark = new Contact( Id = '0030000000XXXXy', LastName = CLARK_LAST_NAME);
        Contact diana = new Contact( Id = '0030000000XXXXz', LastName = DIANA_LAST_NAME);
        Contact noLastName = new Contact( Id = '0030000000XXXXr', LastName = null);

        List<Contact> allContacts = new List<Contact>{ bruce, clark, diana, noLastName };
        Map<String,Contact> lastNameToContact = new Map<String,Contact>();
        Test.startTest();
            MapBy.strings( 'LastName', allContacts, lastNameToContact);
        Test.stopTest();

        System.assertEquals( 3, lastNameToContact.size(), 'There should be an entry for all of the foreign key ids' );
        Set<String> keys = lastNameToContact.keySet();

        System.assert( keys.contains( BRUCE_LAST_NAME ), 'Each of the string field valuess should be keys in the map' );
        System.assert( keys.contains( CLARK_LAST_NAME ), 'Each of the string field valuess should be keys in the map' );
        System.assert( keys.contains( DIANA_LAST_NAME ), 'Each of the string field valuess should be keys in the map' );
        System.assert( !keys.contains( NULL ), 'Null should not be mapped' );

        System.assertEquals( bruce.LastName, lastNameToContact.get( BRUCE_LAST_NAME ).LastName,
            'Each string field values should be mapped the correct record LastName' );
        System.assertEquals( clark.LastName, lastNameToContact.get( CLARK_LAST_NAME ).LastName,
            'Each string field values should be mapped the correct record LastName' );
        System.assertEquals( diana.LastName, lastNameToContact.get( DIANA_LAST_NAME ).LastName,
            'Each string field values should be mapped the correct record id' );
    }
}