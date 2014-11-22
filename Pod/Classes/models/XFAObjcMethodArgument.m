//
//  XFAObjcMethodArgument.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFAObjcMethodArgument.h"

@implementation XFAObjcMethodArgument

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.objcProtocolNames = NSArray.new;
    }
    return self;
}


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{ };
}

@end
