//
//  XFAObjcPropertyTests.m
//  xflow
//
//  Created by Mohammed Tillawy on 5/2/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <xflowparser/XFPObjcPropertyParser.h>
#import <xflowparser/XFPObjcProperty.h>

@interface XFAObjcPropertyParserTests : XCTestCase

@end

@implementation XFAObjcPropertyParserTests

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


// 	it "must parse a scalar property" do

- (void)testPraseScalarProperty
{
    NSString * p = @"@property(nonatomic,retain)		  CGRect            contentStretch NS_DEPRECATED_IOS(3_0,6_0);";
    XFPObjcPropertyParser * parser = [XFPObjcPropertyParser new];
    XFPObjcProperty * property = [parser parseProperty:p];
    
    XCTAssertEqualObjects(property.objcType, @"CGRect", @"");
    XCTAssertEqualObjects(property.propertyName, @"contentStretch", @"");
    XCTAssertEqualObjects(property.attributes, (@[@"nonatomic",@"retain"]), @"");
    XCTAssertFalse(property.isNSObject,@"");
    XCTAssert(property.isDeprecated, "");
    XCTAssertEqualObjects(property.iosAvailableFromVersion, @(3.0) , "");
    XCTAssertEqualObjects(property.iosAvailableToVersion, @(6.0), "");
}

// 	it "must parse a scalar property without keywords" do

- (void)testPraseScalarPropertyWithoutKeywords
{
    NSString * p = @"@property		  CGRect            contentStretch NS_DEPRECATED_IOS(3_0,6_0);"
;
    XFPObjcPropertyParser * parser = [XFPObjcPropertyParser new];
    XFPObjcProperty * property = [parser parseProperty:p];
    
    XCTAssertEqualObjects(property.objcType, @"CGRect", @"");
    XCTAssertEqualObjects(property.propertyName, @"contentStretch", @"");
    XCTAssertNil(property.attributes , @"");
    XCTAssertFalse(property.isNSObject,@"");
    XCTAssert(property.isDeprecated, "");
    XCTAssertEqualObjects(property.iosAvailableFromVersion, @(3.0) , "");
    XCTAssertEqualObjects(property.iosAvailableToVersion, @(6.0), "");
}

// 	it "must parse an object" do


- (void)testParseAnObject
{
    NSString * p = @"@property (nonatomic,retain) UIColor *tintColor;";
    
    XFPObjcPropertyParser * parser = [XFPObjcPropertyParser new];
    XFPObjcProperty * property = [parser parseProperty:p];
    
    XCTAssertEqualObjects(property.objcType, @"UIColor *", @"");
    XCTAssertEqualObjects(property.propertyName, @"tintColor", @"");
    XCTAssertEqualObjects(property.attributes, (@[@"nonatomic",@"retain"]), @"");
    XCTAssert(property.isNSObject,@"");
    XCTAssertFalse(property.isDeprecated, "");
    XCTAssertNil(property.iosAvailableFromVersion , "");
    XCTAssertNil(property.iosAvailableToVersion , "");
}



// 	it "must parse an object with NS_AVAILABLE_IOS" do

- (void)testParseAnObjectWithNS_AVAILABLE_IOS
{
    NSString * p = @"@property (nonatomic,retain) UIColor *tintColor NS_AVAILABLE_IOS(7_0);";

    XFPObjcPropertyParser * parser = [XFPObjcPropertyParser new];
    XFPObjcProperty * property = [parser parseProperty:p];
    
    XCTAssertEqualObjects(property.objcType, @"UIColor *", @"");
    XCTAssertEqualObjects(property.propertyName, @"tintColor", @"");
    XCTAssertEqualObjects(property.attributes, (@[@"nonatomic",@"retain"]), @"");
    XCTAssert(property.isNSObject,@"");
    XCTAssertFalse(property.isDeprecated, "");
    XCTAssertEqualObjects(property.iosAvailableFromVersion, @(7.0) , "");
    XCTAssertNil(property.iosAvailableToVersion, "");
}



// 	it "should par" do


