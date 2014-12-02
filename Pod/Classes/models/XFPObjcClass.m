//
//  XFAObjcClass.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFPObjcClass.h"
#import "XFPObjcProperty.h"
#import "XFPObjcMethod.h"

@interface XFPObjcClass(){
    
}

@end

@implementation XFPObjcClass

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
    Class k = [XFPObjcProperty class];
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:k];
}


+ (NSValueTransformer *)methodsJSONTransformer {
    Class k = [XFPObjcMethod class];
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:k];
}


@end
