//
//  Created by ANDREW GLOVER on 8/30/11.
//  Copyright 2011 App47 All rights reserved.
//

#import "App47PGPlugin.h"
#import "EmbeddedAgent.h"

//#ifdef PHONEGAP_FRAMEWORK
#import <Cordova/CDVPluginResult.h>
//#else
//#import "CDVPluginResult.h"
//#endif


@implementation App47PGPlugin


-(void)configurationValue:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult* pluginResult = nil;
    NSDictionary* options = [command.arguments objectAtIndex:0];
    @try
    {
        NSString* key = [options objectForKey:@"key"];
        NSString* group = [options objectForKey:@"group"];
        id obj = [EmbeddedAgent configurationObjectForKey:key group:group];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:obj];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    }
    @catch (NSException *ex) 
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR  messageAsString:[ex reason]];
    }
}

- (void) log:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult* pluginResult = nil;
    NSDictionary* options = [command.arguments objectAtIndex:0];
    @try 
    {
        
        NSString* logType = [options objectForKey:@"type"];
        if([logType isEqualToString:@"info"])
        {
            EALogInfo(@"%@",[options objectForKey:@"msg"]); 
        }
        else if([logType isEqualToString:@"warn"])
        {
            EALogWarn(@"%@",[options objectForKey:@"msg"]);
        }
        else if([logType isEqualToString:@"error"])
        {
            EALogError(@"%@",[options objectForKey:@"msg"]);
        }
        else //must be debug
        {
            EALogDebug(@"%@",[options objectForKey:@"msg"]); 
        }
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    @catch (NSException *ex)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR  messageAsString:[ex reason]];
    }
}

-(void)sendGenericEvent:(CDVInvokedUrlCommand *)command  
{
    CDVPluginResult* pluginResult = nil;
    @try
    {
        
        NSString *eventName = [command.arguments objectAtIndex:0]; 
        [EmbeddedAgent sendGenericEvent:eventName];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    @catch (NSException *ex) 
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR  messageAsString:[ex reason]];
    }
}

- (void)startTimedEvent:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult* pluginResult = nil;
    @try
    {
        NSString *eventName = [command.arguments objectAtIndex:0];
        NSString *eventID = [EmbeddedAgent startTimedEvent:eventName];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:eventID];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    @catch (NSException *ex) 
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR  messageAsString:[ex reason]];
    }
    
}

- (void)endTimedEvent:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult* pluginResult = nil;
    @try
    {
        NSString *eventName = [command.arguments objectAtIndex:0];
        [EmbeddedAgent endTimedEvent:eventName];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    @catch (NSException *ex) 
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR  messageAsString:[ex reason]];
    }
}


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end

