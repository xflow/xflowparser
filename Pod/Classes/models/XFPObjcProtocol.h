//
//  XFAObjcProtocol.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFPModel.h"

@interface XFPObjcProtocol : XFPModel

@property (nonatomic, strong) NSString * headerFilePath;

@property (nonatomic, strong) NSMutableArray * methods;

@property (nonatomic, strong) NSMutableArray * properties;

@property (nonatomic, strong) NSString * protocolName;

@end
