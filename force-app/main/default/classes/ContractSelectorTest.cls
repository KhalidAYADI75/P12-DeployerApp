@isTest
public with sharing class ContractSelectorTest {
    @TestSetup static void setup(){
        Account acc = TestDataFactory.createAccount('TestAccount');
        Account acc1 = TestDataFactory.createAccount('TestAccount1');
        List<Contract> contractList = TestDataFactory.createContractList(acc.Id);
    }
    @isTest
    public static void testSelectAccountsUsingNames() {
        List<String> accountNames = new List<String>();
        accountNames.add('TestAccount');
        accountNames.add('TestAccount1');
        Test.startTest();
        List<Account> accounts = ContractSelector.selectAccountsUsingNames(accountNames);
        Test.stopTest();
        system.assertEquals(2, [SELECT COUNT() FROM Account]);
    }
}