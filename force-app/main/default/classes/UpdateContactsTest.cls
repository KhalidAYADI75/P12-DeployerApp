@isTest
public with sharing class UpdateContactsTest {
    @TestSetup static void setup(){
        Contact ct = new Contact(Email = 'agreen@uog.com',Title = 'Engineer', FirstName = 'FName1',LastName = 'LName1');
        insert ct;
    }
    @isTest
    public static void testUpdateContactsFromJson()  {
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();  
        request.requestUri ='https://mindful-shark-6cwgay-dev-ed.trailblaze.my.salesforce.com/services/apexrest/CreateContacts';
        request.httpMethod = 'POST';
        String jsonStr = '{"records" : [{"attributes" : {"type" : "Contact"},"Email" : "agreen@uog.com","Title" : "Lead Engineer","FirstName" : "FName1","LastName" : "LName1"}]}';
        request.requestBody = Blob.valueof(jsonStr);
        RestContext.request = request;
        RestContext.response = response;
        Test.startTest();
        List<Contact> contactsUpdated = UpdateContacts.updateContactsFromJson();
        Test.stopTest();
        system.assertEquals(1, [SELECT COUNT() FROM CONTACT WHERE Title = 'Lead Engineer']);
    }
}