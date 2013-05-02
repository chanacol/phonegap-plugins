//
//
//  Created by ANDREW GLOVER on 8/30/11.
//  Copyright 2011 App47 All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <PhoneGap/PGPlugin.h>
#import <Cordova/CDVPlugin.h>

@interface App47PGPlugin : CDVPlugin

- (void) sendGenericEvent:(CDVInvokedUrlCommand *)command;
- (void) startTimedEvent:(CDVInvokedUrlCommand *)command;
- (void) endTimedEvent:(CDVInvokedUrlCommand *)command;
- (void) log:(CDVInvokedUrlCommand *)command;
- (void) configurationValue:(CDVInvokedUrlCommand *)command;

@end
 
