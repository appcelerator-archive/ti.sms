# Ti.SMS.SMSDialog

## Description

An SMS dialog that can be shown to the user.

## Methods

### open

Opens a new SMS message to send. Takes a number of properties explained below.

### addAttachments([array])

The message attachments. Must be a TiBlob.

## Properties

### Ti.SMS.SENT

Constant indicating the message was sent.

### Ti.SMS.CANCELLED

Constant indicating the message send was cancelled.

### Ti.SMS.FAILED

Constant indicating the message send failed.

### Ti.SMS.SMSDialog.toRecipients[array]

The recipients to send to.  Phone numbers should be a string of numbers without
separators.

### Ti.SMS.SMSDialog.messageBody[string]

The message of the SMS message.

### Ti.SMS.SMSDialog.subject[string]

The subject of the SMS message.

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

* result[int]: One of _Ti.SMS.SENT_, _Ti.SMS.CANCELLED_, _Ti.SMS.FAILED_
* success[boolean]: true if the send succeeded
* error[string]: Only in the case of an error; the error message.