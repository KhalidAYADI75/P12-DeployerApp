@RestResource(urlMapping='/CreateContacts/*')
global class CreateContacts {
	@HttpPost
    global static List<List<Id>> createContactsFromJson() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;  
        ContactWrapper recordLists =(ContactWrapper) JSON.deserialize(req.requestbody.toString(),ContactWrapper.class);
        List<Contact> contactsFromJson = ContactManager.getContactsFromWrapper(recordLists);
        List<String> emailList = ContactManager.getEmailsFromContacts(contactsFromJson);
        List<Contact> contactsInJsonInDb = ContactSelector.selectContactsFromEmails(emailList); 
        List<Id> existingContactIds = ContactManager.getIdsFromContacts(contactsInJsonInDb);
        Map<String,Contact> contactsInJsonInDbMap = ContactManager.getMapContactByEmail(contactsInJsonInDb);
        List<Contact> contactsInJsonNotInDb = ContactManager.getContactsInListNotInMap(contactsFromJson,contactsInJsonInDbMap);
        List<Contact> createdContacts = ContactManager.createContacts(contactsInJsonNotInDb);  
        List<Id> createdContactIds = ContactManager.getIdsFromContacts(createdContacts);
    	List<List<Id>> allIdLists = sendIdLists(res,existingContactIds,createdContactIds);
        return allIdLists;
    }

    global static List<List<Id>> sendIdLists(RestResponse response,List<Id> firstContactIds,List<Id> secondContactsIds) {
        response.responseBody = Blob.valueOf('Contacts  : ' + firstContactIds + ',' + secondContactsIds); 
        List<List<Id>> allIdLists = new List<List<Id>> {firstContactIds,secondContactsIds};
        return allIdLists;
    }

}