//
//  SecondViewController.m
//  MyCatch
//
//  Created by Ben Russell on 3/3/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import "SecondViewController.h"
#import "FilterSingleton.h"
#import <Parse/Parse.h>

@interface SecondViewController ()
{
    NSMutableArray *_dataArray;
}

@end

@implementation SecondViewController

@synthesize user;
@synthesize filterSwitch;
@synthesize monthSwitch;
@synthesize monthTextField;
@synthesize riverSwitch;
@synthesize riverTextField;
@synthesize speciesSwitch;
@synthesize speciesTextField;
@synthesize flySwitch;
@synthesize flyTextField;
@synthesize weatherSwitch;
@synthesize weatherTextField;

@synthesize monthPicker;
@synthesize monthData;
@synthesize riverPicker;
@synthesize riverData;
@synthesize speciesPicker;
@synthesize speciesData;
@synthesize flyPicker;
@synthesize flyData;
@synthesize weatherPicker;
@synthesize weatherData;

@synthesize scrollView;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray new];
    [self refreshData];
    self.monthTextField.hidden = YES;
    self.riverTextField.hidden = YES;
    self.speciesTextField.hidden = YES;
    self.flyTextField.hidden = YES;
    self.monthSwitch.hidden = YES;
    self.riverSwitch.hidden = YES;
    self.speciesSwitch.hidden = YES;
    self.flySwitch.hidden = YES;
    self.weatherSwitch.hidden = YES;
    self.weatherTextField.hidden = YES;
    
    // add scrollView method
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
    
    tapScroll.cancelsTouchesInView = NO;
    [self.scrollView addGestureRecognizer:tapScroll];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"LighterFishnet_scalechange"]]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    
    FilterSingleton *sharedClass = [FilterSingleton sharedInstance];
    
    
    
   
    sharedClass.monthString = [NSString stringWithFormat:@"%@", self.monthTextField.text];
    sharedClass.riverString = [NSString stringWithFormat: @"%@", self.riverTextField.text];
    sharedClass.speciesString = [NSString stringWithFormat:@"%@", self.speciesTextField.text];
    sharedClass.flyString = [NSString stringWithFormat:@"%@", self.flyTextField.text];
    sharedClass.weatherString = [NSString stringWithFormat:@"%@", self.weatherTextField.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - refresh

- (void) refreshData
{
    [_dataArray removeAllObjects];
    
    // Recall User if needed
    if(!self.user){
        NSUserDefaults *eUser = [NSUserDefaults standardUserDefaults];
        NSString *savedUser = [eUser objectForKey:@"user"];
        PFQuery *query = [PFUser query];
        [query whereKey:@"username" equalTo:savedUser];
        NSArray *array = [query findObjects];
        PFUser *currentUser= [array objectAtIndex:0];
        self.user = currentUser;
        
    }
    
    PFQuery *query = [PFQuery queryWithClassName:@"Catch"];
    [query whereKey:@"user" equalTo:self.user];
    [query orderByAscending:@"date"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [_dataArray addObjectsFromArray:objects];
            // NSLog(@"Filter screen dataArray contains: %@", _dataArray);
            
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];        }
    }];
}
#pragma mark - set up toggle switches

- (IBAction)toggleForFilterSwitch:(id)sender {
    if (filterSwitch.on) {
        NSLog(@"switch is on");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setFilterOn:YES];
        self.monthSwitch.hidden = NO;
        self.riverSwitch.hidden = NO;
        self.speciesSwitch.hidden = NO;
        self.flySwitch.hidden = NO;
        self.weatherSwitch.hidden = NO;
        
        
    } else {
        NSLog(@"switch is off");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setFilterOn:NO];
        
        // turn off all switches and hide them
        self.monthSwitch.hidden = YES;
        self.monthSwitch.on = NO;
        self.riverSwitch.hidden = YES;
        self.riverSwitch.on = NO;
        self.speciesSwitch.hidden = YES;
        self.speciesSwitch.on = NO;
        self.flySwitch.hidden = YES;
        self.flySwitch.on = NO;
        self.weatherSwitch.hidden = YES;
        self.weatherSwitch.on = NO;
        
        // Hide all text fields and set them to nil
        self.monthTextField.hidden = YES;
        self.monthTextField.text = nil;
        self.riverTextField.hidden = YES;
        self.riverTextField.text = nil;
        self.speciesTextField.hidden = YES;
        self.speciesTextField.text = nil;
        self.flyTextField.hidden = YES;
        self.flyTextField.text = nil;
        self.weatherTextField.hidden = YES;
        self.weatherTextField.text = nil;
    }
}

- (IBAction)toggleForMonthSwitch:(id)sender {
    
    if (monthSwitch.on) {
        NSLog(@"Filtering for month");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setMonthOn:YES];
        self.monthTextField.hidden = NO;
        self.monthPicker = [[UIPickerView alloc] init];
        self.monthPicker.dataSource = self;
        self.monthPicker.delegate = self;
        self.monthPicker.tag = 0;
        self.monthData = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", nil];
        
        self.monthTextField.inputView = self.monthPicker;
        sharedInstance.monthString = self.monthTextField.text;
    } else {
        NSLog(@"Not filtering for month");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setMonthOn:NO];
        self.monthTextField.hidden = YES;
        self.monthTextField.text = nil;
    }
    
}



