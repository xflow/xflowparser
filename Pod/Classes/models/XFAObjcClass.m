//
//  XFAObjcClass.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFAObjcClass.h"
#import "XFAObjcProperty.h"
#import "XFAObjcMethod.h"

@interface XFAObjcClass(){
    
}

@end

@implementation XFAObjcClass

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.methods = NSMutableArray.new;
        self.properties = NSMutableArray.new;
    }
    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"headerFilePath"  :   @"headerFilePath",
             @"className"       :   @"className",
             @"superClassName"  :   @"superClassName",
             @"isSubclassesCrawlable" : NSNull.null,
             };
}



+ (NSValueTransformer *)propertiesJSONTransformer {
    Class k = [XFAObjcProperty class];
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:k];
}


+ (NSValueTransformer *)methodsJSONTransformer {
    Class k = [XFAObjcMethod class];
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:k];
}


@end
