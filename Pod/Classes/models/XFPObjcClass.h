//
//  XFAObjcClass.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFPModel.h"
@class XFPObjcMethod;
@class XFPObjcProperty;

@interface XFPObjcClass : XFPModel

@property (nonatomic, strong) NSString * headerFilePath;
@property (nonatomic, strong) NSString * className;
@property (nonatomic, strong) NSNumber * isCrawleable;
@property (nonatomic, strong) NSNumber * isSubclassesCrawlable;
@property (nonatomic, strong) NSString * superClassName;
@property (nonatomic, strong) NSString * childrenKey;


@property (nonatomic, strong) NSMutableArray * protocolNamesConformingTo;

@property (nonatomic, strong) NSMutableArray * methods;

@property (nonatomic, strong) NSMutableArray * properties;

@end
