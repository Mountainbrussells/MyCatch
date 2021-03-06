//
//  FirstViewController.m
//  MyCatch
//
//  Created by Ben Russell on 3/3/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import <Parse/Parse.h>
#import "FirstViewController.h"
#import "NewCatchViewController.h"
#import "CatchRecordViewController.h"
#import "LogInViewController.h"
#import "CustomTableViewCell.h"
#import "FilterSingleton.h"
#import "SSKeyChain.h"
#import "SSKeyChainQuery.h"


@interface FirstViewController ()
{
    NSMutableArray *_dataArray;
}

@end

@implementation FirstViewController

@synthesize catchTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    catchTable.delegate = self;
    catchTable.dataSource = self;
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"LighterFishnet_scalechange"]]];
    [self.catchTable setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _dataArray = [NSMutableArray new];
    NSLog(@"FirstViewController is appearing");
    
    
    
    // Check if singleton working
    FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
    
    if (sharedInstance.filterOn == YES) {
        NSLog(@"Filter is on!");
        [self filterData];
        
    } else {
        NSLog(@"Filter is off");
        [self refreshData];
    }
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
            //NSLog(@"Successfully retrieved: %@", objects);
            [_dataArray addObjectsFromArray:objects];
            
            //NSLog(@"dataArray contains: %@", _dataArray);
            
            // Load data into table once it has been retrieved
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.catchTable reloadData];
            });
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [errorAlertView show];        }
    }];
    
}

- (void) filterData
{
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
    
    FilterSingleton *sharedInstance = [FilterSingleton sharedInstance];
    NSMutableArray *filterArray = [[NSMutableArray alloc] init];
    [filterArray removeAllObjects];
    
    if (sharedInstance.monthOn == YES) {
        
        if([sharedInstance.monthString isEqualToString:@""]){
            NSLog(@"The month field is blank");
        } else {
            NSString *monthString = [NSString stringWithFormat:@"month = '%@'", sharedInstance.monthString];
            NSLog(@"%@", monthString);
            [filterArray addObject:monthString];
                  }
        
    }
    
    if (sharedInstance.riverOn == YES) {
        if ([sharedInstance.riverString isEqualToString:@""]) {
            NSLog(@"The River Field is blank");
        } else {
        
            NSString *riverString = [NSString stringWithFormat:@"river = '%@'", sharedInstance.riverString];
            NSLog(@"%@", riverString);
            [filterArray addObject:riverString];
        }
        
    }
    
    if (sharedInstance.speciesOn == YES) {
        if ([sharedInstance.speciesString isEqualToString:@""]){
            NSLog(@"The species field is blank");
        } else {
        NSString *speciesString = [ NSString stringWithFormat:@"species = '%@'", sharedInstance.speciesString];
        NSLog(@"%@", speciesString);
        [filterArray addObject:speciesString];
        }
    }
    
    if (sharedInstance.flyOn == YES) {
        if ([sharedInstance.flyString isEqualToString:@""]){
            NSLog(@"the fly field is blank");
            
        } else {
        NSString *flyString = [NSString stringWithFormat:@"fly = '%@'", sharedInstance.flyString];
        NSLog(@"The fly string is %@", flyString);
        [filterArray addObject:flyString];
        }
        
    }
    
    if (sharedInstance.weatherOn == YES) {
        if ([sharedInstance.weatherString isEqualToString:@""]) {
            NSLog(@"The weather field is blank");
        } else {
            NSString *weatherString = [NSString stringWithFormat:@"weather = '%@'", sharedInstance.weatherString];
            NSLog(@"The weather string is %@", weatherString);
            [filterArray addObject:weatherString];
        }
    }
    
    NSString *filterString = [NSString stringWithFormat:@"%@", [filterArray componentsJoinedByString:@" AND "]];
    
    if ([filterString  isEqual: @""]) {
        [self refreshData];
    } else {
    
        //  YAY I love it when I find easy solutions to problems!
        NSLog(@"%@", [filterArray componentsJoinedByString:@" AND "]);
        NSString *predicateString = [NSString stringWithFormat:@"%@", [filterArray componentsJoinedByString:@" AND "]];
        NSLog(@"%@", predicateString);
    
        NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
        PFQuery *query = [PFQuery queryWithClassName:@"Catch" predicate:predicate];
        [query whereKey:@"user" equalTo:self.user];
        [query orderByAscending:@"date"];
    
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // NSLog(@"Successfully retrieved: %@", objects);
                [_dataArray addObjectsFromArray:objects];
                // NSLog(@"dataArray contains: %@", _dataArray);
            
                // Load data into table once it has been retrieved
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.catchTable reloadData];
                });
            } else {
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [errorAlertView show];        }
        }];
    }
}



# pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //  This is where the count of cells will come from the back end
    NSLog(@"there are %lu catches", (unsigned long)_dataArray.count);
    return _dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"customCellIdentifier"];
    
    // pull individual objects properties from array
    PFObject *catch = [_dataArray objectAtIndex:indexPath.row];
    cell.dateLabel.text = [catch objectForKey:@"date"];
    cell.riverLabel.text = [catch objectForKey:@"river"];
    cell.speciesLabel.text = [catch objectForKey:@"species"];
    // Get image
    PFFile *imageFile = [catch objectForKey:@"photo"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            cell.catchImageView.image = image;
        }
    }];
    
    return cell;
}

#pragma mark - segue preperations

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showNewCatch"]) {
        NewCatchViewController *ncvc = segue.destinationViewController;
        ncvc.user = self.user;
    } else if ([segue.identifier isEqualToString:@"showCatchRecord"]) {
        NSIndexPath *indexPath = [self.catchTable indexPathForSelectedRow];
        CatchRecordViewController *recordView = segue.destinationViewController;
        recordView.catch = [_dataArray objectAtIndex:indexPath.row];
    }}

#pragma mork - log out protocol

- (IBAction)logOut:(id)sender {
    
    NSUserDefaults *eUser = [NSUserDefaults standardUserDefaults];
    NSString *savedUser = [eUser objectForKey:@"user"];
    // Remove password
    [SSKeychain deletePasswordForService:@"com.BenRussell.MyCatch" account:savedUser];
    // Remove user
    [eUser removeObjectForKey:@"user"];
    // go to rootview controller
    // USERNAME AND PASWORD ARE STILL POPULATED AFTER ViewController DISMISSED
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LogInViewController *livc = [storyBoard instantiateViewControllerWithIdentifier:@"LogIn"];
    [self presentViewController:livc animated:YES completion:nil];
}


@end
