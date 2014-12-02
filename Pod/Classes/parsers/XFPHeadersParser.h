//
//  HeadersParser.h
//  HeadersParser
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFPHeadersParser : NSObject

-(NSArray*)filteredClassesLines:(NSArray*)fileLines;

@end
