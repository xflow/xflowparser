//
//  XFAMethodSignatureParser.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/30/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFPObjcMethodSignatureParser.h"
#import "XFPObjcMethodSignature.h"
#import "XFPObjcMethod.h"
#import "XFPObjcTypeEncoding.h"
#import "XFPObjcMethodArgument.h"

@implementation XFPObjcMethodSignatureParser


-(XFPObjcMethodSignature*)parseMethod:(XFPObjcMethod*)method;
{
    XFPObjcMethodSignature * signature = [XFPObjcMethodSignature new];

    
    NSInteger counter = 4;
    NSString * name = method.methodName;
    NSString * encoding = @"@0:4";
    for (XFPObjcMethodArgument * arg in method.methodArguments) {
        if (counter == 4) {
            name = [name stringByAppendingString:@":"];
        } else {
             name = [name stringByAppendingFormat:@"%@:",arg.argumentName];
        }

        counter += 4;
        NSString * argEnc = [XFPObjcTypeEncoding of:arg.objcType];
        encoding = [encoding stringByAppendingFormat:@"%@%ld",argEnc,counter];
        
    }
    
    
    NSString * returnEncoding = [XFPObjcTypeEncoding of:method.returnObjcType];
    encoding = [NSString stringWithFormat:@"%@%ld%@",returnEncoding,(counter+4),encoding];
    signature.signatureName = name;
    signature.signatureEncoding = encoding;
    
    return signature;
}

@end
