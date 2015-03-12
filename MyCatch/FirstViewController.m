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
#import "CustomTableViewCell.h"


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
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    _dataArray = [NSMutableArray new];
//    
//    [self refreshData];

}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _dataArray = [NSMutableArray new];
    
    [self refreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - refresh

- (void) refreshData
{
    [_dataArray removeAllObjects];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Catch"];
    [query whereKey:@"user" equalTo:self.user];
    [query orderByAscending:@"date"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved: %@", objects);
            [_dataArray addObjectsFromArray:objects];
            NSLog(@"dataArray contains: %@", _dataArray);
            
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

@end
