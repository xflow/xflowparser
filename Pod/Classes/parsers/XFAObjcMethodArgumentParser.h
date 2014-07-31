//
//  XFAMethodArgumentParser.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/28/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XFAObjcMethodArgument;

@interface XFAObjcMethodArgumentParser : NSObject

-(XFAObjcMethodArgument *)parseArgument:(NSString*)str;

@end
