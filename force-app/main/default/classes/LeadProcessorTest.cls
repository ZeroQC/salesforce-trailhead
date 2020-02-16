@IsTest
public class LeadProcessorTest {
	@IsTest
    static void test() {
        List<Lead> leads = new List<Lead>();
        for(Integer i = 0; i < 200; i++) {
            Lead lead = new Lead(Company = 'company' + i, LastName = 'test' + i);
            leads.add(lead);
        }
        insert leads;
        
        Test.startTest();
        LeadProcessor leadProcessor = new LeadProcessor();
        Id batchId = Database.executeBatch(leadProcessor);
        Test.stopTest();
        
        List<Lead> results = [Select Id from Lead where LeadSource = 'Dreamforce'];
        System.assertEquals(200, results.size());
    }
}