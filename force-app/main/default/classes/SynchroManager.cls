@RestResource(urlMapping='/Synchro/*')
global class SynchroManager {
	@HttpPost
    global static void updateOrCreateContacts() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;  
     	Map<String,Object> results = (Map<String,Object>) JSON.deserializeUntyped(req.requestbody.toString()); 
        List<Contact> contactsFromJson = ContactManager.getContactListFromJson(results);
        List<String> emailList = new List<String>(); 
        for(Contact ct : contactsFromJson){
        	emailList.add(ct.Email); 
        }          
        Map<String,Contact> ctsInJsonAndInDb = ContactManager.getContactsInDb(emailList);  
        List<Contact> ctsInJsonAndNotInDb = ContactManager.getContactsNotInDb(contactsFromJson,ctsInJsonAndInDb);
        List<Contact> contactsCreated = ContactManager.createContacts(ctsInJsonAndNotInDb);
 //     List<Contact> IdcontactsSendedToAxg = ContactManager.sendIdContactsToAxg(ctsInJsonAndInDb);    
        List<Contact> contactsModified = ContactManager.getContactsModified(contactsFromJson , ctsInJsonAndInDb);
        List<Contact> contactsUpdated = ContactManager.updateContacts(contactsModified);
    }

}