public class FileUploadControllerv1 {
public transient Attachment objAttachment;
    //Use getter so we can make attachment transient
    public Attachment getObjAttachment(){
        objAttachment = new Attachment();
        return objAttachment;
    }
    public Boolean fileUploadProcessed{get;set;}
    public String message{get;set;}
    public String messageType{get;set;}
    
    Public void uploadFile(){
        try {
            objAttachment.ParentId = (Id) ApexPages.currentPage().getParameters().get('id');
            insert objAttachment;
            message = 'File was uploaded successfully';
            messageType = 'success';
        }catch(Exception e){
            message = e.getMessage();
            messageType = 'error';
        }
        fileUploadProcessed = true;
    }
}