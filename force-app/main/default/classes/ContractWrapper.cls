public with sharing class ContractWrapper {
    public List<CtrWrapper> records ;
    public class CtrWrapper {
        public String AccountId;
        public String AccountName;
        public String Status;
        public String StartDate;
        public String Description;
        public Integer ContractTerm;
        public Attributes attributes;
    }           
    public class Attributes {
        public String type;
    }           
}