@RestResource(urlMapping='/UpdateContacts/*')
global class UpdateContacts {
	@HttpPost
    global static List<Contact> updateContactsFromJson() {
        RestRequest req = RestContext.request;
        ContactWrapper recordLists =(ContactWrapper) JSON.deserialize(req.requestbody.toString(),ContactWrapper.class);    
        List<Contact> contactsFromJson = ContactManager.getContactsFromWrapper(recordLists);   
        List<String> emailList = ContactManager.getEmailsFromContacts(contactsFromJson);
        List<Contact> contactIdsToUpdate = ContactSelector.selectContactsFromEmails(emailList); 
        List<Contact> contactsToUpdate = ContactManager.addIdToContactList(contactsFromJson, contactIdsToUpdate);
        List<Contact> contactsUpdated = ContactManager.updateContacts(contactsToUpdate);
        return contactsUpdated;
    }
}