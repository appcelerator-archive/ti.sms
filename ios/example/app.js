var win = Ti.UI.createWindow({
    backgroundColor: "#fff"
});

var btn = Ti.UI.createButton({
    title: "Show SMS Dialog!"
});

btn.addEventListener("click", function() {
    showSMSDialog();
});

win.add(btn);
win.open();

/**
 *  Shows the native SMS dialog
 **/
function showSMSDialog() {
    var SMS = require('ti.sms');
    
    var SMSDialog = SMS.createSMSDialog({
        barColor: "black",
        toRecipients: ["1234567890", "0987654321"],
        subject: "What's up?",
        messageBody: "Titanium rocks! 🔥"
    });
        
    if (!SMS.canSendText()) {
        Ti.API.error("Device cannot send SMS!");
        return;
    }
    
    if (!SMS.canSendSubject()) {
        Ti.API.error("Device cannot send subject!");
        return;
    }
    
    if (!SMS.canSendAttachments()) {
        Ti.API.error("Device cannot send attachments!");
        return;
    } else {
        SMSDialog.addAttachments([Ti.Filesystem.getFile(Ti.Filesystem.getResourcesDirectory(), "KS_nav_ui.png").read()])
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

    SMSDialog.open({
        animated: true
    });
}