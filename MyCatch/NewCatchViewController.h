//
//  NewCatchViewController.h
//  MyCatch
//
//  Created by Ben Russell on 3/9/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface NewCatchViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *catchImageView;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *speciesTextView;
@property (weak, nonatomic) IBOutlet UITextField *riverTextView;
@property (weak, nonatomic) IBOutlet UITextField *flyTextView;
@property (weak, nonatomic) IBOutlet UITextField *weatherTextView;
@property (weak, nonatomic) IBOutlet UITextField *tempTextView;
@property (weak, nonatomic) IBOutlet UITextField *techniqueTextView;
@property (nonatomic, strong) PFUser *user;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end
