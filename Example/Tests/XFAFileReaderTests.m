
//
//  XFAFileReaderTests.m
//  xflow
//
//  Created by Mohammed Tillawy on 4/26/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <xflowparser/XFPFileReader.h>
#import <xflowparser/XFPObjcClass.h>
#import <xflowparser/XFPObjcProperty.h>
#import <xflowparser/XFPObjcMethod.h>
#import <xflowparser/XFPObjcMethodSignature.h>
#import <xflowparser/XFPObjcProtocol.h>

@interface XFAFileReaderTests : XCTestCase{
    NSString * header_file_UIViewControllerTransitioning;
    NSString * header_file_UIViewControllerTransitionCoordinator;
    NSString * header_file_UIView;
    NSString * header_file_NSParagraphStyle;
    NSString * header_file_UINavigationController;
    NSString * header_file_UIViewController;
    NSString * header_file_UITableView;
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

    header_file_UINavigationController = [myBundle pathForResource:@"UINavigationController.h" ofType:nil];
    
    header_file_UIViewController = [myBundle pathForResource:@"UIViewController.h" ofType:nil];
    header_file_UITableView = [myBundle pathForResource:@"UITableView.h" ofType:nil];
    

}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


-(void)test_UIViewController_parser_complex_interface_line
{
    XFPFileReader * reader =  [XFPFileReader new];
    NSURL * url = [NSURL fileURLWithPath:header_file_UIViewController];
    
    NSArray * lines = [reader linesOfSection:@"@interface" sectionName:@"UIViewController" sectionCategory:nil file:url];
    XCTAssertEqual(lines.count, 238 , @"number of lines should be about 500 lines");
    
    NSArray * methodLines = [reader filterMethodLines:lines];
    XCTAssertEqual(methodLines.count, 32 , @"number of lines should be about 500 lines");
}

-(void)testMultiInterfacesInOneFile
{

    XFPFileReader * reader =  [XFPFileReader new];
    NSURL * url = [NSURL fileURLWithPath:header_file_UINavigationController];
    
    NSArray * lines = [reader linesOfFile:url];
    XCTAssert(lines.count > 100, @"number of lines should be about 500 lines");

    NSArray * arr01 = [reader linesOfSection:@"@interface" sectionName:@"UINavigationController" sectionCategory:nil file:url];
    XCTAssertEqual(arr01.count, 34 , @"number of lines should be about 500 lines");

    NSArray * arr02 = [reader linesOfSection:@"interface" sectionName:@"UINavigationController" sectionCategory:@"" file:url];
    XCTAssertEqual(arr02.count, 34 , @"number of lines should be about 500 lines");
    
    NSArray * arr1 = [reader linesOfSection:@"@interface" sectionName:@"UIViewController" sectionCategory:@"UINavigationControllerItem" file:url];
    XCTAssertEqual(arr1.count, 7 , @"number of lines should be about 500 lines");
    
    NSArray * arr2 = [reader linesOfSection:@"@interface" sectionName:@"UIViewController" sectionCategory:@"UINavigationControllerContextualToolbarItems" file:url];
    XCTAssertEqual(arr2.count, 6 , @"number of lines should be about 500 lines");

    NSArray * arr3 = [reader linesOfSection:@"@interface" sectionName:@"UIViewController" sectionCategory:nil file:url];
    XCTAssertEqual(arr3.count, 0, @"should not get any results");

    NSArray * arr4 = [reader linesOfSection:@"@interface" sectionName:@"UIViewController" sectionCategory:@"" file:url];
    XCTAssertEqual(arr4.count, 0, @"should not get any results");
    
    NSArray * classCategories = [reader categoriesOfClassNamed:@"UIViewController" inLines:lines];
    XCTAssertEqualObjects(classCategories, (@[@"UINavigationControllerItem", @"UINavigationControllerContextualToolbarItems"]));
}

- (void)testReaderNumberOfLines
{
    XFPFileReader * reader =  [XFPFileReader new];
//    NSURL * url = [NSURL URLWithString:@"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.1.sdk/System/Library/Frameworks/UIKit.framework/Headers/UIView.h"];
   NSString * str = [[NSBundle bundleForClass:self.class] pathForResource:@"UIView.h" ofType:nil];
    NSURL * url = [NSURL fileURLWithPath:str];
    
    NSArray * arr = [reader linesOfFile:url];
    XCTAssert(arr.count > 500, @"number of lines should be about 500 lines");
    
}


-(void)testInterfaceLinesWithoutCategory{
//    NSURL * url = [NSURL URLWithString:@"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.1.sdk/System/Library/Frameworks/UIKit.framework/Headers/UIView.h"];
    NSString * str = [[NSBundle bundleForClass:self.class] pathForResource:@"UIView.h" ofType:nil];
    NSURL * url = [NSURL fileURLWithPath:str];
    XFPFileReader * reader =  [XFPFileReader new];
    NSArray * arr = [reader linesOfSection:@"@interface" sectionName:@"UIView" sectionCategory:nil file:url];
    
    XCTAssertEqual(arr.count, 89, @"lines of setion");
}



