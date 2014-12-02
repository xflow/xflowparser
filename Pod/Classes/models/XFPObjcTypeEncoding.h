//
//  XFAXFATypeEncoding.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/30/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFPObjcTypeEncoding : NSObject

@property (nonatomic,strong) NSString * encoding;

+(NSString*)of:(NSString*)typeName;

+(NSString*)extractType:(NSString*)varDeclaration;

+(BOOL)isObjcType:(NSString*)name;

@end
