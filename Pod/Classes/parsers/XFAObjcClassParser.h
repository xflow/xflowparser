//
//  XFAObjcClassParser.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFAObjcClassParser : NSObject

-(NSString* )classNameFromFilename:(NSString*)fileName;

-(NSString* )categoryNameForInterfaceLine:(NSString*)interfaceLine;

-(NSArray*)protocolNamesForInterfaceLine:(NSString*)interfaceLine;

-(NSString *)classNameForInterfaceLine:(NSString*)interfaceLine;


@end
