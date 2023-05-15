@isTest
public with sharing class CreateContractsTest {
    @TestSetup static void setup(){
        Account acc = TestDataFactory.createAccount('TestAccount');
        Contract ctr = new Contract();
        ctr.AccountId = acc.Id;
        ctr.Status = 'Draft';
        ctr.StartDate = date.parse('01/01/2022');
        ctr.ContractTerm = 12;
        insert ctr;
    }
    @isTest
    public static void testCreateContractsFromJson() {
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();  
        request.requestUri ='https://mindful-shark-6cwgay-dev-ed.trailblaze.my.salesforce.com/services/apexrest/CreateContracts';
        request.httpMethod = 'POST';
        String jsonStr = '{"records" : [{"attributes" : {"type" : "Contract"},"AccountName" : "TestAccount","Status" : "Draft","StartDate" :"01/01/2022","ContractTerm" : 12}]}';
        request.requestBody = Blob.valueof(jsonStr);
        RestContext.request = request;
        RestContext.response = response;
        Test.startTest();
        List<Id> createdContractIds = CreateContracts.createContractsFromJson();
        Test.stopTest();
        system.assertEquals(1,createdContractIds.size());
    }
}