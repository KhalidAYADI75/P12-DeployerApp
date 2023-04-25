@RestResource(urlMapping='/CreateContracts/*')
global class CreateContracts {
    @HttpPost
	global static List<Id> createContractsFromJson() {
        List<Id> createdContractIds = new List<Id>();
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;  
        ContractWrapper recordList =(ContractWrapper) JSON.deserialize(req.requestbody.toString(),ContractWrapper.class);
        List<String> contractAccountNames = ContractManager.getAccountNamesFromWrapper(recordList);
        List<Account> contractAccounts = ContractSelector.selectAccountsUsingNames(contractAccountNames); 
        ContractWrapper recordListUpdated = ContractManager.updateRecordListWithAccountId(recordList,contractAccounts);
        List<Contract> contractsFromJson = ContractManager.getContractsFromWrapper(recordListUpdated);
        List<Id> contractIds = ContractManager.getContractIdsFromContractList(contractsFromJson);
        List<Contract> contractsCreated = ContractManager.insertContractsFromList(contractsFromJson);
        createdContractIds = sendContractIds(res,contractIds);    
        return createdContractIds;
	}
    public static List<Id> sendContractIds(RestResponse response,List<Id> contractIds) {
        response.responseBody = Blob.valueOf('Contracts created : ' + contractIds); 
        return contractIds;
    }   
}