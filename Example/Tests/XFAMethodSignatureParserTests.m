//
//  XFAMethodSignatureTests.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/30/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <xflowparser/XFAObjcMethodSignature.h>
#import <xflowparser/XFAObjcMethodSignatureParser.h>
#import <xflowparser/XFAObjcMethod.h>
#import <xflowparser/XFAObjcMethodParser.h>

@interface XFAMethodSignatureParserTests : XCTestCase


@end

@implementation XFAMethodSignatureParserTests

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


-(XFAObjcMethodSignature*)signatureForString:(NSString*)str
{
    XFAObjcMethodParser * methodParser = XFAObjcMethodParser.new;
    XFAObjcMethod * method = [methodParser parseMethod:str];
    XFAObjcMethodSignatureParser * methodSignParser = XFAObjcMethodSignatureParser.new;
    XFAObjcMethodSignature * ms = [methodSignParser parseMethod:method];
    return ms;
}



- (void)testParseVoid
{
	NSString * p = @"-(void)sayHi;";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"v8@0:4");
    XCTAssertEqualObjects(ms.signatureName , @"sayHi");
}

- (void)testParsePutInteger
{
	NSString * p = @"-(void)putInteger:(NSInteger)i;";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"v12@0:4i8");
    XCTAssertEqualObjects(ms.signatureName , @"putInteger:");
}


- (void)testParsePutFloat
{
	NSString * p = @"-(void)putFloat:(CGFloat)f;";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"v12@0:4f8");
    XCTAssertEqualObjects(ms.signatureName , @"putFloat:");
}

- (void)testParseTakeInteger
{
	NSString * p = @"-(NSInteger)takeInteger:(NSInteger)i;";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"i12@0:4i8");
    XCTAssertEqualObjects(ms.signatureName , @"takeInteger:");
}

- (void)testParseTakeFloat
{
	NSString * p = @"-(CGFloat)takeFloat:(CGFloat)f;";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"f12@0:4f8");
    XCTAssertEqualObjects(ms.signatureName , @"takeFloat:");
}

- (void)testParseSomeLongMethod1
{
	NSString * p = @"-(NSInteger)takeInt:(NSInteger)i andFloat:(CGFloat)f andBool:(BOOL)b andString:(NSString*)s andChar:(char)c ;";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"i28@0:4i8f12c16@20c24");
    XCTAssertEqualObjects(ms.signatureName , @"takeInt:andFloat:andBool:andString:andChar:");
}

- (void)testParseTakeStringFromInt
{
	NSString * p = @"-(NSString *)takeStringFromInt:(NSInteger)i andFloat:(CGFloat)f andBool:(BOOL)b andString:(NSString*)s andChar:(char)c ;";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"@28@0:4i8f12c16@20c24");
    XCTAssertEqualObjects(ms.signatureName , @"takeStringFromInt:andFloat:andBool:andString:andChar:");
}

- (void)testParseActionSegmentedControl
{
	NSString * p = @"-(IBAction)actionSegmentedControl:(id)sender;";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"v12@0:4@8");
    XCTAssertEqualObjects(ms.signatureName , @"actionSegmentedControl:");
}


- (void)testParseActionSegmentedControl2
{
	NSString * p = @"-(void)actionSegmentedControl:(id)sender;";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"v12@0:4@8");
    XCTAssertEqualObjects(ms.signatureName , @"actionSegmentedControl:");
}

- (void)testParseAnObject
{
	NSString * p = @"-(NSObject*)anObject;";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"@8@0:4");
    XCTAssertEqualObjects(ms.signatureName , @"anObject");
}

- (void)testParseaChar
{
	NSString * p = @"-(char)aChar;";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"c8@0:4");
    XCTAssertEqualObjects(ms.signatureName , @"aChar");
}
- (void)testParseWithCharsStar
{
	NSString * p = @"-(char*)chars;";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"*8@0:4");
    XCTAssertEqualObjects(ms.signatureName , @"chars");
}

- (void)testParseanObjectWith
{
	NSString * p = @"-(NSObject*)anObjectWith:(NSObject*)obj;";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"@12@0:4@8");
    XCTAssertEqualObjects(ms.signatureName , @"anObjectWith:");
}
- (void)testParseMethodWithAClass
{
	NSString * p = @"- (instancetype)appearanceWhenContainedIn1:(Class <UIAppearanceContainer>)ContainerClass, ... ;";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"@12@0:4#8" );
    XCTAssertEqualObjects(ms.signatureName , @"appearanceWhenContainedIn1:");
}
- (void)testParseSetLabelHello
{
	NSString * p = @"-(void)setLabelHello:(UILabel*)label";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"v12@0:4@8");
    XCTAssertEqualObjects(ms.signatureName , @"setLabelHello:");
}

- (void)testParseDidReceiveMemoryWarning
{
	NSString * p = @"-(void)didReceiveMemoryWarning;";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"v8@0:4");
    XCTAssertEqualObjects(ms.signatureName , @"didReceiveMemoryWarning");
}


- (void)testParse
{
	NSString * p = @"-(void)viewDidLoad;";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"v8@0:4");
    XCTAssertEqualObjects(ms.signatureName , @"viewDidLoad");
}

- (void)testParseViewDidAppear
{
	NSString * p = @"-(void)viewDidAppear:(BOOL)animated;";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"v12@0:4c8");
    XCTAssertEqualObjects(ms.signatureName , @"viewDidAppear:");
}


- (void)testParseAddCurveToPoint
{
	NSString * p = @"- (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2;";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"v20@0:4{CGPoint=ff}8{CGPoint=ff}12{CGPoint=ff}16");
    XCTAssertEqualObjects(ms.signatureName , @"addCurveToPoint:controlPoint1:controlPoint2:");
}


- (void)testParseMethodWithLineBreak
{
	NSString * p = @"- (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2;\n";
    XFAObjcMethodSignature * ms = [self signatureForString:p];
    XCTAssertEqualObjects(ms.signatureEncoding , @"v20@0:4{CGPoint=ff}8{CGPoint=ff}12{CGPoint=ff}16");
    XCTAssertEqualObjects(ms.signatureName , @"addCurveToPoint:controlPoint1:controlPoint2:");
}






@end
