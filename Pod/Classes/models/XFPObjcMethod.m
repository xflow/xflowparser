//
//  XFAObjcMethod.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFPObjcMethod.h"
#import "XFPObjcMethodSignatureParser.h"
#import "XFPObjcMethodSignature.h"
#import "XFPObjcMethodArgument.h"

@interface XFPObjcMethod(){
    
}
@property (nonatomic,strong) XFPObjcMethodSignature * methodSignature;
@property (nonatomic,strong) NSArray * methodArguments;
@property (nonatomic,strong) NSString * signature;
@property (nonatomic,strong) NSString * encoding;

@end

@implementation XFPObjcMethod

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
    XFPObjcMethodSignatureParser * parser = [XFPObjcMethodSignatureParser new];
    self.methodSignature = [parser parseMethod:self];
    self.signature = self.methodSignature.signatureName;
    self.encoding =  self.methodSignature.signatureEncoding;
}


+ (NSValueTransformer *)methodSignatureJSONTransformer {
    Class k = [XFPObjcMethodSignature class];
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:k];
}



+ (NSValueTransformer *)methodArgumentsJSONTransformer {
    Class k = [XFPObjcMethodArgument class];
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:k];
}



-(void)addMethodArgument:(XFPObjcMethodArgument*)arg
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
