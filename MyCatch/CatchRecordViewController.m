//
//  CatchRecordViewController.m
//  MyCatch
//
//  Created by Ben Russell on 3/12/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import "CatchRecordViewController.h"

@interface CatchRecordViewController ()

@end

@implementation CatchRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    
    PFObject *catch = self.catch;
    self.dateLabel.text = [catch objectForKey:@"date"];
    self.speciesText.text = [catch objectForKey:@"species"];
    self.riverText.text = [catch objectForKey:@"river"];
    self.flyText.text = [catch objectForKey:@"fly"];
    self.weatherText.text = [catch objectForKey:@"weather"];
    self.temperatureText.text = [catch objectForKey:@"temperature"];
    self.techniqueText.text = [catch objectForKey:@"technique"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
