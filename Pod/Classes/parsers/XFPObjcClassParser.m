//
//  XFAObjcClassParser.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFPObjcClassParser.h"
#import <RegExCategories.h>

@implementation XFPObjcClassParser


-(NSString* )classNameFromFilename:(NSString*)fileName
{
    NSString * pattern = @".*\\/([A-Za-z]*)\\.h";
    NSError * err = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:NULL];
    NSAssert(! err, @"regex error");
    NSRange range = NSMakeRange(0, fileName.length);
    NSString * output = [regex stringByReplacingMatchesInString:fileName
                                                             options:0
                                                               range:range
                                                        withTemplate:@"$1"];
    return output;
}



-(NSString* )categoryNameForInterfaceLine:(NSString*)interfaceLine
{
    
    NSString * pattern = @"\\(([A-Z][A-Za-z0-9]+)\\)";
    RxMatch * s = [interfaceLine firstMatchWithDetails:RX(pattern)];
    NSString * output = nil;
    if (s) {
        RxMatchGroup * grp = [s.groups objectAtIndex:1];
        output = grp.value;
    }
    return output;
}


-(NSArray*)protocolNamesForInterfaceLine:(NSString*)interfaceLine{
    RxMatch * protocols_part = [interfaceLine firstMatchWithDetails:RX(@"<([a-zA-Z0-9_, \\t]*)>")];
    RxMatch * ma = [protocols_part.groups lastObject];
    NSAssert(ma , @"no match detected");
    NSArray * protocol_names = [ma.value split:RX(@"[ \t]*,[ \t]*")];
    return protocol_names;
}


-(NSString *)classNameForInterfaceLine:(NSString*)interfaceLine{
    RxMatch * match = [interfaceLine firstMatchWithDetails:RX(@"@interface[ \\t]*([a-zA-Z0-9_]*)")];
    NSAssert(match, @"no match detected");
    RxMatchGroup * grp = [match.groups lastObject];
    return grp.value;
}


@end
