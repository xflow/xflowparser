//
//  XFAFileReaderTests.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/26/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <xflowparser/XFAFileReader.h>
#import <xflowparser/XFAObjcClass.h>

@interface XFAFileReaderTests : XCTestCase{
    NSString * header_file_UIViewControllerTransitioning;
    NSString * header_file_UIViewControllerTransitionCoordinator;
    NSString * header_file_UIView;
    NSString * header_file_NSParagraphStyle;
}

@end

@implementation XFAFileReaderTests

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

- (void)testReaderNumberOfLines
{
    XFAFileReader * reader =  XFAFileReader.new;
    NSURL * url = [NSURL URLWithString:@"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.1.sdk/System/Library/Frameworks/UIKit.framework/Headers/UIView.h"];
    
    NSArray * arr = [reader linesOfFile:url];
    XCTAssert(arr.count > 500, @"number of lines should be about 500 lines");
    
}


-(void)testInterfaceLinesWithoutCategory{
    NSURL * url = [NSURL URLWithString:@"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.1.sdk/System/Library/Frameworks/UIKit.framework/Headers/UIView.h"];
    
    XFAFileReader * reader =  XFAFileReader.new;
    NSArray * arr = [reader linesOfSection:@"@interface" sectionName:@"UIView" sectionCategory:nil file:url];
    
    XCTAssertEqual(arr.count, 94, @"lines of setion");
}



-(void)testProtocolLinesWitCategory{
    NSURL * url = [NSURL URLWithString:header_file_UIViewControllerTransitionCoordinator];
    
    XFAFileReader * reader =  XFAFileReader.new;
    NSArray * arr = [reader linesOfSection:@"@protocol" sectionName:@"UIViewControllerTransitionCoordinator" sectionCategory:nil file:url];
    XCTAssertEqualObjects([arr objectAtIndex:0], @"@protocol UIViewControllerTransitionCoordinator <UIViewControllerTransitionCoordinatorContext>", @"should detect first line ");
    XCTAssertEqual(arr.count, 35, @"lines of setion");
}

-(void)testInterfaceLinesWitCategory{
    NSURL * url = [NSURL URLWithString:@"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.1.sdk/System/Library/Frameworks/UIKit.framework/Headers/UIView.h"];
    
    XFAFileReader * reader =  XFAFileReader.new;
    NSArray * arr = [reader linesOfSection:@"@interface" sectionName:@"UIView" sectionCategory:@"UIViewGeometry" file:url];
    
    XCTAssertEqual(arr.count, 29, @"lines of setion");
}

-(void)testClassNamesInFile
{
    
    NSString * f = @"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.1.sdk/System/Library/Frameworks/UIKit.framework/Headers/NSParagraphStyle.h";
    NSURL * url = [NSURL URLWithString:f];
    XFAFileReader * reader =  XFAFileReader.new;
    NSArray * arr = [reader namesForSectionType:@"@interface" inFile:url];
    XCTAssertEqualObjects(arr,
                          (@[@"NSMutableParagraphStyle",@"NSParagraphStyle",@"NSTextTab"]), @"class names not found");
    
}


-(void)testFilteringUIViewMethods{
    NSURL * url = [NSURL URLWithString:@"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.1.sdk/System/Library/Frameworks/UIKit.framework/Headers/UIView.h"];
    
    XFAFileReader * reader =  XFAFileReader.new;
    NSArray * arr = [reader linesOfSection:@"@interface" sectionName:@"UIView" sectionCategory:nil file:url];
    NSArray * methodLines = [reader filterMethodLines:arr];
    
    XCTAssertEqualObjects(methodLines,
                          (@[ @"+ (Class)layerClass;" , @"- (id)initWithFrame:(CGRect)frame;" ]), @"should get two method");
    
}


-(void)testFilterMethodsWithLineBreaks{
    
    XFAFileReader * reader =  XFAFileReader.new;
    NSArray * arr = [reader linesOfSection:@"@protocol" sectionName:@"UIViewControllerTransitionCoordinator" sectionCategory:nil
                                      file:[NSURL URLWithString:header_file_UIViewControllerTransitionCoordinator]];
    

    NSArray * methodLines = [reader filterMethodLines:arr];
    XCTAssertEqualObjects([methodLines objectAtIndex:0],
        @"- (BOOL)animateAlongsideTransition:(void (^)(id <UIViewControllerTransitionCoordinatorContext>context))animation completion:(void (^)(id <UIViewControllerTransitionCoordinatorContext>context))completion;"
                          , @"first method not detected");
    
    XCTAssertEqual(methodLines.count, 3, @"count soul dl dld ld ");
}


