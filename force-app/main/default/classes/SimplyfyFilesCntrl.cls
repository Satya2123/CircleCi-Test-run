public class SimplyfyFilesCntrl {  
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
        return DocumentList;  
    }  
    @AuraEnabled  
    public static List<ContentDocument> UpdateFiles(string documentId,string recordId){  
        //     system.debug('title: ' +title);  
        //ContentDocument cd = [select id,title from ContentDocument where Id=:documentId]; // Getting files from Parent record 
        //     cd.Title = title;  // Changing file Title with user entered title
        //try{  
        //    update cd;  // Update ContentDocument (File)
        //}  
        //catch(DMLException e){  
        //    system.debug('Exception has occurred! ' +e.getMessage());  
        //}  
        system.debug('----Inside Update------');
        List<ContentDocument> DocumentList = new List<ContentDocument>();  
        Set<Id> documentIds = new Set<Id>();  
        List<ContentDocumentLink> cdl=[select id,LinkedEntityId,ContentDocumentId from ContentDocumentLink where LinkedEntityId=:recordId];  
        for(ContentDocumentLink cdLink:cdl){  
            documentIds.add(cdLink.ContentDocumentId);  
        }      
        DocumentList = [select Id,Title,FileType,ContentSize,CreatedDate from ContentDocument where id IN: documentIds];
        system.debug('----Before Exit From UpdateFiles------');
        return DocumentList;  // Return list of files on parent record
    }  
}