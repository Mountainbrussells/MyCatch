//
//  SignUpViewController.m
//  MyCatch
//
//  Created by Ben Russell on 3/4/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *passwordCheckText;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if ([identifier isEqualToString:@"SignupSuccesful" ]) {
        
        return NO;
        
    }
    
    return YES;
    
}

- (IBAction)signUp:(id)sender {
    
    // Create a Parse User Object
    PFUser *user = [PFUser user];
    
    // Assign User Name
    user.username = self.userText.text;
    
    // Check to make sure passwords match
    NSString *passwordCheck = self.passwordCheckText.text;
    
    if ([self.passwordText.text isEqualToString:passwordCheck])
    {
        // If passwords match assign password
        user.password = self.passwordText.text;
        
        // Send user to parse
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                //The registration was successful, go to the wall
                [self performSegueWithIdentifier:@"SignupSuccesful" sender:self];
                
            } else {
                //Something bad has occurred
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [errorAlertView show];
            }
        }];
    
    } else {
        
        // Show a warning
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password Error" message:@"Your passwords don't match!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
            }
    
    
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
