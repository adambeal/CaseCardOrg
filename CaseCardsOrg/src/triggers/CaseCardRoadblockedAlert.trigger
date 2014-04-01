trigger CaseCardRoadblockedAlert on Case (after update) {        
     for (Case caseItem : Trigger.new)
     {       
        if(caseItem.Status == 'Roadblocked')
        {  
            CaseCardNotifications.SendAlert(caseItem.Product_Manager__r.Phone,'Case ' + caseItem.CaseNumber + ' has been changed to a status of Roadblocked');
        }
     }  
}