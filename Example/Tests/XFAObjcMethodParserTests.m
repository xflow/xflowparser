//
//  XFAObjcMethodParserTests.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/29/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <xflowparser/XFAObjcMethod.h>
#import <xflowparser/XFAObjcMethodParser.h>

@interface XFAObjcMethodParserTests : XCTestCase

@end

@implementation XFAObjcMethodParserTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testParserSimpleMethod
{
    
    NSString * subject = @" - (void)sizeToFit;";
    XFAObjcMethodParser * parser = XFAObjcMethodParser.new;
    XFAObjcMethod * method = [parser parseMethod:subject];
    
    XCTAssertFalse(method.isClassMethod, @"should mark as instanse method");
    
    XCTAssertEqual(method.methodArguments.count, 0, @"should have no arguments");
    
    XCTAssertNil(method.objcCategory, @"should have no category");
    XCTAssertEqualObjects(method.returnObjcType, @"void", @"should be void");
    XCTAssertNil(method.iosAvailableFromVersion, @"should be nil");
    XCTAssertNil(method.iosAvailableToVersion, @"should be nil");
    XCTAssertNil(method.osxAvailableFromVersion, @"should be nil");
    XCTAssertNil(method.osxAvailableToVersion, @"should be nil");
    XCTAssertFalse(method.isOnlyIOS, @"should be false");
    XCTAssertFalse(method.isOnlyOSX, @"should be false");
    
}


- (void)testParserSimpleMethodWithTwoParams
{
    
    NSString * subject = @"- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;";
    XFAObjcMethodParser * parser = XFAObjcMethodParser.new;
    XFAObjcMethod * method = [parser parseMethod:subject];
    
    XCTAssertFalse(method.isClassMethod, @"should mark as instanse method");
    
    XCTAssertEqual(method.methodArguments.count, 2, @"should have no arguments");
    
    XCTAssertNil(method.objcCategory, @"should have no category");
    
    XCTAssertEqualObjects(method.methodName, @"convertRect", @"should");
    
    XCTAssertEqualObjects(method.returnObjcType, @"CGRect", @"should return CGRect");
    XCTAssertNil(method.iosAvailableFromVersion, @"should be nil");
    XCTAssertNil(method.iosAvailableToVersion, @"should be nil");
    XCTAssertNil(method.osxAvailableFromVersion, @"should be nil");
    XCTAssertNil(method.osxAvailableToVersion, @"should be nil");
    XCTAssertFalse(method.isOnlyIOS, @"should be false");
    XCTAssertFalse(method.isOnlyOSX, @"should be false");

}



- (void)testParserBoolMethodWithTwoParams
{
    
    NSString * subject = @"- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event;";
    XFAObjcMethodParser * parser = XFAObjcMethodParser.new;
    XFAObjcMethod * method = [parser parseMethod:subject];
    
    XCTAssertFalse(method.isClassMethod, @"should mark as instanse method");
    XCTAssertEqualObjects(method.methodName, @"pointInside", @"should");
    
    XCTAssertEqual(method.methodArguments.count, 2, @"should have no arguments");
    
    XCTAssertNil(method.objcCategory, @"should have no category");
    XCTAssertEqualObjects(method.returnObjcType, @"BOOL", @"should return CGRect");
    XCTAssertNil(method.iosAvailableFromVersion, @"should be nil");
    XCTAssertNil(method.iosAvailableToVersion, @"should be nil");
    XCTAssertNil(method.osxAvailableFromVersion, @"should be nil");
    XCTAssertNil(method.osxAvailableToVersion, @"should be nil");
    XCTAssertFalse(method.isOnlyIOS, @"should be false");
    XCTAssertFalse(method.isOnlyOSX, @"should be false");

}





@end