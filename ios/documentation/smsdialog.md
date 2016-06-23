# Ti.SMS.SMSDialog

## Description

An SMS dialog that can be shown to the user.

## Functions

### open

Opens a new SMS message to send. Takes a number of properties explained below.

## Properties

### Ti.SMS.SMSDialog.SENT

Constant indicating the message was sent.

### Ti.SMS.SMSDialog.CANCELLED

Constant indicating the message send was cancelled.

### Ti.SMS.SMSDialog.FAILED

Constant indicating the message send failed.

### Ti.SMS.SMSDialog.toRecipients[array]

The recipients to send to.  Phone numbers should be a string of numbers without
separators.

### Ti.SMS.SMSDialog.messageBody[string]

The message of the body.

### Ti.SMS.SMSDialog.subject[string]

The subject of the body.

### Ti.SMS.SMSDialog.attachments[array]

The message attachments of the body. Must be a TiBlob.

### Ti.SMS.SMSDialog.barColor[object]

Any object representing a color, which is used for the bar display.

### Ti.SMS.SMSDialog.canSendText[boolean]

Returns a boolean to indicate if the user can send text messages.

### Ti.SMS.SMSDialog.canSendSubject[boolean]

Returns a boolean to indicate if the user can send a subject.

### Ti.SMS.SMSDialog.canSendAttachments[boolean]

Returns a boolean to indicate if the user can send attachments.

## Events

### complete

An event sent upon completion or failure of sending the message.  Event dictionary
contains the properties:

* result[int]: One of _Ti.SMS.SMSDialog.SENT_, _Ti.SMS.SMSDialog.CANCELLED_, _Ti.SMS.SMSDialog.FAILED_
* success[boolean]: true if the send succeeded
* error[string]: Only in the case of an error; the error message.