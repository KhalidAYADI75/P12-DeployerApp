@isTest
public with sharing class ContractManagerTest {
    @TestSetup static void setup(){
        Account acc = TestDataFactory.createAccount('TestAccount');
        List<Contract> contractList = TestDataFactory.createContractList(acc.Id);
    }
    @isTest
    public static void testGetAccountNamesFromWrapper() {
        String jsonStr = TestDataFactory.declareContractJsonStr();
        Test.startTest();
        ContractWrapper recordList =(ContractWrapper) JSON.deserialize(jsonStr,ContractWrapper.class);
        List<String> strList = ContractManager.getAccountNamesFromWrapper(recordList);
        Test.stopTest();
        system.assertEquals(1, strList.size());
    } 
    @isTest
    public static void testUpdateRecordListWithAccountId() {
        String jsonStr = TestDataFactory.declareContractJsonStr();
        List<Account> contractAccounts = new List<Account>{new Account(Name = 'TestAccount')};
        Test.startTest();
        ContractWrapper recordList =(ContractWrapper) JSON.deserialize(jsonStr,ContractWrapper.class);
        ContractWrapper recordListUpdated = ContractManager.updateRecordListWithAccountId(recordList,contractAccounts);
        Test.stopTest();
        system.assertEquals(recordList.records.size(), recordListUpdated.records.size());
    }
    @isTest
    public static void testGetContractsFromWrapper() {
        String jsonStr = TestDataFactory.declareContractJsonStr();
        Test.startTest();
        ContractWrapper recordList =(ContractWrapper) JSON.deserialize(jsonStr,ContractWrapper.class);
        list<Contract> contractList = ContractManager.getContractsFromWrapper(recordList);
        Test.stopTest();
        system.assertEquals(recordList.records.size(), contractList.size());
    }
    @isTest
    public static void testGetContractIdsFromContractList() {
        List<Contract> contractList = [SELECT Id,AccountId FROM Contract];
        Test.startTest();
        List<Id> contractIds = ContractManager.getContractIdsFromContractList(contractList);
        Test.stopTest();
        system.assertEquals(contractIds.size(),contractList.size());
    }
    @isTest
    public static void testInsertContractsFromList() {
        Account acc = TestDataFactory.createAccount('TestAccount1');
        List<Contract> contractList = new List<Contract>();
        Contract ctr = new Contract();
        ctr.AccountId = acc.Id;
        ctr.Status = 'Draft';
        ctr.StartDate = date.parse('01/01/2022');
        ctr.ContractTerm = 12;
        contractList.add(ctr);
        Test.startTest();
        List<Contract> contractCreated = ContractManager.insertContractsFromList(contractList);
        Test.stopTest();
        system.assertEquals(contractList.size(),[SELECT COUNT() FROM Contract WHERE AccountId =: acc.Id]);
    }
    
    @isTest
    public static void testGetContractIds() {
        List<Contract> contractList = [SELECT Id FROM Contract];
        Test.startTest();
        List<Id> contractIds = ContractManager.getContractIds(contractList);
        Test.stopTest();
        system.assertEquals(contractList.size(),contractIds.size());
    }
}