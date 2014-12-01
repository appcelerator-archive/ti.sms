/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2010 by Appcelerator, Inc. All Rights Reserved.
 */
#import "TiModule.h"
#import "TiUISMSDialogProxy.h"

@interface TiSmsModule : TiModule 
{
    TiUISMSDialogProxy *smsProxy;
}
@property (nonatomic, retain)   TiUISMSDialogProxy *smsProxy;

-(TiUISMSDialogProxy *)createSMSDialog:(id)args;

@end
