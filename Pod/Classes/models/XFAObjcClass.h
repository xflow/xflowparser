//
//  XFAObjcClass.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Mantle.h>

@interface XFAObjcClass : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString * headerFilePath;
@property (nonatomic, strong) NSString * className;
@property (nonatomic, assign) BOOL isCrawleable;
@property (nonatomic, assign) BOOL isSubclassesCrawlable;
@property (nonatomic, strong) NSString * superClassName;
@property (nonatomic, strong) NSString * childrenKey;


@property (nonatomic, readonly) NSArray * methods;
@property (nonatomic, readonly) NSArray * properties;

@end
