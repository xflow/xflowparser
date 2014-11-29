//
//  XFAObjcMethodArgument.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFAModel.h"

#import "XFAObjcPointerType.h"


@interface XFAObjcMethodArgument :  XFAModel

@property (nonatomic, strong) NSString * argumentName;
@property (nonatomic, strong) NSString * variableName;
@property (nonatomic, strong) NSString * objcType;
@property (nonatomic, assign) XFAObjcPointerType objcPointerType;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL isNSObject;
@property (nonatomic, assign) BOOL isBlock;
@property (nonatomic, strong) NSString * block;

@property (nonatomic, strong) NSArray * objcProtocolNames;


@end
