//
//  XFAObjcMethodParser.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/29/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XFPObjcMethod;

@interface XFPObjcMethodParser : NSObject

-(XFPObjcMethod*)parseMethod:(NSString*)str;


@end
