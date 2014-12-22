@RestResource(urlMapping='/processWebTrial/*')
global class TestRest
{
    @HttpPost
    global static void testPost( RestWrapper wrapper )
    {
        update new Lead( Id = wrapper.leadId, Email = wrapper.email );
    }
    global class RestWrapper 
    {
        public String email;
        public String leadId;
    }
}