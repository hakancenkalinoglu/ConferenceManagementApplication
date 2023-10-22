trigger SendConfirmtionEmail on Session_Speaker__c (after insert) {
    for(Session_Speaker__c newItem : trigger.new){
        Session_Speaker__c sessionSpeaker = [
            SELECT Session__r.Name,
                    Session__r.Session_Date__c,
                    Speaker__r.First_Name__c,
                    Speaker__r.Last_Name__c
                    Speaker__r.Email__c
                    FROM Session_Speaker__c WHERE Id =: newItem.Id
        ];
    }

    //send email if we have email
    if(sessionSpeaker.Speaker__r.Email__c != null){
        String address = sessionSpeaker.Speaker__r.Email__c;
        String subject = 'Dear' + sessionSpeaker.Speaker__r.First_Name__c
        + ' on ' + sessionSpeaker.Session__r.Session_Date__c + ' is confirmed.\n\n' + 
        'Thanks to speaking on conference!';
        EmailManager.sendMail(address, subject, body);
    

    }

}