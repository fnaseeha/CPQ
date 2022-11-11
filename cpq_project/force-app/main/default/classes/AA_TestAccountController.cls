@isTest
public class AA_TestAccountController {
    public static void createAccounts(Integer amount) {
        List<Account> accounts = new List<Account>();

        for (Integer i = 1; i <= amount; i++) {
            accounts.add(new Account(Name = 'Name ' + i));
        }

        insert accounts;
    }

    @isTest
    static void getAccountList() {
        AA_TestAccountController.createAccounts(5);

     //   Test.startTest();
        List<Account> accts = AA_AccountController.getAccountList();
       // Test.stopTest();

        System.assertEquals(accts.size(), 5);
    }

    @isTest
    static void getSingleAccount() {
        AA_TestAccountController.createAccounts(1);

     //   Test.startTest();
        Account acc = AA_AccountController.getSingleAccount();
       // Test.stopTest();

        System.assertEquals(acc.Name, 'Name 1');
    }
}