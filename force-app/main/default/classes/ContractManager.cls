public class ContractManager {
                               
    public static List<String> getAccountNamesFromWrapper(ContractWrapper recordLists) {
        List<String> accountsNames = new List<String>();
    	for (ContractWrapper.CtrWrapper ctr : recordLists.records) {
            accountsNames.add(ctr.AccountName);
        }
        return accountsNames;
    } 

    public static ContractWrapper updateRecordListWithAccountId(ContractWrapper recordList,List<Account> accountList) {
        for (ContractWrapper.ctrWrapper ctr : recordList.records) {
            for (Account acc : accountList ) {
                if (ctr.AccountName == acc.Name) {
                    ctr.AccountId = acc.Id;
                }
            }     
        } 
         return recordList;
    }

    public static List<Contract> getContractsFromWrapper(ContractWrapper recordList) {
        List<Contract> contractList = new List<Contract>();
        for (ContractWrapper.CtrWrapper ctrWrap : recordList.records) {
            if (ctrWrap.attributes.type == 'Contract') {
                Contract ctr = new Contract();
                if (ctrWrap.AccountId!=null) {
                    ctr.AccountId = ctrWrap.AccountId;
                }
                if (ctrWrap.SalesforceId!=null) {
                    ctr.Id = ctrWrap.SalesforceId;
                }
                if (ctrWrap.Status!=null) {
                    ctr.Status = ctrWrap.Status;
                }
                if (ctrWrap.StartDate!=null) {
                    ctr.StartDate = date.parse(ctrWrap.StartDate);
                }
                if (ctrWrap.ContractTerm!=null) {
                    ctr.ContractTerm = ctrWrap.ContractTerm;
                }
                if (ctrWrap.Description!=null) {
                    ctr.Description = ctrWrap.Description;
                }
                contractList.add(ctr);
            }          
        }
        return contractList;
    }

    public static List<Id> getContractIdsFromContractList(List<Contract> contractList) {
        List<Id> contractIds = new List<Id>();
        for (Contract ctr : contractList) {
            contractIds.add(ctr.AccountId);
        }
        return contractIds;
    }
    
    public static List<Contract> insertContractsFromList(List<Contract> contractList) {
    	insert contractList;
        return contractList;
    }
        
    public static List<Id> getContractIds(List<Contract> contractList) {
    	List<Id> contractIds = new List<Id>(); 
        for (Contract ctr : contractList) {
            contractIds.add(ctr.Id); 
        }
        return contractIds;
    }    
}