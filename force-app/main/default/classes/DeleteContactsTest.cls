@isTest
public with sharing class DeleteContactsTest {
    @isTest
    public static void testDeleteContactsFromJson() {
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();  
        request.requestUri ='https://mindful-shark-6cwgay-dev-ed.trailblaze.my.salesforce.com/services/apexrest/CreateContacts';
        request.httpMethod = 'DELETE';
        request.requestBody = Blob.valueof(TestDataFactory.declareContactJsonStr());
        RestContext.request = request;
        RestContext.response = response;
        Test.startTest();
        List<Contact> contactsWithDesactivatedFieldSetToTrue = DeleteContacts.deleteContactsFromJson();
        Test.stopTest();
        system.assertNotEquals(null,contactsWithDesactivatedFieldSetToTrue);
    }
}