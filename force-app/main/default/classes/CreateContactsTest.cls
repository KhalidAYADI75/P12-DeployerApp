@isTest
public with sharing class CreateContactsTest {
    @isTest
    public static void testCreateContactsFromJson() {
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();  
        request.requestUri ='https://mindful-shark-6cwgay-dev-ed.trailblaze.my.salesforce.com/services/apexrest/CreateContacts';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueof(TestDataFactory.declareContactJsonStr());
        RestContext.request = request;
        RestContext.response = response;
        Test.startTest();
        List<List<Id>> allIdLists = CreateContacts.createContactsFromJson();
        Test.stopTest();
        system.assertNotEquals(null,allIdLists);
    }
}