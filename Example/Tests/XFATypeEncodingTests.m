//
//  XFATypeEncodingTests.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/30/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <xflowparser/XFPObjcTypeEncoding.h>

@interface XFATypeEncodingTests : XCTestCase

@end

@implementation XFATypeEncodingTests

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

- (void)testEncodingsDictionary
{
    
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"char"], @"c",@"should parse A char");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"NSInteger"], @"i", @"should parse An int");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"int"], @"i", @"should parse An int");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"short"], @"s", @"should parse A short");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"long"], @"l", @"should parse A long ");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"long long"], @"q", @"should parse A long long");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"unsigned char"], @"C", @"should parse An unsigned char");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"unsigned int"], @"I", @"should parse An unsigned int");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"NSUInteger"], @"I", @"should parse An unsigned int");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"unsigned short"], @"S", @"should parse An unsigned short");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"unsigned long"], @"L", @"should parse An unsigned long");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"unsigned long long"], @"Q", @"should parse An unsigned long long");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"CGFloat"], @"f", @"should parse A CGFloat");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"float"], @"f", @"should parse A float");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"double"], @"d", @"should parse A double");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"Boolean"], @"C", @"should parse A C++ bool or a C99 _Bool");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"bool"], @"B", @"should parse A C bool ");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"BOOL"], @"c", @"should parse BOOL");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"void"], @"v", @"should parse A void");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"char *"], @"*", @"should parse A character string (char *) ");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"char*"], @"*", @"should parse A character string (char*) , no spaces");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"UIView *"], @"@", @"should parse An object (whether statically typed or typed id) ");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"NSObject *"], @"@", @"should parse An object (whether statically typed or typed id) ");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"UIViewController *"], @"@", @"should get UIViewController *");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"id"], @"@", @"should parse An object (whether statically typed or typed id) ");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"instancetype"], @"@", @"should parse An object (whether statically typed or typed id) ");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"Class"], @"#", @"should parse A class object (Class)");
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"SEL"], @":", @"should parse A method selector (SEL)");
}

- (void)testParseCArray{
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:@"float a[12]"], @"[12^f]", @"should parse An 12 pointers to floats");
}


-(void)testIsObjcType
{
    XCTAssert([ XFPObjcTypeEncoding isObjcType:@"id"]);
    XCTAssert( [XFPObjcTypeEncoding isObjcType:@"instancetype"]);
    XCTAssert( [XFPObjcTypeEncoding isObjcType:@"Class"]);
    XCTAssert( [XFPObjcTypeEncoding isObjcType:@"SEL"]);
    XCTAssert( [XFPObjcTypeEncoding isObjcType:@"UIView *"]);
    XCTAssertFalse( [XFPObjcTypeEncoding isObjcType:@"void"]);
    XCTAssertFalse( [XFPObjcTypeEncoding isObjcType:@"int"]);
    XCTAssertFalse( [XFPObjcTypeEncoding isObjcType:@"NSInteger"]);
    XCTAssertFalse( [XFPObjcTypeEncoding isObjcType:@"NSUInteger"]);
}

-(void)testTypeEncodingExtractType
{
    XCTAssertEqualObjects([XFPObjcTypeEncoding extractType:@" id   anObject; "], @"id");
    XCTAssertEqualObjects([XFPObjcTypeEncoding extractType:@" id			anObject;    "], @"id");
    XCTAssertEqualObjects([XFPObjcTypeEncoding extractType:@" char *aString;    "], @"char *");
    XCTAssertEqualObjects([XFPObjcTypeEncoding extractType:@" char* aString;    "], @"char *");
    XCTAssertEqualObjects([XFPObjcTypeEncoding extractType:@" char * aString;    "], @"char *");
    XCTAssertEqualObjects([XFPObjcTypeEncoding extractType:@" char   *charaString;    "], @"char *");
    XCTAssertEqualObjects([XFPObjcTypeEncoding extractType:@" int  anInt;    "], @"int");
    XCTAssertEqualObjects([XFPObjcTypeEncoding extractType:@" int  anInt    ;"], @"int");
    XCTAssertEqualObjects([XFPObjcTypeEncoding extractType:@"int        anInt    ;"], @"int");
}


-(void)testParsingSturcts
{
    NSString * strct1 = @"typedef struct example {"
    @"id   anObject;"
    @"char *aString;"
    @"int  anInt;"
    @"} Example;";
    
    XCTAssertEqualObjects([XFPObjcTypeEncoding of:strct1], @"{example=@*i}", @"should parse struct");
}



/*
 # TBD
 skip
 
 TypeEncoding.of("").must_equal "{name=type...}"
 it 'should parse A union' do
 
 TypeEncoding.of("").must_equal "A bnum"
 it 'should parse A bit field of num bits ' do
 
 TypeEncoding.of("CGFloat").must_equal "^type"
 it 'should parse A pointer to type ' do
 
 TypeEncoding.of("CGFloat").must_equal "?"
 it 'should parse An unknown type (among other things, this code is used for function pointers) '
 
 */

@end
