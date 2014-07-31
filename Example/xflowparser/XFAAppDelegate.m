//
//  XFAAppDelegate.m
//  xflowparser
//
//  Created by CocoaPods on 07/31/2014.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//


#import "XFAAppDelegate.h"


@implementation XFAAppDelegate



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "com.xflow.xflow" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"io.xflow.parser"];
}

- (IBAction)saveAction:(id)sender{
    
}

- (IBAction)showPreferencesPanel:(id)sender {
    
    // We always show the same preferences panel. Its controller doesn't get deallocated when the user closes it.
    if (!self.preferencesPanelController) {
        _preferencesPanelController = [[NSWindowController alloc] initWithWindowNibName:@"XFAPreferencesWC"];
        
        // Make the panel appear in a good default location.
        [[self.preferencesPanelController window] center];
        
    }
    [self.preferencesPanelController showWindow:sender];
    
}


@end
