@IsTest
public class DailyLeadProcessorTest {

    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    @testSetup
    static void setup() {
        List<Lead> leads = new List<Lead>();
        for(Integer i = 0; i < 200; i++) {
            leads.add(new Lead(LastName = 'lead' + i, Company = 'company' + i));
        }
        insert leads;
    }
    
    @IsTest
    static void test() {
        Test.startTest();
        String jobId = System.schedule('Daily Update Lead Source', CRON_EXP, new DailyLeadProcessor());
        List<Lead> leadsBefore = [Select Id from Lead where LeadSource = 'Dreamforce'];
        System.assertEquals(0, leadsBefore.size());
        Test.stopTest();
        
        List<Lead> leadsAfter = [Select Id from Lead where LeadSource = 'Dreamforce'];
        System.assertEquals(200, leadsAfter.size());
    }
    
}