//
//  XFAMethodSignatureParser.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/30/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XFPObjcMethodSignature;
@class XFPObjcMethod;

@interface XFPObjcMethodSignatureParser : NSObject


-(XFPObjcMethodSignature*)parseMethod:(XFPObjcMethod*)method;

@end
