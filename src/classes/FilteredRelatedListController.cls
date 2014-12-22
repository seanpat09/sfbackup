public with sharing class FilteredRelatedListController
{
    @TestVisible static String ERROR_TEMPLATE = 'There is no field set named {0} for sObject type {1}';

    public Id sObjectId { get; set; }
    public String sObjectName { get; set; }
    public String sObjectLookup { get; set; }
    public String filterString { get; set; }
    public String fieldSetName { get; set; }
    public Schema.FieldSet fieldSet { get; private set; }

    public List<sObject> getSObjects()
    {
        setFieldSet();
        if( fieldSet == NULL ) return new List<sObject>();
        String query = FilteredRelatedListHelper.buildQueryString( fieldSet,
                                                                   this.sObjectId,
                                                                   this.sObjectName,
                                                                   this.sObjectLookup,
                                                                   this.filterString );
        return Database.query( query ); 
    }

    private void setFieldSet()
    {
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(sObjectName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        this.fieldSet = DescribeSObjectResultObj.FieldSets.getMap().get( this.fieldSetName );
        if( fieldSet != NULL ) return;
        ApexPages.addMessage( 
                new ApexPages.Message( 
                    ApexPages.Severity.ERROR, String.format( ERROR_TEMPLATE, new List<String>{ this.fieldSetName, this.sObjectName } )
                                     )
                                );
    }
}