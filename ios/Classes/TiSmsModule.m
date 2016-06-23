/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2010 by Appcelerator, Inc. All Rights Reserved.
 */
#import "TiSmsModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiSmsModule

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

#pragma Public APIs

-(TiSmsSMSDialogProxy*)createSMSDialog:(id)args {
    return [[[TiSmsSMSDialogProxy alloc] _initWithPageContext:[self pageContext]] autorelease];
}

@end
