trigger OppTriggerr on Opportunity (After insert) {
    if(trigger.isAfter && Trigger.isInsert){
        
        List<case> caseList= new List<case>();
        for(opportunity opp : Trigger.new){
            if(opp.StageName=='Qualification'){
            case newcase=new case();
            newcase.AccountId=opp.AccountId;
            newcase.Case_name__c=opp.name;
            newcase.Status= 'Escalated';
            newcase.Origin='Email';
		 RecordType  RecordTypeName= [select  id ,sObjecttype from RecordType  where SobjectType='Case' AND  DeveloperName = 'caseA4' ]; 
         newcase.RecordTypeid=RecordTypeName.id;
               
            caseList.add(newcase); 
            }}
        if(caseList.size()>0){
            System.debug(caseList);
            insert caseList;
            
        }
        
    }
}