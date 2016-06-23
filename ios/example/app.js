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
    
    if (!SMS.canSendText()) {
        Ti.API.error("This device cannot send SMS messages!");
        return;
    }

    var SMSDialog = SMS.createSMSDialog({
        animated: true,
        barColor: "black",
        toRecipients: ["1234567890", "0987654321"],
        subject: "What's up?",
        messageBody: "Titanium rocks!"
    });

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
}