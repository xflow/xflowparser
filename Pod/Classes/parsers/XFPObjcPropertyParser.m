//
//  XFAObjcPropertyParser.m
//  xflow
//
//  Created by Mohammed Tillawy on 5/2/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFPObjcPropertyParser.h"
#import "XFPObjcProperty.h"
#import <RegExCategories.h>
#import "XFPObjcTypeEncoding.h"

@implementation XFPObjcPropertyParser

-(XFPObjcProperty *) parseProperty:(NSString*)str
{
    XFPObjcProperty * property = [XFPObjcProperty new];
    
    str = [str replace:RX(@"\\/\\*.*\\*\\/") with:@""];
    str = [str replace:RX(@"//.*$") with:@""];
    str = [str replace:RX(@",[ \\t]*") with:@","];
    str = [str replace:RX(@"[ \\t]*,") with:@","];
    
    str = [str replace:RX(@"=[ \\t]*") with:@"="];
    str = [str replace:RX(@"[ \\t]*=") with:@"="];
    
    NSString * pattern = @"@property[ \\t]*"
    "(\\(?[a-zA-Z0-9_,<>=\\*\\\\/]*\\))?"
    "[ \\t]*([A-Za-z0-9]*)[ \\t]*"
    "(\\*)?"
    "(<[a-zA-Z0-9_,]*>)?"
    "[ \\t]*([A-Za-z0-9_]*)";
    
    property.isBlockPointer = [str isMatch:RX(@"\\^")];
    
    RxMatch * matchAttributes = [str firstMatchWithDetails:RX(pattern)];
    
    RxMatchGroup * grp = [matchAttributes.groups objectAtIndex:1];
    NSString * attributesString = grp.value;
    attributesString = [attributesString replace:RX(@"[\\(\\)]") with:@""];
    NSArray * attributesArray = [attributesString split:RX(@",")];

    property.attributes = attributesArray;
  
    NSLog(@"attributes:%@",property.attributes);
    
    RxMatchGroup * grp2Type = [matchAttributes.groups objectAtIndex:2];
    NSLog(@"type:%@",grp2Type.value);
    property.objcType = grp2Type.value;
    
    RxMatchGroup * grp3Star = [matchAttributes.groups objectAtIndex:3];
    NSLog(@"*:%@",grp3Star.value);
    
    if ([grp3Star.value isEqualToString:@"*"]) {
        property.objcType = [property.objcType stringByAppendingString:@" *"];
    }
    
    property.isNSObject = [XFPObjcTypeEncoding isObjcType:property.objcType];
    
    RxMatchGroup * grp4Protocols = [matchAttributes.groups objectAtIndex:4];
    NSString * protocolsString = [grp4Protocols.value replace:RX(@"[<>]") with:@""];
    NSArray * protocols = [protocolsString split:RX(@",")];
    property.objcTypeProtocolNames = protocols;
    
    RxMatchGroup * grp5Name = [matchAttributes.groups objectAtIndex:5];
    NSLog(@"name: %@",grp5Name.value);
    property.propertyName = grp5Name.value;
    
    property.isDeprecated = [str isMatch:RX(@"DEPRECATED")];
    
    RxMatch * deprecatedMatch = [str firstMatchWithDetails:RX(@"NS_DEPRECATED_IOS\\((.*)\\)")];
    
    RxMatchGroup * deprecatedMatchGroup1 = [deprecatedMatch.groups objectAtIndex:1];
    NSArray * deprecatedParts = [deprecatedMatchGroup1.value split:RX(@",")];
    NSLog(@"deprecatedParts:%@",deprecatedParts);

    if (deprecatedParts.count > 0) {
        NSString * from = [deprecatedParts objectAtIndex:0];
        NSString * from2 = [from replace:RX(@"_") with:@"."];
        property.iosAvailableFromVersion = @([from2 floatValue]);
    }
    if (deprecatedParts.count > 1) {
        NSString * to = [deprecatedParts objectAtIndex:1];
        NSString * to2 = [to replace:RX(@"_") with:@"."];
        property.iosAvailableToVersion = @([to2 floatValue]);
    }
    if (deprecatedParts.count > 2) {
        NSString * comment = [deprecatedParts objectAtIndex:2];
        property.iosDeprecationComment = comment;
    }
    
    
    property.isOnlyIOS = [str isMatch:RX(@"NS_NONATOMIC_IOSONLY")];
    
    if ( [str isMatch:RX(@"NS_AVAILABLE_IOS")]) {
        RxMatch * match = [str firstMatchWithDetails:RX(@"NS_AVAILABLE_IOS\\(([0-9_]*)\\)")];
        RxMatchGroup * grpFrom = [match.groups objectAtIndex:1];
        NSString * from2 = [grpFrom.value replace:RX(@"_") with:@"."];
        property.iosAvailableFromVersion = @([from2 floatValue]);

    }
    
    return property;
    
}

@end
