trigger CloseCase on Case (after update) {
    Map<Id, Task> taskMap = new Map<Id, Task>(); //create a map of open tasks related to the cases

      //query open tasks related to cases and populate map
    for( Task t : [SELECT Id, WhatId FROM Task WHERE IsClosed=false AND WhatId IN :trigger.newMap.keySet()])
    {	
       taskMap.put(t.WhatId, t);
            System.debug(taskMap);
    }

    //iterate through updated cases and add errors if open tasks exist
    for(Case c : Trigger.new)
    {
        System.debug(taskMap.containsKey(c.Id));
        System.debug(c.IsClosed);
        System.debug(Trigger.oldMap.get(c.Id).IsClosed);
  
        //check if the case has any open tasks and has just been changed to closed
        if(taskMap.containsKey(c.Id) && c.IsClosed && c.IsClosed != Trigger.oldMap.get(c.Id).IsClosed)
            c.addError('You cannot close the case untill you close all the task');
    }
}