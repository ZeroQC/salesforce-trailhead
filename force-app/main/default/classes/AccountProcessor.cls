global class AccountProcessor {
	@future
    public static void countContacts(List<Id> accountIds) {
        List<Account> accounts = [Select Id, Number_of_Contacts__c from Account where Id IN :accountIds];
        for(Account account: accounts) {
            List<Contact> contacts = [Select Id from Contact where AccountId = :account.Id];
            account.Number_of_Contacts__c = contacts.size();
        }
        update accounts;
    }
}