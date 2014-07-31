//
//  XFAObjcProperty.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Mantle.h>
@class XFAObjcClass;

@interface XFAObjcProperty :  MTLModel <MTLJSONSerializing>

@property (nonatomic,strong) NSString * propertyName;
@property (nonatomic,strong) NSString * objcType;

@property (nonatomic,assign) BOOL isAtomic;
@property (nonatomic,assign) BOOL isReadonly;
@property (nonatomic,assign) BOOL isReadwrite;
@property (nonatomic,assign) BOOL isCopy;
@property (nonatomic,assign) BOOL isRetain;

@property (nonatomic,assign) BOOL isAssign;
@property (nonatomic,assign) BOOL isStrong;
@property (nonatomic,assign) BOOL isWeak;
@property (nonatomic,assign) BOOL isUnsafeUnretained;

@property (nonatomic,assign) BOOL isOnlyIOS;
@property (nonatomic,assign) BOOL isOnlyOSX;

@property (nonatomic,strong) NSString * objcCategory;
@property (nonatomic,strong) NSNumber * iosAvailableFromVersion;
@property (nonatomic,strong) NSNumber * iosAvailableToVersion;
@property (nonatomic,strong) NSString * iosDeprecationComment;
@property (nonatomic,strong) NSNumber * osxAvaiableFromVersion;
@property (nonatomic,strong) NSNumber * osxAvailableToVersion;
@property (nonatomic,assign) BOOL isNSObject;
@property (nonatomic,assign) BOOL isDeprecated;
@property (nonatomic,assign) BOOL isBlockPointer;

@property (nonatomic,strong) NSArray * objcTypeProtocolNames; // conformance
@property (nonatomic,strong) NSArray * attributes;

@property (nonatomic,weak) XFAObjcClass * objcClass;

@end