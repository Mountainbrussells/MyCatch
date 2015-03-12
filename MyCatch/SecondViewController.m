//
//  SecondViewController.m
//  MyCatch
//
//  Created by Ben Russell on 3/3/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import "SecondViewController.h"
#import "FilterSingleton.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize filterSwitch;
@synthesize monthSwitch;
@synthesize monthTextField;
@synthesize riverSwitch;
@synthesize riverTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.riverTextField.hidden = YES;
    self.monthSwitch.hidden = YES;
    self.riverSwitch.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    FilterSingleton *sharedClass = [FilterSingleton sharedInstance];
    sharedClass.riverString = self.riverTextField.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleForFilterSwitch:(id)sender {
    if (filterSwitch.on) {
        NSLog(@"switch is on");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setFilterOn:YES];
        self.monthSwitch.hidden = NO;
        self.riverSwitch.hidden = NO;
        
        
    } else {
        NSLog(@"switch is off");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setFilterOn:NO];
        self.monthSwitch.hidden = YES;
        self.riverSwitch.hidden = YES;
    }
}

- (IBAction)toggleForRiverSwitch:(id)sender {
    
    if (riverSwitch.on) {
        NSLog(@"Filtering for river");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setRiverOn:YES];
        self.riverTextField.hidden = NO;
        
        
    } else {
        NSLog(@"Not filtering for river");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setRiverOn:NO];
        self.riverTextField.hidden = YES;
        self.riverTextField.text = nil;
    }
    
}






@end
