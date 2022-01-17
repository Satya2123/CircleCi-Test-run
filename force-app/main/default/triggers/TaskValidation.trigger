trigger TaskValidation on Task (before insert,before update) {
    List<Task> relToCaseTasks = new List<Task>(); // store tasks that are related to cases
    Set<Id> caseIds = new Set<Id>(); // store the ids of the Case to which tasks are related to
    Map<Id, Case> idToCaseRecMap = new Map<Id, Case>(); // map to hold the case with their id as the key
    
    
    for(Task var : Trigger.new){
        if(var.WhatId != null){
            System.debug('------INSIDE IF---------');
            System.debug(var.WhatId);
            if(String.valueOf(var.whatId).startsWith('5002')){ // check if the task is related to an case
                relToCaseTasks.add(var); // if yes then hold that task in a list
                caseIds.add(var.whatId); // also store the id of the case record
            }
        }
    }

    for(Case c : [SELECT Id, Status FROM case WHERE Id IN:caseIds])
    {	
        idToCaseRecMap.put(c.Id, c);
        System.debug(idToCaseRecMap.get(c.Id));
    }
    
    if(relToCaseTasks != null && relToCaseTasks.size() > 0){
        if(idToCaseRecMap != null){
            for(Task var : relToCaseTasks){ // iterate over the selected task records  
                Case cs = new case();
                cs = idToCaseRecMap.get(var.WhatId); // get the corresponding task record from the map
                if(cs.Status=='Closed'){ // Check Status
                    var.addError('Cannot create Task if the Case is Closed');
                }                        
            }
        }
    }
    
    
}