//
//  SecondViewController.m
//  MyCatch
//
//  Created by Ben Russell on 3/3/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize filterSwitch;
@synthesize monthSwitch;
@synthesize monthTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleForFilterSwitch:(id)sender {
    if (filterSwitch.on) {
        NSLog(@"switch is on");
    } else {
        NSLog(@"switch is off");
    }
}




@end