- (void)testParseAnObjectWithNS_NONATOMIC_IOSONLY
{
    NSString * p = @"@property (readonly, NS_NONATOMIC_IOSONLY) NSArray *textContainers;";
    
    XFPObjcPropertyParser * parser = [XFPObjcPropertyParser new];
    XFPObjcProperty * property = [parser parseProperty:p];
    
    XCTAssertEqualObjects(property.objcType, @"NSArray *" , @"");
    XCTAssertEqualObjects(property.propertyName, @"textContainers", @"");
    XCTAssertEqualObjects(property.attributes, (@[@"readonly",@"NS_NONATOMIC_IOSONLY"]), @"");
    XCTAssert(property.isNSObject,@"");
    XCTAssertFalse(property.isDeprecated, "");
    XCTAssert(property.isOnlyIOS, @"");
    XCTAssertNil(property.iosAvailableFromVersion , "");
    XCTAssertNil(property.iosAvailableToVersion, "");
}

// 	it 'should parse with a stupid comment in the deprecated pard in the end' do

- (void)testParseAnObjectWithNS_DEPRECATED_IOSWithCommentInside
{
    NSString * p = @"@property (nonatomic,readwrite) CGSize contentSizeForViewInPopover NS_DEPRECATED_IOS(3_2, 7_0, \"Use UIViewController.preferredContentSize instead.\");";
    
    XFPObjcPropertyParser * parser = [XFPObjcPropertyParser new];
    XFPObjcProperty * property = [parser parseProperty:p];
    
    XCTAssertEqualObjects(property.objcType, @"CGSize", @"");
    XCTAssertEqualObjects(property.propertyName, @"contentSizeForViewInPopover", @"");
    XCTAssertEqualObjects(property.attributes, (@[@"nonatomic",@"readwrite"]), @"");
    XCTAssertFalse(property.isNSObject,@"");
    XCTAssert(property.isDeprecated, "");
    XCTAssertFalse(property.isOnlyIOS, @"");
    XCTAssertEqual(property.iosAvailableFromVersion.floatValue, 3.2f , "");
    XCTAssertEqualObjects(property.iosAvailableToVersion, @(7.0), "");
}

- (void)testParseAnObjectWithThreeAttributes
{
    NSString * p = @"@property(nonatomic, readonly, retain) UILabel* textLabel;";
    
    XFPObjcPropertyParser * parser = [XFPObjcPropertyParser new];
    XFPObjcProperty * property = [parser parseProperty:p];
    
    XCTAssertEqualObjects(property.objcType, @"UILabel *", @"");
    XCTAssertEqualObjects(property.propertyName, @"textLabel", @"");
    XCTAssertEqualObjects(property.attributes, (@[@"nonatomic",@"readonly",@"retain"]), @"");
    XCTAssert(property.isNSObject,@"");
    XCTAssertFalse(property.isDeprecated, "");
    XCTAssertFalse(property.isOnlyIOS, @"");
    XCTAssertNil(property.iosAvailableFromVersion , @"");
    XCTAssertNil(property.iosAvailableToVersion, @"");
}

- (void)testParseAPropertyWithCommentAfter
{
    NSString * p = @"@property(nonatomic, readonly, retain) UILabel* detailTextLabel; // only supported for headers in grouped style";
    
    XFPObjcPropertyParser * parser = [XFPObjcPropertyParser new];
    XFPObjcProperty * property = [parser parseProperty:p];
    
    XCTAssertEqualObjects(property.objcType, @"UILabel *", @"");
    XCTAssertEqualObjects(property.propertyName, @"detailTextLabel", @"");
    XCTAssertEqualObjects(property.attributes, (@[@"nonatomic",@"readonly",@"retain"]), @"");
    XCTAssert(property.isNSObject,@"");
    XCTAssertFalse(property.isDeprecated, "");
    XCTAssertFalse(property.isOnlyIOS, @"");
    XCTAssertNil(property.iosAvailableFromVersion , @"");
    XCTAssertNil(property.iosAvailableToVersion, @"");
}


