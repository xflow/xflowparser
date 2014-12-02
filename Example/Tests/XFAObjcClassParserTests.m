//
//  XFAObjcClassParserTests.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <xflowparser/XFPObjcClassParser.h>
#import <xflowparser/XFPFileReader.h>


@interface XFAObjcClassParserTests : XCTestCase
{
    NSString * header_file_UIViewControllerTransitionCoordinator;
    NSString * header_file_UIViewControllerTransitioning;
    NSString * header_file_UIView;
    NSString * header_file_NSParagraphStyle;
}

@end

@implementation XFAObjcClassParserTests


- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    
    NSBundle *myBundle = [NSBundle bundleForClass: [self class]];
    
    
    header_file_UIViewControllerTransitioning = [myBundle pathForResource:@"UIViewControllerTransitioning.h" ofType:nil];;
    
    header_file_UIViewControllerTransitionCoordinator = [myBundle pathForResource:@"UIViewControllerTransitionCoordinator.h" ofType:nil];
    
    header_file_UIView = [myBundle pathForResource:@"UIView.h" ofType:nil];;
    header_file_NSParagraphStyle = [myBundle pathForResource:@"NSParagraphStyle.h" ofType:nil];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testParsingClassNameFromFileName
{
    XFPObjcClassParser * parser = [XFPObjcClassParser new];
    NSString * output = [parser classNameFromFilename:@"./test/test_subjects/iOS7/UIView.h"];
    XCTAssertEqualObjects(output, @"UIView", @"output should equal %@",@"UIView");
}



-(void)testPrasingCategoryName{
    XFPObjcClassParser * parser = [XFPObjcClassParser new];
    NSString * output = [parser categoryNameForInterfaceLine:@"@interface UIView(UIViewRendering)"];
    XCTAssertEqualObjects(output, @"UIViewRendering", @"should get the category of a an interface line");
}


-(void)testPrasingCategoryName2
{
    XFPObjcClassParser * parser = [XFPObjcClassParser new];
    NSString * output = [parser categoryNameForInterfaceLine:@"NS_CLASS_AVAILABLE_IOS(2_0) @interface UIView : UIResponder<NSCoding, UIAppearance, UIAppearanceContainer, UIDynamicItem>"];
    XCTAssertNil(output, @"should get nil of a an interface main line NOT:( %@ )" ,output);
}

-(void)testParsingProtocolNames
{
    NSString * li = @"NS_CLASS_AVAILABLE_IOS(2_0) @interface UIView : UIResponder<NSCoding, UIAppearance, UIAppearanceContainer, UIDynamicItem>";
    XFPObjcClassParser * parser = [XFPObjcClassParser new];
    NSArray * output = [parser protocolNamesForInterfaceLine:li];
//    NSArray * expectedOutput = @[ @"NSCoding", @"UIAppearance", @"UIAppearanceContainer", @"UIDynamicItem"];
    XCTAssertEqualObjects(output, (@[ @"NSCoding", @"UIAppearance", @"UIAppearanceContainer", @"UIDynamicItem"]),  @"protocol names" );
}

-(void)testParsingClassName{
    XFPObjcClassParser * parser = [XFPObjcClassParser new];
    NSString * li = @"NS_CLASS_AVAILABLE_IOS(2_0) @interface UIView : UIResponder<NSCoding, UIAppearance, UIAppearanceContainer, UIDynamicItem>";
    NSString * className = [parser classNameForInterfaceLine:li];
    XCTAssertEqualObjects(className, @"UIView", @"should get protocols of UIView");

}




@end


