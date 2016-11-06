/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2010-2016 by Appcelerator, Inc. All Rights Reserved.
 */
#import "TiSmsModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiSmsModule

#pragma mark Internal

- (id)moduleGUID
{
	return @"8b8759be-a92a-4c44-a6d2-3e08393bfc36";
}

- (NSString*)moduleId
{
	return @"ti.sms";
}

#pragma mark Lifecycle

- (void)startup
{
	[super startup];
	
	NSLog(@"[DEBUG] %@ loaded",self);
}

#pragma Public APIs

- (id)isSupported:(id)unused
{
    DEPRECATED_REPLACED(@"SMS.isSupported", @"2.0.0", @"SMS.canSendtext");
    
    return [self canSendText:unused];
}

- (id)canSendText:(id)unused
{
    return NUMBOOL([MFMessageComposeViewController canSendText]);
}

- (id)canSendSubject:(id)unused
{
    return NUMBOOL([MFMessageComposeViewController canSendSubject]);
}

- (id)canSendAttachments:(id)unused
{
    return NUMBOOL([MFMessageComposeViewController canSendAttachments]);
}

@end
