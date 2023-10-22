@isTest
public with sharing class TestRejectDoubleBooking {
     @isTest
    static void testTestCase() {
        // Test data setup
        DateTime now = System.now();

        Speaker__c speaker = new Speaker__c(First_Name__c = 'first', Last_Name__c = 'Last');
        insert speaker;
        Session__c session = new Session__c(Name = 'test session', Session_Date__c = now);
        insert session;

        Session_Speaker__c assign = new Session_Speaker__c(Session__c = session.Id, Speaker__c = speaker.Id);
        // Actual test
        Test.startTest();
        Database.SaveResult result = Database.insert(assign, false);
        Test.stopTest();
    
        // Asserts
        System.assert(result.isSuccess());
    } static testmethod void TestRejectDoubleBooking(){
        DateTime now = System.now();

        Speaker__c speaker = new Speaker__c(First_Name__c = 'first', Last_Name__c = 'Last');
        insert speaker;
        Session__c session1 = new Session__c(Name = 'test session 1', Session_Date__c = now);
        insert session1;
        Session__c session2 = new Session__c(Name = 'test session 2', Session_Date__c = now);
        insert session2;

        Session_Speaker__c assign1 = new Session_Speaker__c(Session__c = session1.Id, Speaker__c = speaker.Id);
        Session_Speaker__c assign2 = new Session_Speaker__c(Session__c = session2.Id, Speaker__c = speaker.Id);
        // Actual test
        Test.startTest();
        Database.SaveResult result = Database.insert(assign2, false);
        Test.stopTest();
    
        // Asserts
        System.assert(!result.isSuccess());
    }
}