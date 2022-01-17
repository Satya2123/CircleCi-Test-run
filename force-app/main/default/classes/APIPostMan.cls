public class APIPostMan {
    public static void GetAllData( ) {
        	
    		Http http = new Http();
   			HttpRequest req = new HttpRequest();
    		req.setEndpoint('https://api.covid19api.com/country/south-africa/status/confirmed/live?from=2020-03-01T00:00:00Z&to=2020-05-11T00:00:00Z');
    		req.setMethod('GET');
            req.setHeader('Content-Type', 'application/json');
    		HttpResponse res = http.send(req);
            string responseJSON = res.getBody();
			System.debug('HttpResponse'+responseJSON);
        
        
    }
}