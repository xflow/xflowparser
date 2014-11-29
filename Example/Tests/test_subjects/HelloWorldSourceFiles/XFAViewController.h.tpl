//
//  XFAViewController.h
//  HelloWorld
//
//  Created by Mohammed Tillawy on 5/10/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFAViewController : UIViewController

@property (nonatomic,weak) IBOutlet UILabel *labelConnected;

- (IBAction)actionSlider:(id)sender;

-(IBAction)actionButton:(id)sender event:(UIEvent*)event;

-(void)dislayText;

@end