-(void)testFilterPropertyLines
{
    NSURL * url = [NSURL URLWithString:header_file_UIView];
    XFAFileReader * reader = XFAFileReader.new;
    NSArray * arr = [reader linesOfSection:@"@interface" sectionName:@"UIView" sectionCategory:nil file:url];
    NSArray * propretyLines = [reader filterPropertyLines:arr];
    XCTAssertEqualObjects([propretyLines objectAtIndex:0], @"@property(nonatomic,getter=isUserInteractionEnabled) BOOL userInteractionEnabled;", @"should find the right first right property line");
    XCTAssertEqual(propretyLines.count, 3, @"should find the right number of property lines");
}


-(void)testExtractClassNames
{
    NSURL * url = [NSURL URLWithString:header_file_UIView];
    XFAFileReader * reader = XFAFileReader.new;
    NSArray * classNames = [reader classNamesInLines:[reader linesOfFile:url]];
    XCTAssertEqualObjects( classNames , @[@"UIView" ], @"should get @[UIView] as output");
}


-(void)testExtractClassNamesInParagaphsFile
{
    NSURL * url = [NSURL URLWithString:header_file_NSParagraphStyle];
    XFAFileReader * reader = XFAFileReader.new;
    NSArray * classNames = [reader classNamesInLines:[reader linesOfFile:url]];
    XCTAssertEqualObjects( classNames ,  ( @[ @"NSMutableParagraphStyle",
                                              @"NSParagraphStyle",
                                              @"NSTextTab" ] ),
                          @"should get @[UIView] as output");
    
   
}



-(void)testExtractProtocolNames
{
    NSURL * url = [NSURL URLWithString:header_file_UIViewControllerTransitioning];
    XFAFileReader * reader = XFAFileReader.new;
    NSArray * names = [reader protocolNamesInLines:[reader linesOfFile:url]];
    XCTAssertEqualObjects( names ,
                          (@[
                          @"UIViewControllerInteractiveTransitioning",
                          @"UIViewControllerContextTransitioning",
                          @"UIViewControllerTransitioningDelegate",
                          @"UIViewControllerAnimatedTransitioning" ]),
                          
                          @"should get 4 @[ protocols ] as output");
}



-(void)testClassesDictionaryInFile
{
    /*
     f = Rails.root + "./test/test_subjects/iOS7/NSParagraphStyle.h"
     @parser.classesInFile( f ).must_equal ()
     end
     */
    
    XFAFileReader * reader = XFAFileReader.new;
    NSArray * arr = [reader linesOfFile:[NSURL URLWithString:header_file_NSParagraphStyle]];
    NSDictionary * dic = [reader classesDictionaryInLines:arr];
    NSDictionary * expectedDic = @{ @"NSTextTab" : @"NSObject",
                                    @"NSParagraphStyle" : @"NSObject",
                                    @"NSMutableParagraphStyle" : @"NSParagraphStyle"};
    XCTAssertEqualObjects(dic, expectedDic, @"should get dic of @{class : superclass}");
    
}

-(void)test_retrieval_classCategoriesInLines{

    XFAFileReader * reader = XFAFileReader.new;
    NSArray * lines = [reader linesOfFile:[NSURL URLWithString:header_file_UIView]];
    NSArray * categories = [reader categoriesOfClassNamed:@"UIView" inLines:lines];
    XCTAssertEqual(categories, (@[
                                 @"Geometry",
                                 @"Hierarchy",
                                 @"Rendering",
                                 @"Animation",
                                 @"AnimationWithBlocks",
                                 @"KeyframeAnimations",
                                 @"GestureRecognizers",
                                 @"MotionEffects",
                                 @"UIConstraintBasedLayoutInstallingConstraints",
                                 @"UIConstraintBasedLayoutCoreMethods" ,
                                 @"UIConstraintBasedCompatibility" ,
                                 @"UIConstraintBasedLayoutLayering" ,
                                 @"UIConstraintBasedLayoutFittingSize" ,
                                 @"UIConstraintBasedLayoutDebugging" ,
                                 @"UIStateRestoration" ,
                                 @"UISnapshotting"]),
                   @"categories not found");

}

-(void)test_retrieval_classWithName
{
    XFAFileReader * reader = XFAFileReader.new;
    XFAObjcClass * klass = [reader classNamed:@"UIView" inFile:header_file_UIView];
    XCTAssert(klass , @"UIView class not found in file");
    XCTAssertEqual(klass.className , @"UIView" , @"expected class to be UIView");
    
}


@end


