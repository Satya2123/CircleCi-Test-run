public class FileController {

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
    public static Id save(Id parentId, String fileName, String base64Data, String contentType) { 
         ContentVersion contentVersion = new ContentVersion();
    	contentVersion.ContentLocation = 'S'; // S = Stored in Salesforce
    	contentVersion.PathOnClient = fileName;
   		 contentVersion.Title = fileName;
   		 contentVersion.VersionData = EncodingUtil.base64Decode(base64Data);
        insert contentVersion;
    return contentVersion.id;
    }
}