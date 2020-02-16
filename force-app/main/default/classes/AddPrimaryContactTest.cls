@IsTest
public class AddPrimaryContactTest {

    @testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        for(Integer i = 0; i < 50; i++) {
            accounts.add(new Account(Name = 'NY' + i, BillingState = 'NY'));
            accounts.add(new Account(Name = 'CA' + i, BillingState = 'CA'));
        }
        insert accounts;
    }
    
    @IsTest
    static void test() {
        Contact contact = new Contact(LastName = 'Primary');
        
        Test.startTest();
        AddPrimaryContact queueJob = new AddPrimaryContact(contact, 'CA');
        System.enqueueJob(queueJob);
        Test.stopTest();
        
        List<Contact> contacts = [Select Id from Contact where LastName = 'Primary'];
        System.assertEquals(50, contacts.size());
    }
    
}