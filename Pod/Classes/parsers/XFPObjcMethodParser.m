//
//  XFAObjcMethodParser.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/29/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFPObjcMethodParser.h"
#import "XFPObjcMethod.h"
#import <RegExCategories.h>
#import "XFPObjcMethodArgumentParser.h"
@class XFPObjcMethodArgument;

@implementation XFPObjcMethodParser

-(XFPObjcMethod*)parseMethod:(NSString*)str
{
    XFPObjcMethod * method = [XFPObjcMethod new];
    
    NSString * pattern = @"^[ \\t]*([-+])[ \\t]*\\(([a-zA-Z0-9\\* <>]*)\\)[ \\t]*([a-zA-Z0-9]*)(.*)$";;
    RxMatch * match = [str firstMatchWithDetails:RX(pattern)];
    NSAssert(match, @"no match detected");
    NSArray * first_parts = match.groups;
    RxMatchGroup * grp1 = [first_parts objectAtIndex:1];
    method.isClassMethod = [grp1.value isEqualToString:@"+"];

    RxMatchGroup * grp2 = [first_parts objectAtIndex:2];
    method.returnObjcType = grp2.value;
    
    RxMatchGroup * grp3 = [first_parts objectAtIndex:3];
    method.methodName = grp3.value;
    
    RxMatchGroup * grp4 = [first_parts objectAtIndex:4];
    
    NSString * second_parts_str = grp4.value;
    
    NSString * pattern2 = @"[a-zA-Z0-9]*:[ \\t]*\\([a-zA-Z0-9 \\*\\^\\(\\)<>]+\\)[a-zA-Z0-9]+";

    NSArray * argsStrings = [second_parts_str matches:RX(pattern2)];
    
    for (NSString * argString in argsStrings) {
        XFPObjcMethodArgumentParser * argParser = [XFPObjcMethodArgumentParser new];
        XFPObjcMethodArgument * arg = [argParser parseArgument:argString];
        [method addMethodArgument:arg];
    }
    
    return method;
    
}

@end
