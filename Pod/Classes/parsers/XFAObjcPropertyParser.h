//
//  XFAObjcPropertyParser.h
//  xflow
//
//  Created by Mohammed Tillawy on 5/2/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XFAObjcProperty;

@interface XFAObjcPropertyParser : NSObject

-(XFAObjcProperty *)parseProperty:(NSString*)p;


@end
