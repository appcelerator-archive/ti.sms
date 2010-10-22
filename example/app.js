var window = Ti.UI.createWindow({ backgroundColor:'white' });

window.open();

var smstest = require('ti.sms');

var sms = smstest.createSMSDialog();

if (!sms.isSupported()) {
  alert("Can't send text");
} else {
  sms.toRecipients = ['5678309'];
  sms.messageBody = 'This is a text message';
  sms.open();
}