- (IBAction)toggleForRiverSwitch:(id)sender {
    
    if (riverSwitch.on) {
        NSLog(@"Filtering for river");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setRiverOn:YES];
        self.riverTextField.hidden = NO;
        
        self.riverPicker = [[UIPickerView alloc] init];
        NSMutableArray *riverArray = [_dataArray valueForKey:@"river"];
        NSLog(@"riverArray contains %@", riverArray);
        NSMutableSet *riverSet = [[NSMutableSet alloc] initWithArray:riverArray];
        NSLog(@"riverSet contains; %@", riverSet);
        riverArray = [[riverSet allObjects] mutableCopy];
        self.riverData = riverArray;
        self.riverPicker.dataSource = self;
        self.riverPicker.delegate = self;
        self.riverPicker.tag = 1;
        self.riverTextField.inputView = self.riverPicker;
        
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
    
    if (speciesSwitch.on) {
        NSLog(@"Filtering for species");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setSpeciesOn:YES];
        self.speciesTextField.hidden = NO;
        
        self.speciesPicker = [[UIPickerView alloc] init];
        NSMutableArray *speciesArray = [_dataArray valueForKey:@"species"];
        NSMutableSet *speciesSet = [[NSMutableSet alloc] initWithArray:speciesArray];
        speciesArray = [[speciesSet allObjects] mutableCopy];
        self.speciesData = speciesArray;
        self.speciesPicker.dataSource = self;
        self.speciesPicker.delegate = self;
        self.speciesPicker.tag = 2;
        self.speciesTextField.inputView = self.speciesPicker;
        
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
    
    if (flySwitch.on) {
        NSLog(@"Filtering for fly");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setFlyOn:YES];
        self.flyTextField.hidden = NO;
        self.flyPicker = [[UIPickerView alloc] init];
        NSMutableArray *flyArray = [_dataArray valueForKey:@"fly"];
        NSMutableSet *flySet = [[NSMutableSet alloc] initWithArray:flyArray];
        flyArray = [[flySet allObjects] mutableCopy];
        self.flyData = flyArray;
        self.flyPicker.dataSource = self;
        self.flyPicker.delegate = self;
        self.flyPicker.tag = 3;
        self.flyTextField.inputView = self.flyPicker;
        NSLog(@"the fly field reads %@", self.flyTextField.text);
        sharedInstance.flyString = self.flyTextField.text;
    } else {
        NSLog(@"Not filtering for fly");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setFlyOn:NO];
        self.flyTextField.hidden = YES;
        self.flyTextField.text = nil;
    }
}

- (IBAction)toggleForWeatherSwitch:(id)sender {
    
    if (weatherSwitch.on) {
        NSLog(@"Filtering for weather");
        FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
        [sharedInstance setWeatherOn:YES];
        self.weatherTextField.hidden = NO;
        self.weatherPicker = [[UIPickerView alloc] init];
        NSMutableArray *weatherArray = [_dataArray valueForKey:@"weather"];
        NSMutableSet *weatherSet = [[NSMutableSet alloc] initWithArray:weatherArray];
        weatherArray = [[weatherSet allObjects] mutableCopy];
        self.weatherData = weatherArray;
        self.weatherPicker.dataSource = self;
        self.weatherPicker.delegate = self;
        self.weatherPicker.tag = 4;
        self.weatherTextField.inputView = self.weatherPicker;
        sharedInstance.weatherString = self.weatherTextField.text;
    } else {
        NSLog(@"Not filtering for weather");
        FilterSingleton *sharedINstance = [FilterSingleton sharedInstance];
        [sharedINstance setWeatherOn:NO];
        self.weatherTextField.hidden = YES;
        self.weatherTextField.text = nil;
    }
    
}


# pragma mark - Text Field Delegates

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.monthTextField resignFirstResponder];
    [self.riverTextField resignFirstResponder];
    [self.speciesTextField resignFirstResponder];
    [self.flyTextField resignFirstResponder];
    [self.weatherTextField resignFirstResponder];
}

# pragma mark - Pcker View Delegates

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 0){
        return [self.monthData count];
    } else  if(pickerView.tag == 1){
        return [self.riverData count];
    } else if (pickerView.tag == 2){
        return [self.speciesData count];
    } else if (pickerView.tag == 3) {
        return [self.flyData count];
    } else if (pickerView.tag == 4) {
        return [self.weatherData count];
    }
    
    else {
        return 1;
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == 0){
        return [self.monthData objectAtIndex:row];
    } else if (pickerView.tag == 1){
        return [self.riverData objectAtIndex:row];
    } else if (pickerView.tag == 2){
        return [self.speciesData objectAtIndex:row];
    } else if (pickerView.tag == 3){
        return [self.flyData objectAtIndex:row];
    } else if (pickerView.tag ==  4) {
        return [self.weatherData objectAtIndex:row];
    }
    
    else
    {
        return @"error";
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == 0) {
        [self.monthTextField setText:[monthData objectAtIndex:row]];
    }
    
    if (pickerView.tag == 1) {
        [self.riverTextField setText:[riverData objectAtIndex:row]];
    }
    
    if (pickerView.tag == 2 ) {
        [self.speciesTextField setText:[speciesData objectAtIndex:row]];
    }
    
    if (pickerView.tag == 3) {
        [self.flyTextField setText:[flyData objectAtIndex:row]];
    }
    
    if (pickerView.tag == 4) {
        [self.weatherTextField setText:[weatherData objectAtIndex:row]];
    }
}

// tapped method for scrollView

- (void)tapped
{
    [self.monthTextField resignFirstResponder];
    [self.riverTextField resignFirstResponder];
    [self.speciesTextField resignFirstResponder];
    [self.flyTextField resignFirstResponder];
    [self.weatherTextField resignFirstResponder];
}




@end
