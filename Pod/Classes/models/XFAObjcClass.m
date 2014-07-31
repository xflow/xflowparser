//
//  XFAObjcClass.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFAObjcClass.h"

@implementation XFAObjcClass

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
