//
//  NewCatchViewController.m
//  MyCatch
//
//  Created by Ben Russell on 3/9/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import "NewCatchViewController.h"

@interface NewCatchViewController ()

@end

@implementation NewCatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBActions

- (IBAction)backButton:(id)sender {
}

- (IBAction)photoButton:(id)sender {
}

- (IBAction)saveButton:(id)sender {
    
    PFObject *catch = [PFObject objectWithClassName:@"Catch"];
    
    //need to figure out user
    catch[@"user"] = @"user";
    catch[@"date"] = self.dateLabel.text;
    catch[@"species"] = self.speciesTextView.text;
    catch[@"river"] = self.riverTextView.text;
    catch[@"fly"] = self.flyTextView.text;
    catch[@"weather"] = self.weatherTextView.text;
    catch[@"temperature"] = self.tempTextView.text;
    catch[@"technique"] = self.techniqueTextView.text;
    [catch saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // transition back to list screen
        } else {
            // present error message
        }
    }];
    
    
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
