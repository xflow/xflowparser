//
//  XFADirectoryReader.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/26/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFPDirectoryReader.h"

@implementation XFPDirectoryReader

+(NSArray*)headersUrlsInDirWithUrl:(NSURL*)urlDir{
    return [XFPDirectoryReader urlsInDirWithUrl:urlDir withExtension:@".h"];
}

+(NSArray*)xcodeprojUrlsInDirWithUrl:(NSURL*)urlDir{
    return [XFPDirectoryReader urlsInDirWithUrl:urlDir withExtension:@".xcodeproj"];
}

+(NSArray*)xcworkspaceUrlsInDirWithUrl:(NSURL*)urlDir{
    return [XFPDirectoryReader urlsInDirWithUrl:urlDir withExtension:@".xcworkspace"];
}

+(NSArray*)urlsInDirWithUrl:(NSURL*)urlDir withExtension:(NSString*)ext{
    NSAssert(urlDir, @"XFADirectoryReader no url");
    NSString * predicateFormat = [NSString stringWithFormat:@"SELF.absoluteString ENDSWITH '%@'",ext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateFormat];
    
    NSArray * array = [XFPDirectoryReader allUrlsInDirWithUrl:urlDir];
    
    NSArray *filteredArray = [array filteredArrayUsingPredicate:predicate];
    
    return filteredArray;
    
}




+(NSArray*)allUrlsInDirWithUrl:(NSURL*)urlDir{
    
    NSFileManager * fm =  NSFileManager.new;
    
    NSDirectoryEnumerator *dirEnumerator = [fm enumeratorAtURL:urlDir includingPropertiesForKeys:@[ NSURLNameKey,NSURLIsDirectoryKey ] options:NSDirectoryEnumerationSkipsHiddenFiles | NSDirectoryEnumerationSkipsSubdirectoryDescendants errorHandler:^BOOL(NSURL *url, NSError *error) {
        NSAssert(FALSE, @"error %@, %@", url, error.localizedDescription);
        return TRUE;
    }];
    
    NSMutableArray * output = [NSMutableArray array];
    
    for (NSURL *someURL in dirEnumerator) {
        [output addObject:someURL];
    }
    
    return output;
}

@end
