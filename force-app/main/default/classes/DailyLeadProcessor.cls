global class DailyLeadProcessor implements Schedulable {

    global void execute(SchedulableContext ctx) {
        List<Lead> leads = [Select Id, LeadSource from Lead where LeadSource = null limit 200];
        for(Lead lead: leads) {
            lead.LeadSource = 'Dreamforce';
        }
        update leads;
    }
    
}