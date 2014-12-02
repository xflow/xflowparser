//
//  XFAObjcHeaderFile.h
//  xflow
//
//  Created by Mohammed Tillawy on 5/2/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Mantle.h>

@interface XFPObjcHeaderFile : NSObject <MTLJSONSerializing>

@property (nonatomic, strong) NSString * filePath;

@property (nonatomic, readonly) NSArray * objcClassNames;

@property (nonatomic, readonly) NSArray * objcClasses;

@property (nonatomic, readonly) NSArray * objcProtocols;

@end
