//
//  XFADirectoryReader.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/26/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFPDirectoryReader : NSObject

+ (NSArray *) headersUrlsInDirWithUrl:(NSURL*)urlDir;
+ (NSArray *) allUrlsInDirWithUrl:(NSURL*)urlDir;

@end
