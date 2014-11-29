//
//  XFAObjcMethodParser.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/29/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFAObjcMethodParser.h"
#import "XFAObjcMethod.h"
#import <RegExCategories.h>
#import "XFAObjcMethodArgumentParser.h"
@class XFAObjcMethodArgument;

@implementation XFAObjcMethodParser

-(XFAObjcMethod*)parseMethod:(NSString*)str
{
    XFAObjcMethod * method = [XFAObjcMethod new];
    
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
        XFAObjcMethodArgumentParser * argParser = XFAObjcMethodArgumentParser.new;
        XFAObjcMethodArgument * arg = [argParser parseArgument:argString];
        [method addMethodArgument:arg];
    }
    
    return method;
    
}

@end
