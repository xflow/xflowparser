//
//  XFAObjcProtocol.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFPObjcProtocol.h"

@implementation XFPObjcProtocol

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.methods = NSMutableArray.new;
        self.properties = NSMutableArray.new;
    }
    return self;
}

@end
