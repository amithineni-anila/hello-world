trigger CaseOwnerUpdate on Case (before update) {
    
    for(case newcase : Trigger.new){
        if(newcase.status=='Escalated'){
            newcase.OwnerId=System.Label.High_Priority;
        }
    }

}