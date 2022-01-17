({
    doInit:function(component,event,helper){ 
        console.log('Do intit');
     var action = component.get("c.getFiles");  
     action.setParams({  
       "recordId":component.get("v.recordId")  
     });      
     action.setCallback(this,function(response){  
       var state = response.getState();  
       if(state=='SUCCESS'){  
         var result = response.getReturnValue();  
         console.log('result: ' +result);  
         component.set("v.files",result);  
       }  
     });  
     $A.enqueueAction(action);  
   } , 
    
	doSave : function(component, event, helper) {
        console.log('doSave');
		 if (component.find("fileId").get("v.files").length > 0) {
             console.log('Inside doSave inner if');
            helper.uploadHelper(component, event);
        } else {
            console.log('Inside doSave inner if');
            alert('Please Select a Valid File');
        }
    },
 
    handleFilesChange: function(component, event, helper) {
       console.log('handleFilesChange');
        var fileName = 'No File Selected..';
        if (event.getSource().get("v.files").length > 0) {
            console.log('inside handleFileChange:');
            fileName = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName", fileName);
	},
    
    
    
})