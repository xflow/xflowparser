//
//  XFAObjcMethodTests.m
//  xflowparser
//
//  Created by Mohammed Tillawy on 11/28/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "XFPObjcMethodParser.h"
#import "XFPObjcMethod.h"


@interface XFAObjcMethodTests : XCTestCase

@end

@implementation XFAObjcMethodTests

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
    NSString * methodString = @"- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;";
    XFPObjcMethod * m = [[XFPObjcMethodParser new] parseMethod:methodString];
    NSLog(@"%@",m.signature);
    XCTAssertEqualObjects(m.signature,@"convertRect:fromView:");
    
    
    //    NSLog(@"klass:%@",klass);
    NSDictionary * jsonDictionary = [MTLJSONAdapter JSONDictionaryFromModel:m];
    //    NSLog(@"jsonDictionary:%@",jsonDictionary);
    XCTAssert(jsonDictionary);
    XCTAssertEqualObjects(jsonDictionary[@"signature"],@"convertRect:fromView:");
    XCTAssertEqualObjects(jsonDictionary[@"encoding"],@"?16@0:4?8@12");

    NSError * err = nil;
    NSData * data = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:&err];
    NSString * jsongString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"jsongString:\n\n\n %@ \n\n\n",jsongString);
    XCTAssert(jsongString);


}



@end
