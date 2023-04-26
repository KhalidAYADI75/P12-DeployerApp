@isTest
public with sharing class ContactSelectorTest {
    @TestSetup static void setup(){
        List<Contact> contactList = TestDataFactory.createContactList();
    }
    @isTest
    public static void testSelectContactsFromEmails() {
        List<Contact> contactList = [SELECT Id,email FROM Contact];
        List<String> emailList = new List<String>();
        for (Contact ct : contactList) {
            emailList.add(ct.email);
        }
        Test.startTest();
        List<Contact> contacts = ContactSelector.selectContactsFromEmails(emailList);
        Test.stopTest();
        System.assertEquals(10, contacts.size());
    }
    @isTest
    public static void testSelectContactsFromIds() {
        List<Contact> contactList = [SELECT Id FROM Contact];
        List<Id> idList = new List<Id>();
        for (Contact ct : contactList) {
            idList.add(ct.Id);
        }
        Test.startTest();
        List<Contact> contacts = ContactSelector.selectContactsFromIds(idList);
        Test.stopTest();
        System.assertEquals(10, contacts.size());
    }
}