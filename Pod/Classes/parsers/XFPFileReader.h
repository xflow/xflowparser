//
//  XFAFileReader.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/26/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XFPObjcClass;

@interface XFPFileReader : NSObject

-(NSArray *)linesOfFile:(NSURL*)url;


-(NSArray*)linesOfSection:(NSString*)sectionType
              sectionName:(NSString*)sectionName
          sectionCategory:(NSString*)sectionCategory
                     file:(NSURL*)url;

-(NSArray*)namesForSectionType:(NSString*)type inFile:(NSURL*)fileUrl;

-(NSArray*)filterMethodLines:(NSArray*)lines;

-(NSArray*)filterPropertyLines:(NSArray *)lines;

-(NSArray*)classNamesInLines:(NSArray*)lines;

-(NSArray*)protocolNamesInLines:(NSArray*)lines;

-(NSDictionary *)classesDictionaryInLines:(NSArray*)lines;

-(NSArray*)categoriesOfClassNamed:(NSString*)name inLines:(NSArray*)lines;

-(XFPObjcClass*)classNamed:(NSString*)className inFile:(NSURL*)url;

@end
