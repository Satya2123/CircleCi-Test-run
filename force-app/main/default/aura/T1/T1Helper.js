({  
       UpdateDocument : function(component,event,Id) {  
     var action = component.get("c.UpdateFiles");  
     action.setParams({"documentId":Id, 
              "recordId": component.get("v.recordId")  
              });  
     action.setCallback(this,function(response){  
       var state = response.getState();  
       if(state=='SUCCESS'){  
         var result = response.getReturnValue();  
         console.log('Result Returned: ' +result);  
         component.find("fileName").set("v.value", " ");  
         component.set("v.files",result);  
       }  
     });  
     $A.enqueueAction(action);  
   },  
 })