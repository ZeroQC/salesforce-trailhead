global class LeadProcessor implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
    	return Database.getQueryLocator('Select Id, LeadSource from Lead');    
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> leads) {
        for(Lead lead: leads) {
            lead.LeadSource = 'Dreamforce';
        }
        update leads;
    }
    
    global void finish(Database.BatchableContext bc) {
        AsyncApexJob job = [Select Id, Status, NumberOfErrors, JobItemsProcessed,
                            TotalJobItems from AsyncApexJob where Id= :bc.getJobId()];
        System.debug('Job: ' + job);
    }
    
}