- (void)testParseAPropertyWithId
{
    NSString * p = @"@property (readonly, assign) id firstItem;";
    
    XFPObjcPropertyParser * parser = [XFPObjcPropertyParser new];
    XFPObjcProperty * property = [parser parseProperty:p];
    
    XCTAssertEqualObjects(property.objcType, @"id", @"");
    XCTAssertEqualObjects(property.propertyName, @"firstItem", @"");
    XCTAssertEqualObjects(property.attributes, (@[@"readonly",@"assign"]), @"");
    XCTAssert(property.isNSObject,@"");
    XCTAssertFalse(property.isDeprecated, "");
    XCTAssertFalse(property.isOnlyIOS, @"");
    XCTAssertNil(property.iosAvailableFromVersion , @"");
    XCTAssertNil(property.iosAvailableToVersion, @"");
}

- (void)testParseAPropertyThatConformsToOneProtocol
{
//    NSString * p = @"@property(assign, NS_NONATOMIC_IOSONLY) id <NSLayoutManagerDelegate> delegate;";
    NSString * p = @"@property(assign, NS_NONATOMIC_IOSONLY) id <NSLayoutManagerDelegate> delegate;";

    
    XFPObjcPropertyParser * parser = [XFPObjcPropertyParser new];
    XFPObjcProperty * property = [parser parseProperty:p];
    
    XCTAssertEqualObjects(property.objcType, @"id", @"");
    XCTAssertEqualObjects(property.propertyName, @"delegate", @"");
    XCTAssertEqualObjects(property.attributes, (@[@"assign",@"NS_NONATOMIC_IOSONLY"]), @"");
    XCTAssertEqualObjects(property.objcTypeProtocolNames,( @[@"NSLayoutManagerDelegate"] ), @"");
    XCTAssert(property.isNSObject,@"");
    XCTAssertFalse(property.isDeprecated, "");
    XCTAssert(property.isOnlyIOS, @"");
    XCTAssertNil(property.iosAvailableFromVersion , @"");
    XCTAssertNil(property.iosAvailableToVersion, @"");
}


- (void)testParseAPropertyThatConformsToTwoProtocol
{
    NSString * p = @"@property(assign, NS_NONATOMIC_IOSONLY) id <NSLayoutManagerDelegate,NSLayoutManagerSomething> delegate;";
    
    
    XFPObjcPropertyParser * parser = [XFPObjcPropertyParser new];
    XFPObjcProperty * property = [parser parseProperty:p];
    
    XCTAssertEqualObjects(property.objcType, @"id", @"");
    XCTAssertEqualObjects(property.propertyName, @"delegate", @"");
    XCTAssertEqualObjects(property.attributes, (@[@"assign",@"NS_NONATOMIC_IOSONLY"]), @"");
    XCTAssertEqualObjects(property.objcTypeProtocolNames, ( @[@"NSLayoutManagerDelegate", @"NSLayoutManagerSomething" ] ), @"");
    XCTAssert(property.isNSObject,@"");
    XCTAssertFalse(property.isDeprecated, "");
    XCTAssert(property.isOnlyIOS, @"");
    XCTAssertNil(property.iosAvailableFromVersion , @"");
    XCTAssertNil(property.iosAvailableToVersion, @"");
}


- (void)testParseAFloatProperty
{
    NSString * p = @"@property(readonly) float hyphenationFactor;";
    
    
    XFPObjcPropertyParser * parser = [XFPObjcPropertyParser new];
    XFPObjcProperty * property = [parser parseProperty:p];
    
    XCTAssertEqualObjects(property.objcType, @"float", @"");
    XCTAssertEqualObjects(property.propertyName, @"hyphenationFactor", @"");
    XCTAssertEqualObjects(property.attributes, (@[@"readonly"]), @"");
    XCTAssertNil(property.objcTypeProtocolNames, @"");
    XCTAssertFalse(property.isNSObject,@"");
    XCTAssertFalse(property.isDeprecated, "");
    XCTAssertFalse(property.isOnlyIOS, @"");
    XCTAssertNil(property.iosAvailableFromVersion , @"");
    XCTAssertNil(property.iosAvailableToVersion, @"");
}