-(void)testProtocolLinesWitCategory{
    NSURL * url = [NSURL fileURLWithPath:header_file_UIViewControllerTransitionCoordinator];
    
    XFPFileReader * reader = [XFPFileReader new];
    NSArray * arr = [reader linesOfSection:@"@protocol" sectionName:@"UIViewControllerTransitionCoordinator" sectionCategory:nil file:url];
    XCTAssertEqualObjects([arr objectAtIndex:0], @"@protocol UIViewControllerTransitionCoordinator <UIViewControllerTransitionCoordinatorContext>", @"should detect first line ");
    XCTAssertEqual(arr.count, 35, @"lines of setion");
}

-(void)testInterfaceLinesWitCategory{
//    NSURL * url = [NSURL URLWithString:@"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.1.sdk/System/Library/Frameworks/UIKit.framework/Headers/UIView.h"];
    
    NSURL * url = [NSURL fileURLWithPath:header_file_UIView];
    
    XFPFileReader * reader =  [XFPFileReader new];
    NSArray * arr = [reader linesOfSection:@"@interface" sectionName:@"UIView" sectionCategory:@"UIViewGeometry" file:url];
    
    XCTAssertEqual(arr.count, 29, @"lines of setion");
}

-(void)testClassNamesInFile
{
    
//    NSString * f = @"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.1.sdk/System/Library/Frameworks/UIKit.framework/Headers/NSParagraphStyle.h";
    NSURL * url = [NSURL fileURLWithPath:header_file_NSParagraphStyle];

    XFPFileReader * reader =  [XFPFileReader new];
    NSArray * arr = [reader namesForSectionType:@"@interface" inFile:url];
    XCTAssertEqualObjects(arr,
                          (@[@"NSMutableParagraphStyle",@"NSParagraphStyle",@"NSTextTab"]), @"class names not found");
    
}


-(void)testProtocolLinesInFile{
    NSURL * url = [NSURL fileURLWithPath:header_file_UITableView];
    XFPFileReader * reader =  [XFPFileReader new];
    NSArray * lines = [reader linesOfSection:@"protocol" sectionName:@"UITableViewDataSource" sectionCategory:@"" file:url];
    XCTAssertEqual(lines.count, 44);
}

-(void)testProtocolNamedInFile
{
    NSURL * url = [NSURL fileURLWithPath:header_file_UITableView];
    XFPFileReader * reader =  [XFPFileReader new];
    XFPObjcProtocol * protocol = [reader protocolNamed:@"UITableViewDataSource" inFile:url];
    XCTAssert(protocol);
    XCTAssertEqual(protocol.methods.count, 11);
    XFPObjcMethod * method0 = protocol.methods[0];
    XCTAssertEqualObjects(method0.methodSignature.signatureName, @"tableView:numberOfRowsInSection:");
    XCTAssertTrue(method0.isRequiredByObjcProtocol);
    XCTAssertFalse(method0.isOptionalByObjcProtocol);
    XFPObjcMethod * method1 = protocol.methods[1];
    XCTAssertEqualObjects( method1.methodSignature.signatureName, @"tableView:cellForRowAtIndexPath:");
    XCTAssertTrue(method1.isRequiredByObjcProtocol);
    XCTAssertFalse(method1.isOptionalByObjcProtocol);
    XFPObjcMethod * method2 = protocol.methods[2];
    XCTAssertEqualObjects(method2.methodSignature.signatureName, @"numberOfSectionsInTableView:");
    XCTAssertFalse(method2.isRequiredByObjcProtocol);
    XCTAssertTrue(method2.isOptionalByObjcProtocol);

    XCTAssertEqual(protocol.properties.count, 0);
}



-(void)testFilteringUIViewMethods{
//    NSURL * url = [NSURL URLWithString:@"/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.1.sdk/System/Library/Frameworks/UIKit.framework/Headers/UIView.h"];
    
    NSURL * url = [NSURL fileURLWithPath:header_file_UIView];

    XFPFileReader * reader =  [XFPFileReader new];
    NSArray * arr = [reader linesOfSection:@"@interface" sectionName:@"UIView" sectionCategory:nil file:url];
    NSArray * methodLines = [reader filterMethodLines:arr];
    
    XCTAssertEqualObjects(methodLines,
                          (@[ @"+ (Class)layerClass;" , @"- (id)initWithFrame:(CGRect)frame;" ]), @"should get two method");
    
}


