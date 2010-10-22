# ti.sms.SMSDialog

## Description

An _sms_ module object which represents an SMS message.

## Reference

## Functions

### open

Opens a new SMS message to send.  Takes one argument, a dictionary with the 'animated'
boolean property.

## Properties

### ti.sms.SENT

Constant indicating the message was sent.

### ti.sms.CANCELLED

Constant indicating the message send was cancelled.

### ti.sms.FAILED

Constant indicating the message send failed.

### ti.sms.toRecipients[array]

The recipients to send to.  Phone numbers should be a string of numbers without
seperators.

### ti.sms.messageBody[string]

The message of the body.

### ti.sms.barColor[object]

Any object representing a color, which is used for the bar display.

## Events

### complete

An event sent upon completion or failure of sending the message.  Event dictionary
contains the properties:

result[int]: One of _ti.sms.SENT_, _ti.sms_CANCELLED_, _ti.sms.FAILED_  
success[boolean]: true if the send succeeded  
error[string]: Only in the case of an error; the error message.