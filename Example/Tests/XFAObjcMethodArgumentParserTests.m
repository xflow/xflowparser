//
//  XFAMethodArgumentParser.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/28/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <xflowparser/XFPObjcMethodArgumentParser.h>
#import <xflowparser/XFPObjcMethodArgument.h>

@interface XFAObjcMethodArgumentParserTests : XCTestCase

@end

@implementation XFAObjcMethodArgumentParserTests

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

- (void)testFirstBoolArgNoSpaces
{
    XFPObjcMethodArgumentParser * parser = [XFPObjcMethodArgumentParser new];
    XFPObjcMethodArgument * arg = [parser parseArgument:@":(BOOL)animated"];
    XCTAssertEqualObjects(arg.argumentName, nil, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"animated", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"BOOL", @"should get nil for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFPObjcPointerTypeNone, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, FALSE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , FALSE, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, @"should get nil for argument nil");
    
    
}


- (void)testFirstBoolArgWithSpace
{
    XFPObjcMethodArgumentParser * parser = [XFPObjcMethodArgumentParser new];
    XFPObjcMethodArgument * arg = [parser parseArgument:@":( BOOL ) animated"];
    XCTAssertEqualObjects(arg.argumentName, nil, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"animated", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"BOOL", @"should get nil for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFPObjcPointerTypeNone, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, FALSE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , FALSE, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, @"should get nil for argument nil");
    
    
}


- (void)testFirstBoolArgWithPreSpace
{
    XFPObjcMethodArgumentParser * parser = [XFPObjcMethodArgumentParser new];
    XFPObjcMethodArgument * arg = [parser parseArgument:@":(BOOL )animated"];
    XCTAssertEqualObjects(arg.argumentName, nil, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"animated", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"BOOL", @"should get nil for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFPObjcPointerTypeNone, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, FALSE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , FALSE, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, @"should get nil for argument nil");
    
    
}



- (void)testPointerVariable
{
    XFPObjcMethodArgumentParser * parser = [XFPObjcMethodArgumentParser new];
    XFPObjcMethodArgument * arg = [parser parseArgument:@":(UITabBarController *)tabBarController"];
    XCTAssertEqualObjects(arg.argumentName, nil, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"tabBarController", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"UITabBarController *", @"should get nil for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFPObjcPointerTypeKnown, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, YES, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , FALSE, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, @"should get nil for argument nil");
    
    
}



- (void)testPointerVariableNSObjectNoSpaceBeforeStar
{
    XFPObjcMethodArgumentParser * parser = [XFPObjcMethodArgumentParser new];
    NSString * testSubject = @":(NSObject*)object";
    XFPObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, nil, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"object", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"NSObject *", @"should get NSObject * for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFPObjcPointerTypeKnown, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, YES, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , FALSE, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, @"should get nil for argument nil");
    
}



- (void)testParsingArgumentWithArgumentName
{
    XFPObjcMethodArgumentParser * parser = [XFPObjcMethodArgumentParser new];
    NSString * testSubject = @"withTabBarController:(UITabBarController *)tabBarController";
    XFPObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, @"withTabBarController", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"tabBarController", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"UITabBarController *", @"should get NSObject * for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFPObjcPointerTypeKnown, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, YES, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , FALSE, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, @"should get nil for argument nil");
    
}


- (void)testParsingArgumentThatConformsToOneProtocol
{
    XFPObjcMethodArgumentParser * parser = [XFPObjcMethodArgumentParser new];
    NSString * testSubject = @"interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController";
    XFPObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, @"interactionControllerForAnimationController", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"animationController", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"id", @"should get NSObject * for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFPObjcPointerTypeUnknown, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, TRUE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , FALSE, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, @[@"UIViewControllerAnimatedTransitioning"] , @"should get nil for argument nil");
    
}


- (void)testParsingArgumentThatConformsToTwoProtocols
{
    XFPObjcMethodArgumentParser * parser = [XFPObjcMethodArgumentParser new];
    NSString * testSubject = @"interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning,UIViewControllerAnimatedTransitioning2>)animationController";
    XFPObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, @"interactionControllerForAnimationController", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"animationController", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"id", @"should get NSObject * for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFPObjcPointerTypeUnknown, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, TRUE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , FALSE, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, (@[@"UIViewControllerAnimatedTransitioning",@"UIViewControllerAnimatedTransitioning2"]) , @"should get nil for argument nil");
    
}







- (void)testParsingArgumentWithVoidWithNoParamsBlock
{
    XFPObjcMethodArgumentParser * parser = [XFPObjcMethodArgumentParser new];
    NSString * testSubject = @"animations:(void (^)(void))animations";
    XFPObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, @"animations", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"animations", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"^", @"should get ^ for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFPObjcPointerTypeBlock, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, TRUE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , YES, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, @"void (^)(void)", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, (@[]) , @"should get nil for argument nil");
    
}

- (void)testParsingArgumentWithVoidWithParamsBlock
{
    XFPObjcMethodArgumentParser * parser = [XFPObjcMethodArgumentParser new];
    NSString * testSubject = @"completion:(void (^)(UIView * finished))completion";
    XFPObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, @"completion", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"completion", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"^", @"should get ^ for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFPObjcPointerTypeBlock, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, TRUE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , YES, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, @"void (^)(UIView * finished)", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, (@[]) , @"should get nil for argument nil");
    
}

- (void)testParsingArgumentWithObjectWithParamsBlock
{
    XFPObjcMethodArgumentParser * parser = [XFPObjcMethodArgumentParser new];
    NSString * testSubject = @"completion:(NSObject * (^)(UIView * finished))completion";
    XFPObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, @"completion", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"completion", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"^", @"should get ^ for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFPObjcPointerTypeBlock, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, TRUE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , YES, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, @"NSObject * (^)(UIView * finished)", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, (@[]) , @"should get nil for argument nil");
    
}

- (void)testParsingArgumentWithBOOLWithParamsBlock
{
    XFPObjcMethodArgumentParser * parser = [XFPObjcMethodArgumentParser new];
    NSString * testSubject = @":(void (^)(BOOL finished))completion";
    XFPObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, nil , @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"completion", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"^", @"should get ^ for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFPObjcPointerTypeBlock, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, TRUE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , YES, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, @"void (^)(BOOL finished)", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, (@[]) , @"should get nil for argument nil");
    
}



- (void)testParsingArgumentWithObjectWithBoolParamsBlock
{
    XFPObjcMethodArgumentParser * parser = [XFPObjcMethodArgumentParser new];
    NSString * testSubject = @":(NSObject * (^)(BOOL finished))completion";
    XFPObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, nil , @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"completion", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"^", @"should get ^ for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFPObjcPointerTypeBlock, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, TRUE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , YES, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, @"NSObject * (^)(BOOL finished)", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, (@[]) , @"should get nil for argument nil");
    
}



- (void)testParsingArgumentWithClassWithBoolParamsBlock
{
    XFPObjcMethodArgumentParser * parser = [XFPObjcMethodArgumentParser new];
    NSString * testSubject = @":(Class <UIAppearanceContainer>)ContainerClass";
    XFPObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, nil , @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"ContainerClass", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"Class", @"should get Class for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFPObjcPointerTypeClass, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, TRUE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , NO, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil ,@"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, (@[@"UIAppearanceContainer"]) , @"should get nil for argument nil");
    
}

- (void)testParsingArgumentWithClassWithBoolParamsBlock2
{
    XFPObjcMethodArgumentParser * parser = [XFPObjcMethodArgumentParser new];
    NSString * testSubject = @"withClass:(Class <UIAppearanceContainer>)ContainerClass";
    XFPObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, @"withClass" , @"should get withClass for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"ContainerClass", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"Class", @"should get Class for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFPObjcPointerTypeClass, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, TRUE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , NO, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, "should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, (@[@"UIAppearanceContainer"]) , @"should get nil for argument nil");
    
}

- (void)testParsingArgumentReturnsCGPointTakesCGPoint_1
{
    XFPObjcMethodArgumentParser * parser = [XFPObjcMethodArgumentParser new];
    NSString * testSubject = @"controlPoint1:(CGPoint)aControlPoint_1";
    XFPObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, @"controlPoint1" , @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"aControlPoint_1", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"CGPoint", @"should get ^ for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFPObjcPointerTypeNone, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, NO, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , NO, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, (@[]) , @"should get nil for argument nil");
    
}




@end