-(void)testFilterMethodsWithLineBreaks{
    
    XFPFileReader * reader = [XFPFileReader new];
    NSArray * arr = [reader linesOfSection:@"@protocol" sectionName:@"UIViewControllerTransitionCoordinator" sectionCategory:nil
                                      file:[NSURL fileURLWithPath:header_file_UIViewControllerTransitionCoordinator]];
    

    NSArray * methodLines = [reader filterMethodLines:arr];
    XCTAssertEqualObjects([methodLines objectAtIndex:0],
        @"- (BOOL)animateAlongsideTransition:(void (^)(id <UIViewControllerTransitionCoordinatorContext>context))animation completion:(void (^)(id <UIViewControllerTransitionCoordinatorContext>context))completion;"
                          , @"first method not detected");
    
    XCTAssertEqual(methodLines.count, 3, @"count soul dl dld ld ");
}


-(void)testFilterPropertyLines
{
    NSURL * url = [NSURL fileURLWithPath:header_file_UIView];
    XFPFileReader * reader = [XFPFileReader new];
    NSArray * arr = [reader linesOfSection:@"@interface" sectionName:@"UIView" sectionCategory:nil file:url];
    NSArray * propretyLines = [reader filterPropertyLines:arr];
    XCTAssertEqualObjects([propretyLines objectAtIndex:0], @"@property(nonatomic,getter=isUserInteractionEnabled) BOOL userInteractionEnabled;", @"should find the right first right property line");
    XCTAssertEqual(propretyLines.count, 3, @"should find the right number of property lines");
}


-(void)testExtractClassNames
{
    NSURL * url = [NSURL fileURLWithPath:header_file_UIView];
    XFPFileReader * reader = [XFPFileReader new];
    NSArray * classNames = [reader classNamesInLines:[reader linesOfFile:url]];
    XCTAssertEqualObjects( classNames , @[@"UIView" ], @"should get @[UIView] as output");
}


-(void)testExtractClassNamesInParagaphsFile
{
    NSURL * url = [NSURL fileURLWithPath:header_file_NSParagraphStyle];
    XFPFileReader * reader = [XFPFileReader new];
    NSArray * classNames = [reader classNamesInLines:[reader linesOfFile:url]];
    XCTAssertEqualObjects( classNames ,  ( @[ @"NSMutableParagraphStyle",
                                              @"NSParagraphStyle",
                                              @"NSTextTab" ] ),
                          @"should get @[UIView] as output");
    
   
}



-(void)testExtractProtocolNames
{
    NSURL * url = [NSURL fileURLWithPath:header_file_UIViewControllerTransitioning];
    XFPFileReader * reader = [XFPFileReader new];
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
    
    XFPFileReader * reader = [XFPFileReader new];
    NSArray * arr = [reader linesOfFile:[NSURL fileURLWithPath:header_file_NSParagraphStyle]];
    NSDictionary * dic = [reader classesDictionaryInLines:arr];
    NSDictionary * expectedDic = @{ @"NSTextTab" : @"NSObject",
                                    @"NSParagraphStyle" : @"NSObject",
                                    @"NSMutableParagraphStyle" : @"NSParagraphStyle"};
    XCTAssertEqualObjects(dic, expectedDic, @"should get dic of @{class : superclass}");
    
}


-(void)test_retrieval_classCategoriesInLines{

    XFPFileReader * reader = [XFPFileReader new];
    NSArray * lines = [reader linesOfFile:[NSURL fileURLWithPath:header_file_UIView]];
    NSArray * categories = [reader categoriesOfClassNamed:@"UIView" inLines:lines];
    XCTAssertEqualObjects(categories, (@[
                                 @"UIViewGeometry",
                                 @"UIViewHierarchy",
                                 @"UIViewRendering",
                                 @"UIViewAnimation",
                                 @"UIViewAnimationWithBlocks",
                                 @"UIViewKeyframeAnimations",
                                 @"UIViewGestureRecognizers",
                                 @"UIViewMotionEffects",
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
    XFPFileReader * reader = [XFPFileReader new];
    XFPObjcClass * klass = [reader classNamed:@"UIView" withCategory:nil inFile:[NSURL fileURLWithPath: header_file_UIView]];
    XFPObjcProperty * p = [klass.properties firstObject];
    NSLog(@"%@",p.propertyName);
    XCTAssert(p.propertyName);
    XFPObjcMethod * m = [klass.methods firstObject];
    XCTAssert(m.methodName, @"");
    XCTAssertEqual(klass.className,@"UIView", @"bad classname %@",klass.className);
 
    XCTAssertEqualObjects(klass.superClassName,@"UIResponder", @"bad superclassname %@",klass.superClassName);
    XCTAssertEqual(klass.properties.count, 3, @"class properties should be ");
    XCTAssertEqual(klass.methods.count, 2, @"class properties should be ");
    XCTAssert(klass , @"UIView class not found in file");
    XCTAssertEqual(klass.className , @"UIView" , @"expected class to be UIView");
    
}


@end


