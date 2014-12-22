trigger Attachment on Attachment (before insert) {

    Messaging.SingleEmailMessage deletionEmail = new Messaging.SingleEmailMessage();
    deletionEmail.setToAddresses( new List<String>{ 'sean.cuevo@bluewolfgroup.com' } );
    deletionEmail.setPlainTextBody( 'yeah!');
    Messaging.sendEmail( new List<Messaging.Email> { deletionEmail } );
}