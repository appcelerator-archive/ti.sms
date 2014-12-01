/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2010 by Appcelerator, Inc. All Rights Reserved.
 */
#import "TiUISMSDialogProxy.h"

#import "TiBase.h"
#import "TiUtils.h"
#import "TiApp.h"

@implementation TiUISMSDialogProxy

- (id)isSupported:(id)args
{
    return NUMBOOL([MFMessageComposeViewController canSendText]);
}

- (void)open:(id)args
{
    NSLog(@"trying to open");
    ENSURE_TYPE_OR_NIL(args,NSDictionary);
    Class arrayClass = [NSArray class];
    NSArray * toArray = [self valueForUndefinedKey:@"toRecipients"];
    ENSURE_CLASS_OR_NIL(toArray,arrayClass);
    
    ENSURE_UI_THREAD(open,args);

    NSString * message = [TiUtils stringValue:[self valueForUndefinedKey:@"messageBody"]];

    if (![MFMessageComposeViewController canSendText])
    {
        NSLog(@"can't send text");
        NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:NUMINT(MessageComposeResultFailed),@"result",
                               NUMBOOL(NO),@"success",
                               @"system can't send email",@"error",
                               nil];
        [self fireEvent:@"complete" withObject:event];
        return;
    }

    UIColor * barColor = [[TiUtils colorValue:[self valueForUndefinedKey:@"barColor"]] _color];
    
    MFMessageComposeViewController * composer = [[MFMessageComposeViewController alloc] init];
    [composer setMessageComposeDelegate:self];
    if (barColor != nil)
    {
        [[composer navigationBar] setTintColor:barColor];
    }
    
    [composer setRecipients:toArray];
    [composer setBody:message];
    
    BOOL animated = [TiUtils boolValue:@"animated" properties:args def:YES];
    [self retain];
    [[TiApp app] showModalController:composer animated:animated];
    
    
}


MAKE_SYSTEM_PROP(SENT,MessageComposeResultSent);
MAKE_SYSTEM_PROP(CANCELLED,MessageComposeResultCancelled);
MAKE_SYSTEM_PROP(FAILED,MessageComposeResultFailed);


#pragma mark Delegate 

- (void)messageComposeViewController:(MFMessageComposeViewController *)composer didFinishWithResult:(MessageComposeResult)result  {
    
    BOOL animated = YES;
    
    [[TiApp app] hideModalController:composer animated:animated];
    [composer autorelease];
    composer = nil;
    if ([self _hasListeners:@"complete"])
    {
        NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:NUMINT(result),@"result",
                               NUMBOOL(result==MessageComposeResultSent),@"success",
                               nil];
        [self fireEvent:@"complete" withObject:event];
    }
    [self autorelease];    
}

@end