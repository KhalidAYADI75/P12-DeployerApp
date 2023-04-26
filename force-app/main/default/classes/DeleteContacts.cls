@RestResource(urlMapping='/DeleteContacts/*')
global class DeleteContacts {
	@HttpDelete
    global static List<Contact> deleteContactsFromJson() {
    	RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;  
        ContactWrapper recordLists =(ContactWrapper) JSON.deserialize(req.requestbody.toString(),ContactWrapper.class);
        List<Contact> contactsFromJson = ContactManager.getContactsFromWrapper(recordLists);  
        List<Id> contactList = ContactManager.getIdsFromContacts(contactsFromJson);
        List<Contact> contactsInJsonInDb = ContactSelector.selectContactsFromIds(contactList);
        List<Contact> contactsWithDesactivatedFieldSetToTrue = ContactManager.setDesactivatedFieldToTrue(contactsInJsonInDb);
        return contactsWithDesactivatedFieldSetToTrue;
    }
}