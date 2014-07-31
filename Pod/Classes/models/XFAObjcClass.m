//
//  XFAObjcClass.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFAObjcClass.h"
@interface XFAObjcClass(){
    
}

@end

@implementation XFAObjcClass

- (instancetype)init
{
    self = [super init];
    if (self) {
        _methods = NSMutableArray.new;
        _properties = NSMutableArray.new;
    }
    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"headerFilePath"  :   @"headerFilePath",
             @"className"       :   @"className",
             @"superClassName"  :   @"superClassName",
             @"methods"         :   @"methods",
             @"properties"      :   @"properties",
             };
}

@end
