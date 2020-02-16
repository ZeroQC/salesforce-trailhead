public class AddPrimaryContact implements Queueable {

    private Contact primaryContact;
    private String stateAbbr;
    
    public AddPrimaryContact(Contact contact, String stateAbbr) {
        this.primaryContact = contact;
        this.stateAbbr = stateAbbr;
    }
    
    public void execute(QueueableContext context) {
        List<Contact> contacts = new List<Contact>();
        List<Account> accounts = [Select Id from Account where BillingState = :stateAbbr limit 200];
        for(Account account: accounts) {
            Contact contact = primaryContact.clone();
            contact.AccountId = account.Id;
            contacts.add(contact);
        }
        insert contacts;
    }
    
}