//
//  XFAMethodArgumentParser.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/28/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XFPObjcMethodArgument;

@interface XFPObjcMethodArgumentParser : NSObject

-(XFPObjcMethodArgument *)parseArgument:(NSString*)str;

@end
