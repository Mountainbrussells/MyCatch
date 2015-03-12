//
//  CatchRecordViewController.h
//  MyCatch
//
//  Created by Ben Russell on 3/12/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CatchRecordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *catchImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *speciesText;
@property (weak, nonatomic) IBOutlet UITextField *riverText;
@property (weak, nonatomic) IBOutlet UITextField *flyText;
@property (weak, nonatomic) IBOutlet UITextField *weatherText;
@property (weak, nonatomic) IBOutlet UITextField *temperatureText;
@property (weak, nonatomic) IBOutlet UITextField *techniqueText;
@property (strong, nonatomic) PFObject *catch;


@end
