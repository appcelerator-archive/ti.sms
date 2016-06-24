/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2010 by Appcelerator, Inc. All Rights Reserved.
 */
#import "TiProxy.h"
#import <MessageUI/MessageUI.h>

@interface TiSmsSMSDialogProxy : TiProxy<MFMessageComposeViewControllerDelegate> {
    MFMessageComposeViewController *smsDialog;
}

- (void)open:(id)args;

@end
