@IsTest
public class AccountProcessorTest {
	@IsTest
    static void test() {
        Account account = new Account(Name = 'Account');
        insert account;
        Contact contact1 = new Contact(LastName = 'ContactOne', AccountId = account.Id);
        Contact contact2 = new Contact(LastName = 'ContactTwo', AccountId = account.Id);
        insert contact1;
        insert contact2;
        
        List<Id> accountIds = new List<Id>();
        accountIds.add(account.Id);
        
        Test.startTest();
        	AccountProcessor.countContacts(accountIds);
        Test.stopTest();
        
        Account accountUpdate = [Select Id, Number_of_Contacts__c from Account where Id = :account.Id];
        System.assertEquals(2, accountUpdate.Number_of_Contacts__c);
    } 
}