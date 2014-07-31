//
//  XFAMethodArgumentParser.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/28/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <xflowparser/XFAObjcMethodArgumentParser.h>
#import <xflowparser/XFAObjcMethodArgument.h>

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
    XFAObjcMethodArgumentParser * parser = XFAObjcMethodArgumentParser.new;
    XFAObjcMethodArgument * arg = [parser parseArgument:@":(BOOL)animated"];
    XCTAssertEqualObjects(arg.argumentName, nil, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"animated", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"BOOL", @"should get nil for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFAObjcPointerTypeNone, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, FALSE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , FALSE, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, @"should get nil for argument nil");
    
    
}


- (void)testFirstBoolArgWithSpace
{
    XFAObjcMethodArgumentParser * parser = XFAObjcMethodArgumentParser.new;
    XFAObjcMethodArgument * arg = [parser parseArgument:@":( BOOL ) animated"];
    XCTAssertEqualObjects(arg.argumentName, nil, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"animated", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"BOOL", @"should get nil for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFAObjcPointerTypeNone, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, FALSE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , FALSE, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, @"should get nil for argument nil");
    
    
}


- (void)testFirstBoolArgWithPreSpace
{
    XFAObjcMethodArgumentParser * parser = XFAObjcMethodArgumentParser.new;
    XFAObjcMethodArgument * arg = [parser parseArgument:@":(BOOL )animated"];
    XCTAssertEqualObjects(arg.argumentName, nil, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"animated", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"BOOL", @"should get nil for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFAObjcPointerTypeNone, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, FALSE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , FALSE, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, @"should get nil for argument nil");
    
    
}



- (void)testPointerVariable
{
    XFAObjcMethodArgumentParser * parser = XFAObjcMethodArgumentParser.new;
    XFAObjcMethodArgument * arg = [parser parseArgument:@":(UITabBarController *)tabBarController"];
    XCTAssertEqualObjects(arg.argumentName, nil, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"tabBarController", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"UITabBarController *", @"should get nil for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFAObjcPointerTypeKnown, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, YES, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , FALSE, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, @"should get nil for argument nil");
    
    
}



- (void)testPointerVariableNSObjectNoSpaceBeforeStar
{
    XFAObjcMethodArgumentParser * parser = XFAObjcMethodArgumentParser.new;
    NSString * testSubject = @":(NSObject*)object";
    XFAObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, nil, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"object", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"NSObject *", @"should get NSObject * for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFAObjcPointerTypeKnown, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, YES, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , FALSE, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, @"should get nil for argument nil");
    
}



- (void)testParsingArgumentWithArgumentName
{
    XFAObjcMethodArgumentParser * parser = XFAObjcMethodArgumentParser.new;
    NSString * testSubject = @"withTabBarController:(UITabBarController *)tabBarController";
    XFAObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, @"withTabBarController", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"tabBarController", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"UITabBarController *", @"should get NSObject * for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFAObjcPointerTypeKnown, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, YES, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , FALSE, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, @"should get nil for argument nil");
    
}


- (void)testParsingArgumentThatConformsToOneProtocol
{
    XFAObjcMethodArgumentParser * parser = XFAObjcMethodArgumentParser.new;
    NSString * testSubject = @"interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController";
    XFAObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, @"interactionControllerForAnimationController", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"animationController", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"id", @"should get NSObject * for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFAObjcPointerTypeUnknown, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, TRUE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , FALSE, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, @[@"UIViewControllerAnimatedTransitioning"] , @"should get nil for argument nil");
    
}


- (void)testParsingArgumentThatConformsToTwoProtocols
{
    XFAObjcMethodArgumentParser * parser = XFAObjcMethodArgumentParser.new;
    NSString * testSubject = @"interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning,UIViewControllerAnimatedTransitioning2>)animationController";
    XFAObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, @"interactionControllerForAnimationController", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"animationController", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"id", @"should get NSObject * for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFAObjcPointerTypeUnknown, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, TRUE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , FALSE, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, (@[@"UIViewControllerAnimatedTransitioning",@"UIViewControllerAnimatedTransitioning2"]) , @"should get nil for argument nil");
    
}







- (void)testParsingArgumentWithVoidWithNoParamsBlock
{
    XFAObjcMethodArgumentParser * parser = XFAObjcMethodArgumentParser.new;
    NSString * testSubject = @"animations:(void (^)(void))animations";
    XFAObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, @"animations", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"animations", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"^", @"should get ^ for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFAObjcPointerTypeBlock, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, TRUE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , YES, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, @"void (^)(void)", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, (@[]) , @"should get nil for argument nil");
    
}

- (void)testParsingArgumentWithVoidWithParamsBlock
{
    XFAObjcMethodArgumentParser * parser = XFAObjcMethodArgumentParser.new;
    NSString * testSubject = @"completion:(void (^)(UIView * finished))completion";
    XFAObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, @"completion", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"completion", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"^", @"should get ^ for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFAObjcPointerTypeBlock, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, TRUE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , YES, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, @"void (^)(UIView * finished)", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, (@[]) , @"should get nil for argument nil");
    
}

- (void)testParsingArgumentWithObjectWithParamsBlock
{
    XFAObjcMethodArgumentParser * parser = XFAObjcMethodArgumentParser.new;
    NSString * testSubject = @"completion:(NSObject * (^)(UIView * finished))completion";
    XFAObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, @"completion", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"completion", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"^", @"should get ^ for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFAObjcPointerTypeBlock, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, TRUE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , YES, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, @"NSObject * (^)(UIView * finished)", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, (@[]) , @"should get nil for argument nil");
    
}

- (void)testParsingArgumentWithBOOLWithParamsBlock
{
    XFAObjcMethodArgumentParser * parser = XFAObjcMethodArgumentParser.new;
    NSString * testSubject = @":(void (^)(BOOL finished))completion";
    XFAObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, nil , @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"completion", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"^", @"should get ^ for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFAObjcPointerTypeBlock, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, TRUE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , YES, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, @"void (^)(BOOL finished)", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, (@[]) , @"should get nil for argument nil");
    
}



- (void)testParsingArgumentWithObjectWithBoolParamsBlock
{
    XFAObjcMethodArgumentParser * parser = XFAObjcMethodArgumentParser.new;
    NSString * testSubject = @":(NSObject * (^)(BOOL finished))completion";
    XFAObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, nil , @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"completion", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"^", @"should get ^ for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFAObjcPointerTypeBlock, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, TRUE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , YES, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, @"NSObject * (^)(BOOL finished)", @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, (@[]) , @"should get nil for argument nil");
    
}



- (void)testParsingArgumentWithClassWithBoolParamsBlock
{
    XFAObjcMethodArgumentParser * parser = XFAObjcMethodArgumentParser.new;
    NSString * testSubject = @":(Class <UIAppearanceContainer>)ContainerClass";
    XFAObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, nil , @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"ContainerClass", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"Class", @"should get Class for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFAObjcPointerTypeClass, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, TRUE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , NO, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil ,@"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, (@[@"UIAppearanceContainer"]) , @"should get nil for argument nil");
    
}

- (void)testParsingArgumentWithClassWithBoolParamsBlock2
{
    XFAObjcMethodArgumentParser * parser = XFAObjcMethodArgumentParser.new;
    NSString * testSubject = @"withClass:(Class <UIAppearanceContainer>)ContainerClass";
    XFAObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, @"withClass" , @"should get withClass for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"ContainerClass", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"Class", @"should get Class for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFAObjcPointerTypeClass, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, TRUE, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , NO, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, "should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, (@[@"UIAppearanceContainer"]) , @"should get nil for argument nil");
    
}

- (void)testParsingArgumentReturnsCGPointTakesCGPoint_1
{
    XFAObjcMethodArgumentParser * parser = XFAObjcMethodArgumentParser.new;
    NSString * testSubject = @"controlPoint1:(CGPoint)aControlPoint_1";
    XFAObjcMethodArgument * arg = [parser parseArgument:testSubject];
    XCTAssertEqualObjects(arg.argumentName, @"controlPoint1" , @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.variableName, @"aControlPoint_1", @"should get object for argument nil");
    XCTAssertEqualObjects(arg.objcType, @"CGPoint", @"should get ^ for argument nil");
    XCTAssertEqual(arg.objcPointerType, XFAObjcPointerTypeNone, @"should get nil for argument nil");
    XCTAssertEqual(arg.index, 0, @"should get 0 for argument nil");
    XCTAssertEqual(arg.isNSObject, NO, @"should get nil for argument nil");
    XCTAssertEqual(arg.isBlock , NO, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.block, nil, @"should get nil for argument nil");
    XCTAssertEqualObjects(arg.objcProtocolNames, (@[]) , @"should get nil for argument nil");
    
}




@end
