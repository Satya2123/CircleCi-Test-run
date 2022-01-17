public with sharing class FileUploadController {
@AuraEnabled
    public static Id saveChunk(Id parentId, String fileName, String base64Data, String contentType, String fileId) {
        // check if fileId id ''(Always blank in first chunk), then call the saveTheFile method,
        //  which is save the check data and return the attachemnt Id after insert, 
        //  next time (in else) we are call the appentTOFile() method
        //   for update the attachment with reamins chunks 
        System.debug('-------Debug ParentId------------'+parentId);  
        if (fileId == '') {
            fileId = saveTheFile(parentId, fileName, base64Data, contentType);
        } else {
            appendToFile(fileId, base64Data);
        }
 		System.debug('-------Debug ParentId------------'+parentId);
        return Id.valueOf(fileId);
		} 
    
@AuraEnabled   
public static Id saveTheFile(Id parentId, String fileName, String base64Data, String contentType) {
        
   		 System.debug('-------Debug ParentId in the saveTheFile------------'+parentId);
    
    	base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
 
        Attachment oAttachment = new Attachment();
        oAttachment.parentId = parentId;
 
        oAttachment.Body = EncodingUtil.base64Decode(base64Data);
        oAttachment.Name = fileName;
        oAttachment.ContentType = contentType;
 
        insert oAttachment;
 
        return oAttachment.Id;
    }
    
    private static void appendToFile(Id fileId, String base64Data) {
        System.debug('-------Debug ParentId Inside AppendID------------'+fileId);
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
 
        Attachment a = [SELECT Id, Body FROM Attachment WHERE Id =: fileId];
 
        String existingBody = EncodingUtil.base64Encode(a.Body);
        a.Body = EncodingUtil.base64Decode(existingBody + base64Data);
        update a;
    }
     @AuraEnabled  
    public static List<ContentDocument> getFiles(string recordId){ 
        system.debug('----Inside getFiles------');
        List<ContentDocument> DocumentList = new List<ContentDocument>();  
        Set<Id> documentIds = new Set<Id>();  //store file ids
        List<ContentDocumentLink> cdl=[select id,LinkedEntityId,ContentDocumentId from ContentDocumentLink where LinkedEntityId=:recordId];  
        for(ContentDocumentLink cdLink:cdl){  
            documentIds.add(cdLink.ContentDocumentId);  // Document ids
        }      
        DocumentList = [select Id,Title,FileType,ContentSize,CreatedDate from ContentDocument where id IN: documentIds];  
        system.debug('----Before returngetFiles------');
        system.debug(DocumentList);
        return DocumentList;  
    }
}