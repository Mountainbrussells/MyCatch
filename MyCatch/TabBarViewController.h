//
//  TabBarViewController.h
//  MyCatch
//
//  Created by Ben Russell on 3/5/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Parse/Parse.h>

@interface TabBarViewController : UITabBarController

@property (nonatomic, strong) PFUser *user;

@end
