public class ContactSelector {
    public static List<Contact> selectContactsFromEmails( List<String> emailList) {
       List<Contact> contactsInDb = [SELECT Id,FirstName,LastName,AccountId,Email,title,Desactivated__c FROM Contact WHERE Email IN : emailList];       
       return contactsInDb;
   }
    public static List<Contact> selectContactsFromIds( List<String> idList) {
        List<Contact> contactsInDb = [SELECT Id,FirstName,LastName,AccountId,Email,title,Desactivated__c FROM Contact WHERE Id IN : idList];       
        return contactsInDb;
    }
}