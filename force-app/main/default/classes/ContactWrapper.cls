public with sharing class ContactWrapper {
    public List<CtWrapper> records ;
    public class CtWrapper {
        public String Id;
        public String Email;
        public String Title;
        public String FirstName;
        public String LastName;
        public Attributes attributes;
    }           
    public class Attributes {
        public String type;
    }
}