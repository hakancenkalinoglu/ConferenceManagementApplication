trigger RejectDoubleBooking on Session_Speaker__c (before insert, after update) {
    for(Session_Speaker__c sessionSpeaker : Trigger.new){
        Session_c  session = [SELECT Id, Session_Date__c FROM Session__c
                                WHERE Id =: sessionSpeaker.Session__c];

    List<Session_Speaker__c> conflicts = [
        SELECT Id FROM Session_Speaker__c WHERE Speaker__c = :sessionSpeaker.Session_Date__c
                                        AND Session__r.Session_Date__c =: session.Session_Date__c
    ];

    if(!conflicts.isEmpty()){
        sessionSpeaker.addError('The Speaker is already booked at that time');
    }
    }
}