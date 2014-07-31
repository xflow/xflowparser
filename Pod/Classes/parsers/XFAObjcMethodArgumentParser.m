//
//  XFAMethodArgumentParser.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/28/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFAObjcMethodArgumentParser.h"
#import "XFAObjcMethodArgument.h"
#import <RegExCategories.h>

@implementation XFAObjcMethodArgumentParser

-(XFAObjcMethodArgument *)parseArgument:(NSString*)str
{
    // @"([a-zA-Z0-9]*)[ \t]*(:)[ \t]*\(([a-zA-Z0-9 \*\^\(\)<>]+)\)[ \t]*([a-zA-Z0-9]*)";
    NSString * pattern =
    @"([a-zA-Z0-9_]*)"
    @"[ \\t]*(:)[ \\t]*"
    @"\\(([a-zA-Z0-9_ \\*\\^\\(\\)<>,]+)\\)[ \\t]*([a-zA-Z0-9_]*)";
    
    RxMatch * match = [str firstMatchWithDetails:RX(pattern)];
    NSAssert(match, @"no match detected");
    XFAObjcMethodArgument * arg = XFAObjcMethodArgument.new;
    NSArray * grps = match.groups;
    
    RxMatchGroup * grp1 = [grps objectAtIndex:1];
    arg.argumentName = grp1.value;
    
    RxMatchGroup * grp2Colon = [grps objectAtIndex:2];// the colon
    NSAssert(grp2Colon, @"colon not found");
    
    RxMatchGroup * grp3 = [grps objectAtIndex:3];
    arg.objcType =  [grp3.value stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceCharacterSet]];
    
    RxMatchGroup * grp4 = [grps objectAtIndex:4];
    arg.variableName = grp4.value;
    
    arg.index = 0;
    
    
    if ([arg.objcType isMatch:RX(@"\\^")]){
        NSString * tmp = arg.objcType;
        arg.objcType = @"^";
        arg.isNSObject = YES;
        arg.isBlock = YES;
        arg.block = tmp;
        arg.objcPointerType = XFAObjcPointerTypeBlock;
    }
    else if ([arg.objcType isMatch:RX(@"\\*")])
    {
        arg.objcType = [arg.objcType replace:RX(@"[ \t]*\\*") with:@" *"];
        arg.isNSObject = YES;
        arg.objcPointerType = XFAObjcPointerTypeKnown;
    }
    else if ([arg.objcType isMatch:RX(@"^id")])
    {
        arg.isNSObject = YES;
        arg.objcPointerType = XFAObjcPointerTypeUnknown;
        
        if ([arg.objcType isMatch:RX(@"<")] && [arg.objcType isMatch:RX(@">$")]) {
            arg.objcProtocolNames = [XFAObjcMethodArgumentParser extractProtocolNames:arg.objcType];
            arg.objcType = @"id";
        }
        
    }
    else if ([arg.objcType isMatch:RX(@"^instancetype$")])
    {
        arg.isNSObject = YES;
        arg.objcPointerType = XFAObjcPointerTypeInstanceType;
    }
    else if ([arg.objcType isMatch:RX(@"^Class")])
    {
        arg.isNSObject = YES;
        arg.objcPointerType = XFAObjcPointerTypeClass;
        
        if ([arg.objcType isMatch:RX(@"<")] && [arg.objcType isMatch:RX(@">$")]) {
            arg.objcProtocolNames = [XFAObjcMethodArgumentParser extractProtocolNames:arg.objcType];
            arg.objcType = @"Class";
        }
    }
    else
    {
        arg.isNSObject = NO;
        arg.objcPointerType = XFAObjcPointerTypeNone;
    }
    
    

    return arg;
}



+(NSArray*)extractProtocolNames:(NSString*)objcType{
    RxMatch * match = [objcType firstMatchWithDetails:RX(@"<([a-zA-Z][a-zA-Z0-9_,]+)?>")];
    NSAssert(match, @"no match detected");
    RxMatchGroup * grp = [match.groups objectAtIndex:1];
    NSArray * splited = [grp.value split:RX(@",")];
    NSArray * arr = [NSArray array];
    for (NSString * prtcl in splited) {
        arr = [arr arrayByAddingObject:prtcl];
    }
    return arr;
    
}

@end
