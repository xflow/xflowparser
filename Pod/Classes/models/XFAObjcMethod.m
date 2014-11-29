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
#import "XFAObjcMethodArgument.h"

@interface XFAObjcMethod(){
    
}
@property (nonatomic,strong) XFAObjcMethodSignature * methodSignature;
@property (nonatomic,strong) NSArray * methodArguments;
@property (nonatomic,strong) NSString * signature;
@property (nonatomic,strong) NSString * encoding;

@end

@implementation XFAObjcMethod

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.methodArguments = [NSArray array];
    }
    return self;
}


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"isInterceptable" : NSNull.null
             };
}

-(void)setMethodName:(NSString *)methodName{
    _methodName = methodName;
    [self generateMethodSignature];
}

-(void)setMethodArguments:(NSArray *)methodArguments{
    _methodArguments = methodArguments;
}

-(void)generateMethodSignature{
    XFAObjcMethodSignatureParser * parser = [XFAObjcMethodSignatureParser new];
    self.methodSignature = [parser parseMethod:self];
    self.signature = self.methodSignature.signatureName;
    self.encoding =  self.methodSignature.signatureEncoding;
}


+ (NSValueTransformer *)methodSignatureJSONTransformer {
    Class k = [XFAObjcMethodSignature class];
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:k];
}



+ (NSValueTransformer *)methodArgumentsJSONTransformer {
    Class k = [XFAObjcMethodArgument class];
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:k];
}



-(void)addMethodArgument:(XFAObjcMethodArgument*)arg
{
    _methodArguments = [_methodArguments arrayByAddingObject:arg];
    [self generateMethodSignature];
}

/*
-(XFAObjcMethodSignature *)methodSignature
{
    XFAObjcMethodSignatureParser * parser = [XFAObjcMethodSignatureParser new];
    XFAObjcMethodSignature * sign = [parser parseMethod:self];
    return sign;
}

-(NSString*)signature{
    return self.methodSignature.signatureName;
}

-(NSString*)encoding{
    return self.methodSignature.signatureEncoding;
}
*/


@end
