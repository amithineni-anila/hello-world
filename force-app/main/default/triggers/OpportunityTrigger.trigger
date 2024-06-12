trigger OpportunityTrigger on Opportunity (After insert,After update) {
     
    if((Trigger.isAfter && Trigger.isInsert) || (Trigger.isAfter && Trigger.isUpdate)){
        List<case> caseList1= new List<case>();
        for(opportunity opp1 : Trigger.new){
           if(opp1.StageName=='Qualification')
           { 
                ID Id1=opp1.Id;
               List<case> Lcase = [SELECT Id from case where Opportunityid__c = :Id1 AND status !='closed'];
               if(Lcase.size()>0){
                    System.debug('case already exist');  
                }
               else{
                      case newcase1=new case();
                      newcase1.AccountId=opp1.AccountId;
                      newcase1.Case_name__c=opp1.name;
                      newcase1.Status= 'NEW';
                      newcase1.Origin='Email';
                      newcase1.OwnerId=System.Label.Low_Priority_queue;
            
                      RecordType  RecordTypeName1= [select  id ,sObjecttype from RecordType  where SobjectType='Case' AND  DeveloperName = 'caseA4' ]; 
                      newcase1.RecordTypeid=RecordTypeName1.id;
                      newcase1.Opportunityid__c= opp1.id;
               
                      caseList1.add(newcase1); }
               }}
              if(caseList1.size()>0){
            System.debug(caseList1);
                insert caseList1;
            
        }}}