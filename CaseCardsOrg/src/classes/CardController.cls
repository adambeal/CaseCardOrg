public class CardController
{    
    //Get all cases and build lists per case status then put each list in a map with status as the key
    public static Map<String, List<Case>> getCasesMap()
    {
        Map<String, List<Case>> casesMap = new Map<String, List<Case>>();
        List<Case> developmentCases = new List<Case>(); 
        List<Case> testingCases = new List<Case>(); 
        List<Case> roadblockedCases = new List<Case>(); 
        List<Case> doneCases = new List<Case>(); 
        for(Case caseItem : [select Id, Subject, Description, Status, CaseNumber from Case])
        {
            if(caseItem.Status == 'Development')
            {
                developmentCases.add(caseItem);
            }
            if(caseItem.Status == 'Testing')
            {
                testingCases.add(caseItem);
            }
            if(caseItem.Status == 'Roadblocked')
            {
                roadblockedCases.add(caseItem);
            }
            if(caseItem.Status == 'Done')
            {
                doneCases.add(caseItem);
            }            
            
            System.debug('status:' + caseItem.Status + ' Id:' + caseItem.Id);
        }  
        casesMap.put('Development', developmentCases);        
        casesMap.put('Testing', testingCases); 
        casesMap.put('Roadblocked', roadblockedCases);
        casesMap.put('Done', doneCases);   
        return casesMap;
    }
    
    public PageReference refreshPage()
    {
        System.debug('refreshPage CALLED');
        getCasesMap();
        return null;
    }
    
    @remoteAction
     public static PageReference refreshPage2()
    {
        System.debug('refreshPage2 CALLED');
    
       getCasesMap();
        return null;
    }
    
    @remoteAction
    public static PageReference setStatus(string id, string newStatus) {
        Case caseToUpdate = [select Id from Case where id =: id];        
        caseToUpdate.Status = newStatus;
        update caseToUpdate;
        
        Map<String, List<Case>> caseMap = getCasesMap();
        for(String key : caseMap.keySet())
        { 
            System.debug('caseMap.keySet IS ' + caseMap.keySet());
            List<Case> casesList = caseMap.get(key);
            
            
            for(Case caseToSet : casesList)
            {
                System.debug('caseToSet ' + caseToSet.Subject);
                if(caseToSet.Id == id)
                {
                
                    caseToSet.Status = newStatus;
                    update caseToSet;
                    System.debug('HERE ' + caseToSet.Subject);
                }
            }
            
        }
        
         PageReference newpage = NEW Pagereference('/apex/cards');
         newpage.setRedirect(true);
         return newpage;
     // getCasesMap();
        //return null;
    }
    
    public PageReference TwilioTest()
    {
        // Find your Twilio API credentials at https://www.twilio.com/user/account
        String account = 'AC9f86d3e6d8ecad471859a1f59c093452';
        String token = '9c8eeb92ceee8ccb2e584110a1fb66d7';
        
        TwilioRestClient client = new TwilioRestClient(account, token);
        
        Map<String,String> params = new Map<String,String> {
                'To'   => '+18652071469',
                'From' => '+18659739894',
                'Url'  => 'http://twimlets.com/message?Message%5B0%5D=Hi%20Amanda%20I%20LOVE%20YOU%20Love%20Jack'
                
            };
        TwilioCall call = client.getAccount().getCalls().create(params);
        return null;
    }
    
  
}