- (void)testParseAStrangeComment
{
    NSString * p = @"@property(nonatomic,assign) id /*<UIAlertViewDelegate>*/ delegate;    // weak reference";
    
    
    XFPObjcPropertyParser * parser = [XFPObjcPropertyParser new];
    XFPObjcProperty * property = [parser parseProperty:p];
    
    XCTAssertEqualObjects(property.objcType, @"id", @"");
    XCTAssertEqualObjects(property.propertyName, @"delegate", @"");
    XCTAssertEqualObjects(property.attributes, (@[@"nonatomic", @"assign"]), @"");
    XCTAssertNil(property.objcTypeProtocolNames, @"");
    XCTAssert(property.isNSObject,@"");
    XCTAssertFalse(property.isDeprecated, "");
    XCTAssertFalse(property.isOnlyIOS, @"");
    XCTAssertNil(property.iosAvailableFromVersion , @"");
    XCTAssertNil(property.iosAvailableToVersion, @"");
}


- (void)testParseAPropertyWithGetter
{
    NSString * p = @"@property (nonatomic, readonly, getter = isRunning) BOOL running;";
    
    
    XFPObjcPropertyParser * parser = [XFPObjcPropertyParser new];
    XFPObjcProperty * property = [parser parseProperty:p];
    
    XCTAssertEqualObjects(property.objcType, @"BOOL", @"");
    XCTAssertEqualObjects(property.propertyName, @"running", @"");
    XCTAssertEqualObjects(property.attributes, (@[@"nonatomic", @"readonly", @"getter=isRunning" ]), @"");
    XCTAssertNil(property.objcTypeProtocolNames, @"");
    XCTAssertFalse(property.isNSObject,@"");
    XCTAssertFalse(property.isDeprecated, "");
    XCTAssertFalse(property.isOnlyIOS, @"");
    XCTAssertNil(property.iosAvailableFromVersion , @"");
    XCTAssertNil(property.iosAvailableToVersion, @"");
}



- (void)testParseABlockPointer
{
    NSString * p = @"@property (nonatomic,copy) void (^action)(void);";
    
    
    XFPObjcPropertyParser * parser = [XFPObjcPropertyParser new];
    XFPObjcProperty * property = [parser parseProperty:p];
    
    XCTAssertEqualObjects(property.objcType, @"void", @"");
//    XCTAssertEqualObjects(property.propertyName, @"running", @"");
    XCTAssertEqualObjects(property.attributes, (@[ @"nonatomic", @"copy" ]), @"");
    XCTAssertNil(property.objcTypeProtocolNames, @"");
    XCTAssertFalse(property.isNSObject,@"");
    XCTAssertFalse(property.isDeprecated, "");
    XCTAssertFalse(property.isOnlyIOS, @"");
    XCTAssert(property.isBlockPointer, @"");
    XCTAssertNil(property.iosAvailableFromVersion , @"");
    XCTAssertNil(property.iosAvailableToVersion, @"");
}



- (void)testParseAPropertyWithTwoProtocols
{
    NSString * p = @"@property(nonatomic,assign)    id <UINavigationControllerDelegate, UIImagePickerControllerDelegate> delegate;";
    
    
    XFPObjcPropertyParser * parser = [XFPObjcPropertyParser new];
    XFPObjcProperty * property = [parser parseProperty:p];
    
    XCTAssertEqualObjects(property.objcType, @"id", @"");
    XCTAssertEqualObjects(property.propertyName, @"delegate", @"");
    XCTAssertEqualObjects(property.attributes, (@[ @"nonatomic", @"assign" ]), @"");
    XCTAssertEqualObjects(property.objcTypeProtocolNames, ( @[@"UINavigationControllerDelegate", @"UIImagePickerControllerDelegate"]), @"");
    XCTAssert(property.isNSObject,@"");
    XCTAssertFalse(property.isDeprecated, "");
    XCTAssertFalse(property.isOnlyIOS, @"");
    XCTAssertFalse(property.isBlockPointer, @"");
    XCTAssertNil(property.iosAvailableFromVersion , @"");
    XCTAssertNil(property.iosAvailableToVersion, @"");
}



@end
