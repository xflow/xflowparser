//
//  XFAViewController.m
//  HelloWorld
//
//  Created by Mohammed Tillawy on 5/10/14.
//  Copyright (c) 2014 Mohammed O. Tillawy. All rights reserved.
//

#import "XFAViewController.h"

@interface XFAViewController ()

@end

@implementation XFAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actionSwitch:(id)sender {
    NSLog(@"MTViewController actionSwitch");
}


- (IBAction)actionSlider:(id)sender {
    NSLog(@"MTViewController actionSlider");
}

- (IBAction)actionButton:(id)sender {
    NSLog(@"MTViewController actionButton %@",sender);
}


@end
