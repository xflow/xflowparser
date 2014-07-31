//
//  XFATypeEncodingTests.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/30/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <xflowparser/XFAObjcTypeEncoding.h>

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
    
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"char"], @"c",@"should parse A char");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"NSInteger"], @"i", @"should parse An int");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"int"], @"i", @"should parse An int");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"short"], @"s", @"should parse A short");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"long"], @"l", @"should parse A long ");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"long long"], @"q", @"should parse A long long");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"unsigned char"], @"C", @"should parse An unsigned char");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"unsigned int"], @"I", @"should parse An unsigned int");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"NSUInteger"], @"I", @"should parse An unsigned int");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"unsigned short"], @"S", @"should parse An unsigned short");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"unsigned long"], @"L", @"should parse An unsigned long");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"unsigned long long"], @"Q", @"should parse An unsigned long long");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"CGFloat"], @"f", @"should parse A CGFloat");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"float"], @"f", @"should parse A float");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"double"], @"d", @"should parse A double");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"Boolean"], @"C", @"should parse A C++ bool or a C99 _Bool");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"bool"], @"B", @"should parse A C bool ");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"BOOL"], @"c", @"should parse BOOL");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"void"], @"v", @"should parse A void");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"char *"], @"*", @"should parse A character string (char *) ");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"char*"], @"*", @"should parse A character string (char*) , no spaces");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"UIView *"], @"@", @"should parse An object (whether statically typed or typed id) ");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"NSObject *"], @"@", @"should parse An object (whether statically typed or typed id) ");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"UIViewController *"], @"@", @"should get UIViewController *");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"id"], @"@", @"should parse An object (whether statically typed or typed id) ");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"instancetype"], @"@", @"should parse An object (whether statically typed or typed id) ");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"Class"], @"#", @"should parse A class object (Class)");
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"SEL"], @":", @"should parse A method selector (SEL)");
}

- (void)testParseCArray{
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:@"float a[12]"], @"[12^f]", @"should parse An 12 pointers to floats");
}


-(void)testIsObjcType
{
    XCTAssert([ XFAObjcTypeEncoding isObjcType:@"id"]);
    XCTAssert( [XFAObjcTypeEncoding isObjcType:@"instancetype"]);
    XCTAssert( [XFAObjcTypeEncoding isObjcType:@"Class"]);
    XCTAssert( [XFAObjcTypeEncoding isObjcType:@"SEL"]);
    XCTAssert( [XFAObjcTypeEncoding isObjcType:@"UIView *"]);
    XCTAssertFalse( [XFAObjcTypeEncoding isObjcType:@"void"]);
    XCTAssertFalse( [XFAObjcTypeEncoding isObjcType:@"int"]);
    XCTAssertFalse( [XFAObjcTypeEncoding isObjcType:@"NSInteger"]);
    XCTAssertFalse( [XFAObjcTypeEncoding isObjcType:@"NSUInteger"]);
}

-(void)testTypeEncodingExtractType
{
    XCTAssertEqualObjects([XFAObjcTypeEncoding extractType:@" id   anObject; "], @"id");
    XCTAssertEqualObjects([XFAObjcTypeEncoding extractType:@" id			anObject;    "], @"id");
    XCTAssertEqualObjects([XFAObjcTypeEncoding extractType:@" char *aString;    "], @"char *");
    XCTAssertEqualObjects([XFAObjcTypeEncoding extractType:@" char* aString;    "], @"char *");
    XCTAssertEqualObjects([XFAObjcTypeEncoding extractType:@" char * aString;    "], @"char *");
    XCTAssertEqualObjects([XFAObjcTypeEncoding extractType:@" char   *charaString;    "], @"char *");
    XCTAssertEqualObjects([XFAObjcTypeEncoding extractType:@" int  anInt;    "], @"int");
    XCTAssertEqualObjects([XFAObjcTypeEncoding extractType:@" int  anInt    ;"], @"int");
    XCTAssertEqualObjects([XFAObjcTypeEncoding extractType:@"int        anInt    ;"], @"int");
}


-(void)testParsingSturcts
{
    NSString * strct1 = @"typedef struct example {"
    @"id   anObject;"
    @"char *aString;"
    @"int  anInt;"
    @"} Example;";
    
    XCTAssertEqualObjects([XFAObjcTypeEncoding of:strct1], @"{example=@*i}", @"should parse struct");
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
