/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2010 by Appcelerator, Inc. All Rights Reserved.
 */
#import "TiSmsSMSDialogProxy.h"

#import "TiBase.h"
#import "TiUtils.h"
#import "TiApp.h"

#define ENSURE_SMS_SUPPORT \
if (![MFMessageComposeViewController canSendText]) { \
    DebugLog(@"[ERROR] This device cannot send SMS messages"); \
}\

@implementation TiSmsSMSDialogProxy

- (MFMessageComposeViewController*)smsDialog
{
    if (smsDialog == nil) {
        smsDialog = [MFMessageComposeViewController new];
        [smsDialog setMessageComposeDelegate:self];
    }
    
    return smsDialog;
}

- (void)dealloc
{
    RELEASE_TO_NIL(smsDialog);
    [super dealloc];
}

#pragma mark Public API's

- (void)setSubject:(id)value
{
    ENSURE_SMS_SUPPORT
    ENSURE_TYPE(value, NSString);
    [[self smsDialog] setSubject:[TiUtils stringValue:value]];
}

- (void)setMessageBody:(id)value
{
    ENSURE_SMS_SUPPORT
    ENSURE_TYPE(value, NSString);
    [[self smsDialog] setBody:[TiUtils stringValue:value]];
}

- (void)setBarColor:(id)value
{
    ENSURE_SMS_SUPPORT
    ENSURE_TYPE(value, NSString);
    [[[self smsDialog] navigationBar] setTintColor:[[TiUtils colorValue:value] _color]];
}

- (void)setTranslucent:(id)value
{
    ENSURE_SMS_SUPPORT
    ENSURE_TYPE(value, NSNumber);
    [[[self smsDialog] navigationBar] setTranslucent:[TiUtils boolValue:value def:YES]];
}

- (void)setToRecipients:(id)value
{
    ENSURE_SMS_SUPPORT
    ENSURE_TYPE(value, NSArray);
    [[self smsDialog] setRecipients:value];
}

- (void)addAttachments:(id)args
{
    ENSURE_SMS_SUPPORT
    ENSURE_TYPE(args, NSArray);

    for (id attachement in args) {
        if (![attachement isKindOfClass:[TiBlob class]]) {
            DebugLog(@"[ERROR] Ti.SMS: Cannot add attachment of type: %@", [attachement apiName]);
        } else {
            [[self smsDialog] addAttachmentData:[(TiBlob*)attachement data]
                         typeIdentifier:@"public.data"
                               filename:[(TiBlob*)attachement nativePath]];
        }
    }
}

- (void)open:(id)args
{
    ENSURE_UI_THREAD(open, args);
    ENSURE_TYPE_OR_NIL(args, NSDictionary);

    if (![MFMessageComposeViewController canSendText]) {
        if ([self _hasListeners:@"complete"]) {
            [self fireEvent:@"complete" withObject:@{
                @"result": NUMINT(MessageComposeResultFailed),
                @"success": NUMINT(NO),
                @"error": @"This device cannot send SMS messages!",
            }];
        }
        return;
    }
    
    if ([TiUtils boolValue:[args valueForKey:@"disableUserAttachments"] def:NO] == YES) {
        [[self smsDialog] disableUserAttachments];
    }
    
    [[TiApp app] showModalController:[self smsDialog] animated:[TiUtils boolValue:[args valueForKey:@"animated"] def:YES]];
}

#pragma mark Delegate 

- (void)messageComposeViewController:(MFMessageComposeViewController *)composer didFinishWithResult:(MessageComposeResult)result
{
    [[TiApp app] hideModalController:composer animated:YES];
    RELEASE_TO_NIL(smsDialog);
    
    if ([self _hasListeners:@"complete"]) {
        [self fireEvent:@"complete" withObject:@{
            @"result": NUMINT(result),
            @"success": NUMINT(YES)
        }];
    }
}

#pragma mark Constants

MAKE_SYSTEM_PROP(SENT, MessageComposeResultSent);
MAKE_SYSTEM_PROP(CANCELLED, MessageComposeResultCancelled);
MAKE_SYSTEM_PROP(FAILED, MessageComposeResultFailed);

@end
