public with sharing class SpeakerControllerExtension {
    public blob picture {get; set;}
    public String errorMessage {get; set;}

    private final Speaker__c speaker;
    private ApexPages.StandardController std;

    public SpeakerControllerExtension(ApexPages.StandardController std) {
        this.speaker = (Speaker__c)std.getRecord();
        this.std = std;
    }

    public PageReference save(){
        errorMessage = '';
       try {
        upsert speaker; //CHECK HERE
        if(picture != null){
            Attachment attachment = new Attachment();
            attachment.Body = picture;
            attachment.Name = 'spekaer_' + speaker.id + 'jpg';
            attachment.ParentId = speaker.id;
            attachment.ContentType = 'application/jpg';
            insert attachment;
            speaker.Picture_Path__c = '/servlet/servlet.FileDownload?file=' + attachment.Id;
            update speaker;
        }
        return new ApexPages.StandardController(speaker).view();
       }
       catch (Exception ex) {
        errorMessage=ex.getMessage();
        return null;
       }
    }
}