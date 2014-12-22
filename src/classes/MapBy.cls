global class MapBy
{
    global static void ids( String field, List<sObject> records, Map<Id, sObject> recordMap )
    {
        for ( sObject record : records )
        {
            Id key = (Id)record.get( field );
            if( key != null )
            {
                recordMap.put( key, record );
            }
        }
    }

    global static void strings( String field, List<sObject> records, Map<String, sObject> recordMap )
    {
        for ( sObject record : records )
        {
            String key = (String)record.get( field );
            if( key != null )
            {
                recordMap.put( key, record );
            }
        }
    }
}