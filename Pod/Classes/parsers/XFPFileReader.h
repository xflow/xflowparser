//
//  XFAFileReader.h
//  xflow
//
//  Created by Mohammed Tillawy on 4/26/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XFPObjcClass;
@class XFPObjcProtocol;

@interface XFPFileReader : NSObject

-(NSArray *)linesOfFile:(NSURL*)url;


-(NSArray*)linesOfSection:(NSString*)sectionType
              sectionName:(NSString*)sectionName
          sectionCategory:(NSString*)sectionCategory
                     file:(NSURL*)url;

-(NSArray*)namesForSectionType:(NSString*)type inFile:(NSURL*)fileUrl;

-(NSArray*)filterProtocolMethodLines:(NSArray*)lines;
-(NSArray*)filterMethodLines:(NSArray*)lines;

-(NSArray*)filterPropertyLines:(NSArray *)lines;

-(NSArray*)classNamesInLines:(NSArray*)lines;

-(NSArray*)protocolNamesInLines:(NSArray*)lines;

-(NSDictionary *)classesDictionaryInLines:(NSArray*)lines;

-(NSArray*)categoriesOfClassNamed:(NSString*)name inLines:(NSArray*)lines;

-(XFPObjcProtocol*)protocolNamed:(NSString*)protocolName inFile:(NSURL*)url;

-(XFPObjcClass*)classNamed:(NSString*)className  withCategory:(NSString*)categoryName inFile:(NSURL*)url;

@end
