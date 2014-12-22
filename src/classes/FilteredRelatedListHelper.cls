public with sharing class FilteredRelatedListHelper
{
    public static String buildQueryString( Schema.FieldSet fieldSet, Id sObjectId, String sObjectName, String sObjectLookup, String filterString )
    {
        List<String> fields = new List<String>();
        
        for( Schema.FieldSetMember fieldSetMember : fieldSet.getFields() )
        {
            fields.add( fieldSetMember.getFieldPath() );
        }
        String fieldsToQuery = String.join( fields, ', ');

        String query = 'SELECT {0} FROM {1} WHERE {2} = {3} ';
        String idString = '\'' + sObjectId + '\'';
        query = String.format( query, new List<String>{ fieldsToQuery, sObjectName, sObjectLookup, idString } );
        query += String.isEmpty( filterString ) ? '' : ' AND ' + filterString;
        return query;
    }
}