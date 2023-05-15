@isTest
public with sharing class DeleteContactsTest {
    @TestSetup static void setup(){
        List<Contact> contactList = TestDataFactory.createContactList();
    }
    @isTest
    public static void testDeleteContactsFromJson() {
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();  
        request.requestUri ='https://mindful-shark-6cwgay-dev-ed.trailblaze.my.salesforce.com/services/apexrest/DeleteContacts';
        request.httpMethod = 'DELETE';
        String jsonStr = TestDataFactory.declareContactJsonStr();
        Contact ct = [SELECT Id FROM CONTACT WHERE email = 'testEmail0@p12.com'];
        String newJsonStr = jsonStr.replace('"attributes" : {"type" : "Contact"}', '"attributes" : {"type" : "Contact", "Id" : "' + ct.Id + '"}');
        request.requestBody = Blob.valueof(newJsonStr);
        RestContext.request = request;
        RestContext.response = response;
        Test.startTest();
        List<Contact> contactsWithDesactivatedFieldSetToTrue = DeleteContacts.deleteContactsFromJson();
        List<Id> contactIdsWithDesactivatedFieldSetToTrue = ContactManager.getIdsFromContacts(contactsWithDesactivatedFieldSetToTrue);
        Test.stopTest();
        system.assertEquals(1,[SELECT COUNT() FROM Contact WHERE Id IN : contactIdsWithDesactivatedFieldSetToTrue]);
    }
}