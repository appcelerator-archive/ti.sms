/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2010 by Appcelerator, Inc. All Rights Reserved.
 */
#import "TiProxy.h"
#import <MessageUI/MessageUI.h>

@interface TiUISMSDialogProxy : TiProxy<MFMessageComposeViewControllerDelegate>
{
}

- (void)open:(id)args;


@property(nonatomic,readonly) NSNumber *SENT;
@property(nonatomic,readonly) NSNumber *CANCELLED;
@property(nonatomic,readonly) NSNumber *FAILED;

@end
