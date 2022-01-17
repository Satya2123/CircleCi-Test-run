@RestResource(urlMapping='/TestService/*')
global class ApiTest {
	private static final string INVALID_REQUEST = 'Invalid request';
    private static final string SUCCESS_MESSAGE = 'Working'; 
    private static final string NO_RECORD = 'No record found';
    
     @HttpPost
    global static ResponseWrapper doPost(){
        string jsonStr;
        RequestWrapper objRequestWraper = new RequestWrapper();
        
        try{
              if (RestContext.request.requestBody<>null){
                jsonStr= RestContext.request.requestBody.toString();
            }
            
            objRequestWraper = (RequestWrapper)System.JSON.deserialize(jsonStr, RequestWrapper.class);
           // System.JSON.deserialize(EncodingUtil.base64Decode(jsonStr).toString(), RequestWrapper.class);
          // objRequestWraper=(RequestWrapper)System.JSON.deserialize(EncodingUtil.base64Decode(jsonStr).toString(), RequestWrapper.class);
            if(string.isNotBlank(jsonStr)){  
               System.debug('entityId'+objRequestWraper.entityId);
                System.debug('base64Data'+objRequestWraper.base64Data);
                System.debug('fileName'+objRequestWraper.fileName);
                String base64Data=objRequestWraper.base64Data;
                //id test=FileController.saveTheFile('00Q2v00001UDtX8','Test.png',base64Data,'image/png;base64');
                id test=FileController.save('00Q2v00001UDtX8','Test.jpeg',base64Data,'image/png;base64');
                System.debug('id---->'+test); 
                return new ResponseWrapper(true,SUCCESS_MESSAGE);
            }

            
        }
        catch(Exception ex) {
            return new ResponseWrapper( false,ex.getMessage());}
        
        return new ResponseWrapper( false,INVALID_REQUEST);
    }
    
    
    
    global class ResponseWrapper{
        public string message;
        public boolean isSuccess;
        public ResponseWrapper( boolean isSuccess ,string message){
            this.isSuccess =  isSuccess;
            this.message = message;
        }
        public ResponseWrapper(){         
        }
    }
     public class RequestWrapper{
        public string entityId;
        public string base64Data;
        public string fileName;
    } 
}