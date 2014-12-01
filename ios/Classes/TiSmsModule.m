/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2010 by Appcelerator, Inc. All Rights Reserved.
 */
#import "TiSmsModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiSmsModule

@synthesize smsProxy;

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"8b8759be-a92a-4c44-a6d2-3e08393bfc36";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.sms";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
    [smsProxy release];
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma Public APIs

-(TiUISMSDialogProxy *)createSMSDialog:(id)args {
    RELEASE_TO_NIL(smsProxy);
    smsProxy = [[TiUISMSDialogProxy alloc] init];
    return smsProxy;
}

@end
