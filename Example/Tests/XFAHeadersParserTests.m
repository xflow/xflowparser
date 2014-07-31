//
//  HeadersParserTests.m
//  HeadersParserTests
//
//  Created by Mohammed Tillawy on 4/25/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <xflowparser/XFAFileReader.h>
#import <xflowparser/XFAHeadersParser.h>

@interface XFAHeadersParserTests : XCTestCase
{
    NSString * header_file_UIViewControllerTransitioning;
    NSString * header_file_UIView;
    NSString * header_file_NSParagraphStyle;
}

@end

@implementation XFAHeadersParserTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    header_file_UIViewControllerTransitioning = @"/Users/mohammed/works/TestingFramework/tioxer_api/test/test_subjects/iOS7/UIViewControllerTransitioning.h";
    header_file_UIView = @"/Users/mohammed/works/TestingFramework/tioxer_api/test/test_subjects/iOS7/UIView.h";
    header_file_NSParagraphStyle = @"/Users/mohammed/works/TestingFramework/tioxer_api/test/test_subjects/iOS7/NSParagraphStyle.h";
    

	
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


-(void)testFilteredClassesLines{
    XFAFileReader * reader = XFAFileReader.new;
    NSArray * linesOfFile = [reader linesOfFile:[NSURL URLWithString:header_file_UIView]];
    XFAHeadersParser * parser = XFAHeadersParser.new;
   NSArray * output = [parser filteredClassesLines:linesOfFile];
    XCTAssertEqualObjects(output, @[@"NS_CLASS_AVAILABLE_IOS(2_0) @interface UIView : UIResponder<NSCoding, UIAppearance, UIAppearanceContainer, UIDynamicItem> {"], @"interface line in UIView.h" );
}

-(void)testNumberOfClassesInFile{
    
    
//    it 'should get right number of classes UIViewControllerTransitioning'
    
//    NSData * d = [NSData dataWithContentsOfFile:<#(NSString *)#> options:<#(NSDataReadingOptions)#> error:<#(NSError *__autoreleasing *)#>];
    
//    [fileReader classNamesInFilenamed:];
//        n = FileReader.new.class_names_in_file @header_file_UIViewControllerTransitioning
//        n.count.must_equal 1
    
}

@end
