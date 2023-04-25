public class ContractSelector {
   public static List<Account> selectAccountsUsingNames(List<String> accountNameList) {
    List<Account> accounts = [SELECT Name,Id FROM Account WHERE Name IN : accountNameList];
    return accounts;     
    }
}