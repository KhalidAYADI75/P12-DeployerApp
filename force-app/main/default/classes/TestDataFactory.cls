@isTest
public with sharing class TestDataFactory {
    @isTest
    public static List<Contact> createContactList() {
        List<Contact> ctList = new List<Contact>();
        for (Integer i=0;i<10;i++) {
            Contact ct = new Contact(FirstName = 'TestFirstName' + i,LastName='TestLastName'+i,Email='TestEmail'+i+'@p12.com');
            ctList.add(ct);
        }
        insert ctList;
        return ctList;
    }

    public static account createAccount(String AccountName) {
        Account acc = new Account();
        acc.Name = AccountName;
        insert acc;
        return acc;
    }                           
    public static List<Contract> createContractList(ID accId) {
        List<Contract> contractList = new List<Contract>();
        for (Integer i=0;i<10;i++) {
            Contract ctr = new Contract();
            ctr.AccountId = accId;
            ctr.Status = 'Draft';
            ctr.StartDate = date.parse('01/01/2022');
            ctr.ContractTerm = 12;
            contractList.add(ctr);
        }
        insert contractList;
        return contractList;
    }

    public static String declareContactJsonStr() {
        String jsonStr ='{"records" : [{"attributes" : {"type" : "Contact"},"Email" : "testEmail0@p12.com","FirstName" : "TestFirst","LastName" : "TestLast"}]}';
        return jsonStr;
    }

    public static String declareContractJsonStr() {
        String jsonStr ='{"records" : [{"attributes" : {"type" : "Contract"},"id" : "0123456789","AccountName" : "TestAccount","Status" : "Draft","StartDate" :"01/01/2022","ContractTerm" : 12}]}';
        return jsonStr;
    }

     public static String declareContractJsonStrForUpdate() {
        String jsonStr = '{"records" : [{"attributes" : {"type" : "Contract"},"Salesforceid" : "80009000000Rn4BAAS","Description" :"contrat modifié"}]}';
        return jsonStr;
    }
}