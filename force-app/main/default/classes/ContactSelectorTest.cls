@isTest
public with sharing class ContactSelectorTest {
    @TestSetup static void setup(){
        List<Contact> contactList = TestDataFactory.createContactList();
    }
    @isTest
    public static void testSelectContactsFromEmails() {
        List<String> emailList = new List<String>();
        for (Integer i=0 ; i<10;i++ ) {
            emailList.add('TestEmail' + i +'@p12.com');
        }
        Test.startTest();
        List<Contact> contacts = ContactSelector.selectContactsFromEmails(emailList);
        Test.stopTest();
        System.assertEquals(10, contacts.size());
    }
}