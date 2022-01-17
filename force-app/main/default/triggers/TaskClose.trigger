trigger TaskClose on Task (before insert) {
      Map<Id, Task> taskMap = new Map<Id, Task>();
    for(Task t : [SELECT Id, WhatId FROM Task WHERE IsClosed=true AND WhatId IN :trigger.newMap.keySet()])
    {   
        taskMap.put(t.WhatId, t);
    }

    for(Task t : Trigger.new)
    {
        if(taskMap.containsKey(t.Id))
            t.addError('You cannot create new task');
    }
}