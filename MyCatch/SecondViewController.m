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
@synthesize speciesSwitch;
@synthesize speciesTextField;
@synthesize flySwitch;
@synthesize flyTextField;
@synthesize monthPicker;
@synthesize monthData;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.monthTextField.hidden = YES;
    self.riverTextField.hidden = YES;
    self.speciesTextField.hidden = YES;
    self.flyTextField.hidden = YES;
    self.monthSwitch.hidden = YES;
    self.riverSwitch.hidden = YES;
    self.speciesSwitch.hidden = YES;
    self.flySwitch.hidden = YES;
    
    // Below is initializing the pickerViews and their data, and tags the pickerViews
    
    //  Adding Toolbar with done button to picker views
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleBordered target:self action:@selector(dismissPickerView)];
    toolBar.items = [[NSArray alloc] initWithObjects:flexibleSpace, barButtonDone, nil];
    
    self.monthPicker = [[UIPickerView alloc] init];
    self.monthPicker.dataSource = self;
    self.monthPicker.delegate = self;
    self.monthPicker.tag = 0;
    self.monthData = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", nil];
    

}

-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    FilterSingleton *sharedClass = [FilterSingleton sharedInstance];
    NSLog(@"As the view disapears the riverTextField Says %@", self.riverTextField.text);
    sharedClass.riverString = [NSString stringWithFormat: @"%@", self.riverTextField.text];
    NSLog(@"FilterSington.riverString = %@", sharedClass.riverString);
    
    sharedClass.speciesString = [NSString stringWithFormat:@"%@", self.speciesTextField.text];
    sharedClass.flyString = [NSString stringWithFormat:@"%@", self.speciesTextField.text];
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
        self.speciesSwitch.hidden = NO;
        self.flySwitch.hidden = NO;
        
        
    } else {
        NSLog(@"switch is off");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setFilterOn:NO];
        self.monthSwitch.hidden = YES;
        self.riverSwitch.hidden = YES;
        self.speciesSwitch.hidden = YES;
        self.flySwitch.hidden =YES;
        self.riverTextField.hidden = YES;
        self.speciesTextField.hidden = YES;
        self.flyTextField.hidden = YES;
    }
}

- (IBAction)toggleForRiverSwitch:(id)sender {
    
    if (riverSwitch.on) {
        NSLog(@"Filtering for river");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setRiverOn:YES];
        self.riverTextField.hidden = NO;
    
        sharedInstance.riverString = self.riverTextField.text;
        
        
    } else {
        NSLog(@"Not filtering for river");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setRiverOn:NO];
        self.riverTextField.hidden = YES;
        self.riverTextField.text = nil;
    }
    
}


- (IBAction)toggleForSpeciesSwitch:(id)sender {
    
    if(speciesSwitch.on) {
        NSLog(@"Filtering for species");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setSpeciesOn:YES];
        self.speciesTextField.hidden = NO;
        sharedInstance.speciesString = self.speciesTextField.text;
    } else {
        NSLog(@"Not filtering for species");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setSpeciesOn:NO];
        self.speciesTextField.hidden = YES;
        self.speciesTextField.text = nil;
    }
    
}

- (IBAction)toggleForFlySwitch:(id)sender {
    
    if(flySwitch.on) {
        NSLog(@"Filtering for fly");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setFlyOn:YES];
        self.flyTextField.hidden = NO;
        sharedInstance.flyString = self.flyTextField.text;
    } else {
        NSLog(@"Not filtering for fly");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setFlyOn:NO];
        self.flyTextField.hidden = YES;
        self.flyTextField.text = nil;
    }
}

# pragma mark - Text Field Delegates

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.riverTextField resignFirstResponder];
    [self.speciesTextField resignFirstResponder];
    [self.flyTextField resignFirstResponder];               
}






@end
