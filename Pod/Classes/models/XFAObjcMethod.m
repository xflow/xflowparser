//
//  XFAObjcMethod.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFAObjcMethod.h"
#import "XFAObjcMethodSignatureParser.h"
#import "XFAObjcMethodSignature.h"

@interface XFAObjcMethod(){
    
}

@end

@implementation XFAObjcMethod

- (instancetype)init
{
    self = [super init];
    if (self) {
        _methodArguments = [NSArray array];
    }
    return self;
}

-(void)addMethodArgument:(XFAObjcMethodArgument*)arg
{
    _methodArguments = [_methodArguments arrayByAddingObject:arg];
}


-(XFAObjcMethodSignature *)methodSignature
{
    XFAObjcMethodSignatureParser * parser = XFAObjcMethodSignatureParser.new;
    XFAObjcMethodSignature * sign = [parser parseMethod:self];
    return sign;
}


-(NSString*)signature{
    return self.methodSignature.signatureName;
}

-(NSString*)encoding{
    return self.methodSignature.signatureEncoding;
}


@end
