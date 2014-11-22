//
//  XFAObjcMethod.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Mantle/Mantle.h>

@class XFAObjcMethodArgument;
@class XFAObjcMethodSignature;
@class XFAObjcClass;

@interface XFAObjcMethod :  MTLModel <MTLJSONSerializing>

@property (nonatomic,readonly) XFAObjcMethodSignature * methodSignature;
@property (nonatomic,readonly) NSString * signature;
@property (nonatomic,readonly) NSString * encoding;

@property (nonatomic,strong) NSString * methodName; // objcName //
@property (nonatomic,strong) NSString * returnObjcType;

@property (nonatomic,assign) BOOL isNSObject; // return
@property (nonatomic,strong) NSArray * objcTypeProtocolNames; // return;
@property (nonatomic,assign) BOOL isOptionalByObjcProtocol;

@property (nonatomic,strong) NSString * objcCategory;

@property (nonatomic,strong) NSNumber * iosAvailableFromVersion;
@property (nonatomic,strong) NSNumber * iosAvailableToVersion;
@property (nonatomic,strong) NSNumber * osxAvailableFromVersion;
@property (nonatomic,strong) NSNumber * osxAvailableToVersion;

@property (nonatomic,assign) BOOL isClassMethod;

@property (nonatomic,assign) BOOL isOnlyIOS;
@property (nonatomic,assign) BOOL isOnlyOSX;

@property (nonatomic,readonly) NSInteger numberOfArguments; // readonly
@property (nonatomic,readonly) BOOL isVariableNumberOfArguments; // readonly
@property (nonatomic,assign) BOOL isInterceptable; //
@property (nonatomic,assign) BOOL isInherited;
@property (nonatomic,assign) NSInteger childEntryArgumentIndex; //

@property (nonatomic,readonly) NSArray * methodArguments;

-(void)addMethodArgument:(XFAObjcMethodArgument*)arg;



@end
