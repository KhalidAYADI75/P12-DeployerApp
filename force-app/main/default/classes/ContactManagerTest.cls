@isTest
public with sharing class ContactManagerTest {
    @TestSetup static void setup(){
        List<Contact> contactList = TestDataFactory.createContactList();
    }
    @isTest
    public static void testGetContactsFromWrapper() {
        String jsonStr = TestDataFactory.declareContactJsonStr();
        Test.startTest();
        ContactWrapper recordList =(ContactWrapper) JSON.deserialize(jsonStr,ContactWrapper.class);
        List<Contact> contactList = ContactManager.getContactsFromWrapper(recordList);
        Test.stopTest();
        system.assertNotEquals(null, contactList);
    }
    @isTest
    public static void testGetEmailsFromContacts() {
        List<Contact> contactList=[SELECT Id,Email FROM Contact WHERE Firstname LIKE '%TestFirstName%'] ; 
        Test.startTest();
        List<String> emailList = ContactManager.getEmailsFromContacts(contactList);
        Test.stopTest();
        system.assertEquals(emailList.size(),contactList.size());
    }
    @isTest
    public static void testGetIdsFromContacts() {
        List<Contact> contactList=[SELECT Id FROM Contact WHERE Firstname LIKE '%TestFirstName%'] ; 
        Test.startTest();
        List<String> idList = ContactManager.getIdsFromContacts(contactList);
        Test.stopTest();
        system.assertEquals(idList.size(),contactList.size());
    }
    @isTest
    public static void testGetMapContactByEmail () {
        List<Contact> contactList=[SELECT Email FROM Contact WHERE Firstname LIKE '%TestFirstName%'] ; 
        Test.startTest();
        Map<String,Contact> contactMap = ContactManager.getMapContactByEmail(contactList);
        Test.stopTest();
        system.assertEquals(contactMap.size(),contactList.size());
    }
    @isTest
    public static void testGetContactsInListNotInMap() {
        List<Contact> contactList=[SELECT Id,Email FROM Contact WHERE Firstname LIKE '%TestFirstName%'] ; 
        Map<String,Contact> ContactMap = new Map<String,Contact>{'testemail0@p12.com' => new contact(FirstName='TestFirstName0',LastName='TestLastName0',Email='testemail0@p12.com')};
        Test.startTest();
        List<Contact> contactsOnlyInList = ContactManager.getContactsInListNotInMap(contactList,ContactMap);
        Test.stopTest();
        system.assertEquals(9,contactsOnlyInList.size());
    }

    @IsTest
    public static void testCreateContacts() {
        List<Contact> contactList = new List<Contact>();
        for (Integer i=0;i<10;i++) {
            Contact ct = new Contact(FirstName = 'TestFirstName' + i,LastName='TestLastName'+i,Email='NewTestEmail'+i+'@p12.com');
            contactList.add(ct);
        }      
        Test.startTest();
        List<Contact> contactsCreated = ContactManager.createContacts(contactList);
        Test.stopTest();
        system.assertEquals(10,[SELECT COUNT() FROM Contact WHERE Email LIKE '%NewTestEmail%']);
    }
    @isTest    
    public static void testUpdateContacts() {
        List<Contact> contacts=[SELECT Email FROM Contact WHERE Firstname LIKE '%TestFirstName%'] ; 
        Test.startTest();
        List<Contact> contactsUpdated = ContactManager.updateContacts(contacts);
        Test.stopTest();
        system.assertEquals(10, contactsUpdated.size());
    }

    @isTest
    public static void testSetDesactivatedFieldToTrue() {
        List<Contact> contacts = [SELECT Id,FirstName,LastName,AccountId,Email,title,Desactivated__c FROM Contact];
        Test.startTest();
        List<Contact> contactList = ContactManager.setDesactivatedFieldToTrue(contacts);
        Test.stopTest();
        system.assertEquals(10, [SELECT COUNT() FROM Contact WHERE Desactivated__c=true]);
    }
}