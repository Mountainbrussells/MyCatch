//
//  TabBarViewController.m
//  MyCatch
//
//  Created by Ben Russell on 3/5/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import "TabBarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%@", self.user.username);
    
    FirstViewController *fvc = [[self viewControllers] objectAtIndex:0];
    fvc.user = self.user;
    
    SecondViewController *svc = [[self viewControllers] objectAtIndex:1];
    svc.user = self.user;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
