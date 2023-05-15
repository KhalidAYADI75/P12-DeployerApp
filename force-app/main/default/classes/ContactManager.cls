public class ContactManager {

    public static List<Contact> getContactsFromWrapper(ContactWrapper results) {
        List<Contact> contactList = new List<Contact>();
        for (ContactWrapper.CtWrapper ctWrap : results.records) {
            if (ctWrap.attributes.type == 'Contact') {
                Contact ct = new Contact();
                ct.Id= ctWrap.attributes.Id;
                ct.Email= ctWrap.Email;
                ct.FirstName= ctWrap.FirstName;
                ct.LastName= ctWrap.LastName;
                ct.Title= ctWrap.Title;
                contactList.add(ct);
            }          
        }
        return contactList;
    }

    public static List<String> getEmailsFromContacts(List<Contact> contactList) {
        List<String> emailList = new List<String>(); 
        for(Contact ct : contactList){
        	emailList.add(ct.Email); 
        }
        return emailList;
    }

    public static List<Contact> addIdToContactList(List<Contact> contactsToUpdate , List<Contact> contactsIds ) {
        for (Contact ct : contactsToUpdate) {
            for (Contact ctId : contactsIds) {
                if (ct.Email == ctId.Email) {
                    ct.Id = ctId.id;
                }
            }
        }
        return contactsToUpdate;
    }
    
    public static List<Id> getIdsFromContacts(List<Contact> contactList) {
        List<Id> contactIds = new List<Id>(); 
        for (Contact ct : contactList) {
            contactIds.add(ct.Id); 
        }
        return contactIds;
    }

    public static Map<String,Contact> getMapContactByEmail (List<Contact> contacts) {
        Map<String,Contact> contactMap = new Map<String, Contact>();
        for(Contact ct : contacts) {
            contactMap.put(ct.Email, ct);
        }
        return contactMap;
    }

    public static List<Contact> getContactsInListNotInMap(List<Contact> contactList, Map<String,Contact> contactMap) {
        List<Contact> contactsOnlyInList = new List<Contact>();
        for (Contact ct : contactList) {
            if (!contactMap.containsKey(ct.Email)) {
                contactsOnlyInList.add(ct);          
            }
        }       
         return contactsOnlyInList;
    }
     
    public static List<Contact> createContacts(List<Contact> contactsToCreate) {
        insert contactsToCreate;
        return contactsToCreate;       
    }
             
    public static List<Contact> updateContacts(List<Contact> contactsToUpdate) {
        update contactsToUpdate;
        return contactsToUpdate;
    }  
          
    public static List<Contact> setDesactivatedFieldToTrue(List<Contact> contactList) {
        List<Contact> listUpdated = new List<Contact>();
        for (Contact ct : contactList) {
            if (ct.Desactivated__c == false) {
                ct.Desactivated__c = true;
                listUpdated.add(ct);
            }
        }
        update listUpdated;
        return listUpdated;
    }
 }