//
//  XFAObjcPropertyParser.h
//  xflow
//
//  Created by Mohammed Tillawy on 5/2/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XFPObjcProperty;

@interface XFPObjcPropertyParser : NSObject

-(XFPObjcProperty *)parseProperty:(NSString*)p;


@end
