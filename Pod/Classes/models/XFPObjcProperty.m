//
//  XFAObjcProperty.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFPObjcProperty.h"

@implementation XFPObjcProperty

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"iosAvailableFromVersion" : @"kukuwawa",
             @"propertyName" : @"propertyName",
             @"objcType" : @"objcType",
             @"attributes" : [NSNull null]
             };
}

/*
// http://stackoverflow.com/questions/18961622/how-to-omit-null-values-in-json-dictionary-using-mantle
- (NSDictionary *)dictionaryValue {
    NSMutableDictionary *modifiedDictionaryValue = [[super dictionaryValue] mutableCopy];
    
    for (NSString *originalKey in [super dictionaryValue]) {
        if ([self valueForKey:originalKey] == nil) {
            [modifiedDictionaryValue removeObjectForKey:originalKey];
        }
    }
//    if ([[self valueForKey:@"address"] isEqualToValue:0]) {
//        [modifiedDictionaryValue removeObjectForKey:@"address"];
//    }
//    [modifiedDictionaryValue removeObjectForKey:@"attributes"];
    
    return [modifiedDictionaryValue copy];
}
*/

@end
