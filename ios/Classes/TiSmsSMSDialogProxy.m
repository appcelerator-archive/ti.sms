/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2010 by Appcelerator, Inc. All Rights Reserved.
 */
#import "TiSmsSMSDialogProxy.h"

#import "TiBase.h"
#import "TiUtils.h"
#import "TiApp.h"

@implementation TiSmsSMSDialogProxy

- (id)isSupported:(id)unused
{
    DEPRECATED_REPLACED(@"Ti.SMS.isSupported", @"2.0.0", @"Ti.SMS.canSendtext");
    
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

- (void)open:(id)args
{
    // Ensure that the current device supports SMS
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
    
    // Ensure the correct thread and arguments
    ENSURE_UI_THREAD(open, args);
    ENSURE_TYPE_OR_NIL(args, NSDictionary);
    
    // Prepare the arguments
    NSNumber *disableUserAttachments;
    NSArray *toRecipients;
    NSArray *attachements;
    NSString *message;
    NSString *subject;
    NSString *barColor;
    
    // Validate the user-input
    ENSURE_ARG_OR_NIL_FOR_KEY(toRecipients, args, @"toRecipients", NSArray);
    ENSURE_ARG_OR_NIL_FOR_KEY(disableUserAttachments, args, @"disableUserAttachments", NSNumber);
    ENSURE_ARG_OR_NIL_FOR_KEY(attachements, args, @"attachements", NSArray);
    ENSURE_ARG_OR_NIL_FOR_KEY(message, args, @"messageBody", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(subject, args, @"subject", NSString);
    ENSURE_ARG_OR_NIL_FOR_KEY(barColor, args, @"barColor", NSString);
    
    // Create the SMS dialog
    MFMessageComposeViewController * composer = [MFMessageComposeViewController new];
    [composer setMessageComposeDelegate:self];
    
    // Set the barColor
    if (barColor != nil) {
        [[composer navigationBar] setTintColor:[[TiUtils colorValue:barColor] _color]];
    }
    
    // Check if the user wants to disable attachments
    if (disableUserAttachments != nil && [TiUtils boolValue:disableUserAttachments def:NO] == YES) {
        [composer disableUserAttachments];
    }
    
    // Set the attachments
    if (attachements != nil) {
        for (id attachement in attachements) {
            if (![attachement isKindOfClass:[TiBlob class]]) {
                DebugLog(@"[ERROR] Ti.SMS: Cannot add attachment of type: %@", [attachement apiName]);
            } else {
                [composer addAttachmentData:[(TiBlob*)attachement data]
                             typeIdentifier:@"public.data"
                                   filename:[(TiBlob*)attachement nativePath]];
            }
        }
    }
    
    // Set the recipients
    [composer setRecipients:toRecipients];
    
    // Set the subject
    [composer setSubject:subject];
    
    // Set the message body
    [composer setBody:message];
    
    // Show the SMS dialog
    BOOL animated = [TiUtils boolValue:@"animated" properties:args def:YES];
    [self retain];
    [[TiApp app] showModalController:composer animated:animated];
}

#pragma mark Delegate 

- (void)messageComposeViewController:(MFMessageComposeViewController *)composer didFinishWithResult:(MessageComposeResult)result
{
    [[TiApp app] hideModalController:composer animated:YES];
    
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
