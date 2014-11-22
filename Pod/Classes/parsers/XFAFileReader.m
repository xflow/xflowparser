//
//  XFAFileReader.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/26/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFAFileReader.h"
#import <RegExCategories.h>

#import "XFAObjcClassParser.h"
#import "XFAObjcClass.h"
#import "XFAObjcMethodParser.h"
#import "XFAObjcMethod.h"
#import "XFAObjcPropertyParser.h"
#import "XFAObjcProperty.h"


@implementation XFAFileReader


-(NSArray *)linesOfFile:(NSURL*)url{
    NSError * err = nil;
    NSString* fileContents = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&err];
    NSAssert(!err, @"error reading file %@ : %@",url.absoluteString,err);
    NSArray* allLinedStrings = [fileContents componentsSeparatedByCharactersInSet:
     [NSCharacterSet newlineCharacterSet]];
    return allLinedStrings;
}


-(NSArray*)namesForSectionType:(NSString*)type inFile:(NSURL*)fileUrl
{
    NSArray * lines = [self linesOfFile:fileUrl];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    for (NSString * line in lines) {
        if ([line isMatch:RX(type)]) {
            NSString * pattern = [NSString stringWithFormat:@"%@[ \\t]*([a-zA-Z0-9]*)",type];
            RxMatch * match = [line firstMatchWithDetails:RX(pattern)];
            NSAssert(match, @"no match detected");
            RxMatchGroup * grp = [match.groups lastObject];
            [dic setValue:line forKey:grp.value];
        }
    }
    NSArray * output = [dic allKeys];
    return output;
}

-(NSArray*)linesOfSection:(NSString*)sectionType
              sectionName:(NSString*)sectionName
          sectionCategory:(NSString*)sectionCategory
                     file:(NSURL*)url
{
    
    NSArray * lines = [self linesOfFile:url];
    BOOL started = NO;
    NSMutableArray * output = [NSMutableArray array];
    for (NSString * line in lines) {
        if (started) {
            [output addObject:line];
        }

        NSString * patternSectionName = [NSString stringWithFormat:@"%@\\b", sectionName ];

        if ([line isMatch:RX(sectionType)] &&
            [line isMatch:RX(patternSectionName)] ) {
            
            if (sectionCategory) {
                if (![line isMatch:RX(sectionCategory)]) {
                    continue;
                }
            }
            
            started = YES;
            [output addObject:line];
            continue;
        }

        if (started && [line isMatch:RX(@"@end")]) {
            started = NO;
            break;
        }

    }
    NSAssert(output.count > 0, @"Searching in the wrong file: %@",url.relativePath);
    return output;
}


-(NSArray*)filterPropertyLines:(NSArray *)lines
{
    NSMutableArray * properties = NSMutableArray.new;
    NSString * line;
    for (line in lines) {
        NSString * pattern = [NSString stringWithFormat:@"@property\\b"];
        line = [line replace:RX(@";.*$") with:@";"];
        if ([line isMatch:RX(pattern)]) {
            NSAssert([line hasSuffix:@";"], @"property does not end with semi colun ';'");
            [properties addObject:line];
        }
    }
    return properties;
}

-(NSArray*)filterMethodLines:(NSArray*)lines{
    NSMutableArray * methods = NSMutableArray.new;
    NSString * unended_line = nil;
    NSString * line = nil;
    for ( line in lines) {
        line = [line replace:RX(@";.*$") with:@";"];
        line = [line replace:RX(@" +") with:@" "];
        
        if (unended_line){
            unended_line = [unended_line stringByAppendingString:line];
            if ([line hasSuffix:@";"]){
                [methods addObject:unended_line];
                unended_line = nil;
            }
        } else if( ( [line hasPrefix:@"-"] || [line hasPrefix:@"+"] ) &&
                  [line hasSuffix:@";"]){
            [methods addObject:line];
        } else if( [line hasPrefix:@"-"] || [line hasPrefix:@"+"] ){
            unended_line = line;
        } else {
//            NSLog(@"not a method line:#{%@}",line);
        }
    }
    
    return methods;
    
}


-(NSArray*)classNamesInLines:(NSArray*)lines
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    for (NSString * line in lines) {
        if ([line isMatch:RX(@"@interface")]) {
            RxMatch * match = [line firstMatchWithDetails:RX(@"@interface[ \\t]*([A-Z][a-zA-Z0-9_]*)")];
            RxMatchGroup * grp = [match.groups objectAtIndex:1];
            [dic setValue:line forKey:grp.value];
        }
    }
    return dic.allKeys;
}


-(NSArray*)protocolNamesInLines:(NSArray*)lines
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    for (NSString * line in lines) {
        if ([line isMatch:RX(@"@protocol")]) {
            RxMatch * match = [line firstMatchWithDetails:RX(@"@protocol[ \\t]*([A-Z][a-zA-Z0-9]*)")];
            RxMatchGroup * grp = [match.groups objectAtIndex:1];
            [dic setValue:line forKey:grp.value];
        }
    }
    return dic.allKeys;
}

-(NSDictionary *)classesDictionaryInLines:(NSArray*)lines
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    for (NSString * line in lines) {
        if ([line isMatch:RX(@"@interface[ \\t]+[A-Z][a-zA-Z0-9_]*[ \\t]?:")]) {
            NSString * pattern = @"@interface[ \\t]+([a-zA-Z0-9_]*)[ \\t]*:[ \\t]*([a-zA-Z0-9_]*)";
            RxMatch * match = [line firstMatchWithDetails:RX(pattern)];
            RxMatchGroup * grp1 = [match.groups objectAtIndex:1];
            RxMatchGroup * grp2 = [match.groups objectAtIndex:2];
            [dic setObject:grp2.value forKey:grp1.value];
        }
    }
    return dic;
}


-(NSArray*)categoriesOfClassNamed:(NSString*)name inLines:(NSArray*)lines{
    
    return nil;
}

-(XFAObjcClass*)classNamed:(NSString*)className inFile:(NSURL*)url{
    
    NSArray * lines = [self linesOfSection:@"interface" sectionName:className sectionCategory:nil file:url];
    XFAObjcClassParser * cp = [XFAObjcClassParser new];
    NSDictionary * classesDict =  [self classesDictionaryInLines:lines];
    
    NSAssert(lines && lines.count > 0, @"no lines found for class:%@",className);
    XFAObjcClass * objcClass = [XFAObjcClass new];
    objcClass.className = className;
    objcClass.superClassName = [classesDict objectForKey:className];

    NSArray * methodLines = [self filterMethodLines:lines];
    for (NSString * mline in methodLines){
        XFAObjcMethodParser * mp = XFAObjcMethodParser.new;
        XFAObjcMethod * method = [mp parseMethod:mline];
        NSAssert(method, @"no method for line:%@",mline);
//        method.objcClass = objcClass;
        [objcClass.methods addObject:method];
    }
    
    NSArray * propLines = [self filterPropertyLines:lines];
    for (NSString * pline in propLines){
        XFAObjcPropertyParser * pp = XFAObjcPropertyParser.new;
        XFAObjcProperty * p = [pp parseProperty:pline];
        NSAssert(p, @"no property for line:%@",pline);
//        p.objcClass = objcClass;
        [objcClass.properties addObject:p];
    }
    
    return objcClass;
}

@end
