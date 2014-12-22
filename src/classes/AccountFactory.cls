@isTest
public class AccountFactory extends SObjectFactory
{
    public AccountFactory( Map<Schema.SObjectField,Object> fieldToValue )
    {
    }
    public SObject buildRecordWithData()
    {
        return new Account( Name = 'Test Account ' + counter );
    }
}