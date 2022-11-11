@isTest
public class ABCD_TestAccountController {
    public static void createAccounts(Integer amount) {
        List<Account> accounts = new List<Account>();

        for (Integer i = 1; i <= amount; i++) {
            accounts.add(new Account(Name = 'Name ' + i));
        }

        insert accounts;
    }

    @isTest
    static void getAccountList() {
        ABCD_TestAccountController.createAccounts(10);

       // Test.startTest();
        List<Account> accts = ABCD_AccountController.getAccountList();
        //Test.stopTest();

        System.assertEquals(accts.size(), 10);
    }

    @isTest
    static void getSingleAccount() {
        ABCD_TestAccountController.createAccounts(1);

     //   Test.startTest();
        Account acc = ABCD_AccountController.getSingleAccount();
       // Test.stopTest();

        System.assertEquals(acc.Name, 'Name 1');
    }
}