//
//  XFAModel.m
//  xflow
//
//  Created by Mohammed Tillawy on 11/23/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//


#import "XFAModel.h"

@interface XFAModel(){
    
}

@end



@implementation XFAModel



// http://stackoverflow.com/questions/18961622/how-to-omit-null-values-in-json-dictionary-using-mantle

- (NSDictionary *)dictionaryValue {
    NSMutableDictionary *modifiedDictionaryValue = [[super dictionaryValue] mutableCopy];
    
    for (NSString *originalKey in [super dictionaryValue]) {
        if ([self valueForKey:originalKey] == nil) {
            [modifiedDictionaryValue removeObjectForKey:originalKey];
        }
    }
    
    return [modifiedDictionaryValue copy];
}


@end
