//
//  XFAObjcPropertyTests.m
//  xflowparser
//
//  Created by Mohammed Tillawy on 11/21/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "XFAObjcProperty.h"
#import "XFAObjcPropertyParser.h"
#import <Mantle/Mantle.h>

@interface XFAObjcPropertyTests : XCTestCase

@end

@implementation XFAObjcPropertyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert([[XFAObjcProperty class] isSubclassOfClass:[MTLModel class]]);
    XCTAssert([[XFAObjcProperty class] conformsToProtocol:@protocol(MTLJSONSerializing)]);
}

- (void)testJsonGeneration
{
    NSString * p = @"@property(nonatomic,retain)		  CGRect            contentStretch NS_DEPRECATED_IOS(3_0,6_0);";
    XFAObjcPropertyParser * parser = XFAObjcPropertyParser.new;
    XFAObjcProperty * property = [parser parseProperty:p];
    NSDictionary * jsonDictionary = [MTLJSONAdapter JSONDictionaryFromModel:property];
    NSLog(@"jsonDictionary:%@",jsonDictionary);
    XCTAssert(jsonDictionary);

}

@end
