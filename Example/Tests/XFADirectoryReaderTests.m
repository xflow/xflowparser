//
//  XFADirectoryReaderTests.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/26/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <xflowparser/XFPDirectoryReader.h>


@interface XFADirectoryReaderTests : XCTestCase

@end

@implementation XFADirectoryReaderTests

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

- (void)testListDirectoryHeaderFiles
{
    NSString * dir = @"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/System/Library/Frameworks/UIKit.framework/Headers";
    NSURL * dirUrl = [NSURL URLWithString:dir];
    NSArray * arr = [XFPDirectoryReader headersUrlsInDirWithUrl:dirUrl];
    XCTAssertEqual(arr.count, 155, @"count expected to b 136");
    
}

@end
