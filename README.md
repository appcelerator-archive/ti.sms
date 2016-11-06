# Ti.SMS

 Summary
---------------
Ti.SMS is an open-source project to support the native iOS SMS dialog in Appcelerator's Titanium Mobile. The module currently supports the following API's:
- [x] Setting dialog subject and message
- [x] Styling the dialog
- [x] Add SMS attachements
- [x] Check SMS capabilities
- [x] Get notified about the sending status

Requirements
---------------
  - Titanium Mobile SDK 3.4.1.GA or later
  - iOS 7.1 or later
  - Xcode 6.4 or later
  
Download + Setup
---------------

### Download
  * [Stable release](https://github.com/appcelerator-archive/ti.sms/releases)
  * Install from gitTio    <a href="http://gitt.io/component/ti.sms" target="_blank"><img src="http://gitt.io/badge@2x.png" width="120" height="18" alt="Available on gitTio" /></a>

### Setup
Unpack the module and place it inside the `modules/iphone/` folder of your project.
Edit the modules section of your `tiapp.xml` file to include this module:
```xml
<modules>
    <module platform="iphone">ti.sms</module>
</modules>
```

Example
---------------

```js
var SMS = require('ti.sms');
    
var SMSDialog = SMS.createSMSDialog({
    barColor: "black",
    toRecipients: ["1234567890", "0987654321"],
    messageBody: "Titanium rocks! 🔥"
});
        
if (!SMS.canSendText()) {
    Ti.API.error("Device cannot send SMS!");
    return;
}

SMSDialog.addEventListener('complete', function(e) {
    if (e.success) {
        alert('SMS sent!');
    } else {
        switch (e.result) {
            case SMS.CANCELLED:
                alert('User cancelled SMS!');
                break;
            case SMS.FAILED:
            default:
                alert(e.error);
        }
    }
});

SMSDialog.open();
```
Legal
---------------
This module is Copyright (c) 2010-2016 by Appcelerator, Inc. All Rights Reserved. Usage of this module is subject to 
the Terms of Service agreement with Appcelerator, Inc.  
