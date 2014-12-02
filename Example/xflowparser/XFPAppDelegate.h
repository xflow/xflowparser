//
//  XFAAppDelegate.h
//  xflowparser
//
//  Created by CocoaPods on 07/31/2014.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface XFPAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (nonatomic, readonly) NSWindowController *preferencesPanelController;

@property (nonatomic, readonly) NSWindowController * graphicsInspectorController;


- (IBAction)saveAction:(id)sender;

@end