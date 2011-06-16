# Ti.SMS.SMSDialog

## Description

An SMS dialog that can be shown to the user.

## Functions

### open

Opens a new SMS message to send.  Takes one argument, a dictionary with the 'animated'
boolean property.

## Properties

### Ti.SMS.SENT

Constant indicating the message was sent.

### Ti.SMS.CANCELLED

Constant indicating the message send was cancelled.

### Ti.SMS.FAILED

Constant indicating the message send failed.

### Ti.SMS.toRecipients[array]

The recipients to send to.  Phone numbers should be a string of numbers without
separators.

### Ti.SMS.messageBody[string]

The message of the body.

### Ti.SMS.barColor[object]

Any object representing a color, which is used for the bar display.

## Events

### complete

An event sent upon completion or failure of sending the message.  Event dictionary
contains the properties:

* result[int]: One of _Ti.SMS.SENT_, _Ti.SMS.CANCELLED_, _Ti.SMS.FAILED_
* success[boolean]: true if the send succeeded
* error[string]: Only in the case of an error; the error message.