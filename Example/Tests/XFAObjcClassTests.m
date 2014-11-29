//
//  XFAObjcClassTests.m
//  xflowparser
//
//  Created by Mohammed Tillawy on 11/22/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <Mantle/Mantle.h>
#import "XFAObjcClassParser.h"
#import "XFAFileReader.h"
#import "XFAObjcClass.h"

@interface XFAObjcClassTests : XCTestCase

@end

@implementation XFAObjcClassTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testJsonGeneration
{
    
    XFAFileReader * reader = [XFAFileReader new];
    
    NSString * tplfFileName = @"XFAViewController.h.tpl";
    NSString * str = [[NSBundle bundleForClass:self.class] pathForResource:tplfFileName ofType:nil];
    NSURL * url = [NSURL fileURLWithPath:str];
    XFAObjcClass * klass = [reader classNamed:@"XFAViewController" inFile:url];
//    NSLog(@"klass:%@",klass);
    NSDictionary * jsonDictionary = [MTLJSONAdapter JSONDictionaryFromModel:klass];
//    NSLog(@"jsonDictionary:%@",jsonDictionary);
    XCTAssert(jsonDictionary);
    
    NSError * err = nil;
    NSData * data = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:&err];
    NSString * jsongString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"jsongString:\n\n\n %@ \n\n\n",jsongString);
    XCTAssert(jsongString);
    
}

@end
