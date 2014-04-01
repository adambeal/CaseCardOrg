public class CaseCardNotifications {

    @future (callout=true)
    public static void SendAlert(string toPhoneNumber, string message)
    {
        //Twilio login information needed by case card notifications
        String account = 'AC9f86d3e6d8ecad471859a1f59c093452';
        String token = '9c8eeb92ceee8ccb2e584110a1fb66d7';
        
        TwilioRestClient client = new TwilioRestClient(account, token);
        
        //Twillio markup and params for sending the case card notification
        Map<String,String> params = new Map<String,String> {
                'To'   => '+1' + toPhoneNumber,
                'From' => '+18659739894',
                'Url'  => 'http://twimlets.com/message?Message%5B0%5D=' + message.replace(' ', '%20')               
            };
        TwilioCall call = client.getAccount().getCalls().create(params);
    }    
    
}