//
//  XFAMethodSignatureParser.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/30/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFAObjcMethodSignatureParser.h"
#import "XFAObjcMethodSignature.h"
#import "XFAObjcMethod.h"
#import "XFAObjcTypeEncoding.h"
#import "XFAObjcMethodArgument.h"

@implementation XFAObjcMethodSignatureParser


-(XFAObjcMethodSignature*)parseMethod:(XFAObjcMethod*)method;
{
    XFAObjcMethodSignature * signature = [XFAObjcMethodSignature new];

    
    NSInteger counter = 4;
    NSString * name = method.methodName;
    NSString * encoding = @"@0:4";
    for (XFAObjcMethodArgument * arg in method.methodArguments) {
        if (counter == 4) {
            name = [name stringByAppendingString:@":"];
        } else {
             name = [name stringByAppendingFormat:@"%@:",arg.argumentName];
        }

        counter += 4;
        NSString * argEnc = [XFAObjcTypeEncoding of:arg.objcType];
        encoding = [encoding stringByAppendingFormat:@"%@%ld",argEnc,counter];
        
    }
    
    
    NSString * returnEncoding = [XFAObjcTypeEncoding of:method.returnObjcType];
    encoding = [NSString stringWithFormat:@"%@%ld%@",returnEncoding,(counter+4),encoding];
    signature.signatureName = name;
    signature.signatureEncoding = encoding;
    
    return signature;
}

@end
