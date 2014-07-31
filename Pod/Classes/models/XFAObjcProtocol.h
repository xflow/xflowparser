//
//  XFAObjcProtocol.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Mantle.h>

@interface XFAObjcProtocol :  MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString * headerFilePath;

@property (nonatomic, strong) NSString * protocolName;

@property (nonatomic, readonly) NSArray * methods;

@end
