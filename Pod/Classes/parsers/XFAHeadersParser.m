//
//  HeadersParser.m
//  HeadersParser
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFAHeadersParser.h"
#import <RegExCategories.h>

@implementation XFAHeadersParser

/* on the declaration, categories not included */
 
-(NSArray*)filteredClassesLines:(NSArray*)fileLines{
    NSMutableArray * output = NSMutableArray.new;
    for (NSString * line in fileLines) {
        if ([line isMatch:RX(@"@interface.*:")]) {
            [output addObject:line];
        }
    }
    return output;
}



@end
