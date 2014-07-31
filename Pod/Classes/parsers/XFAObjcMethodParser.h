//
//  XFAObjcMethodParser.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/29/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XFAObjcMethod;

@interface XFAObjcMethodParser : NSObject

-(XFAObjcMethod*)parseMethod:(NSString*)str;


@end
