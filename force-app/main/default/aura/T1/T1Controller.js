({  
   doInit:function(component,event,helper){  
       console.log('doInit Called');
     var action = component.get("c.getFiles");  
     action.setParams({  
       "recordId":component.get("v.recordId")  
     });      
     action.setCallback(this,function(response){  
         console.log('setCallback Called');
       var state = response.getState();  
       if(state=='SUCCESS'){  
         var result = response.getReturnValue();  
         console.log('result: ' +result);  
         component.set("v.files",result);  
       }  
     });  
       console.log('Before enqueue Action');
     $A.enqueueAction(action);  
   } ,  
   //Open File onclick event  
   OpenFile :function(component,event,helper){  
     var rec_id = event.currentTarget.id;  
     $A.get('e.lightning:openFiles').fire({ //Lightning Openfiles event  
       recordIds: [rec_id] //file id  
     });  
   },
    
   UploadFinished : function(component, event, helper) { 
     console.log('Upload Finished Called');
     var uploadedFiles = event.getParam("files");  
     var fileName = uploadedFiles[0].name;   
     var toastEvent = $A.get("e.force:showToast");  
     toastEvent.setParams({  
       "title": "Success!",  
       "message": "File "+fileName+" Uploaded successfully."  
     });  
     toastEvent.fire();
//     var action=document.location.reload(true);
//       action.fire();
   },  
 })