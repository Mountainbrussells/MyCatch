//
//  LogInViewController.m
//  MyCatch
//
//  Created by Ben Russell on 3/4/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import "LogInViewController.h"
#import "TabBarViewController.h"
#import <Parse/Parse.h>

@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (strong, nonatomic) PFUser *user;

@end

@implementation LogInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.passwordText.secureTextEntry = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSString *user = self.userName.text;
    NSString *password = self.passwordText.text;
    
    // [SSKeychain setPass]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if ([identifier isEqualToString:@"LoginSuccesful" ]) {
        
        return NO;
        
    }
    
    return YES;
    
}
- (IBAction)logIn:(id)sender {
    
    [PFUser logInWithUsernameInBackground:self.userName.text password:self.passwordText.text block:^(PFUser *user, NSError *error) {
        if (user) {
            
            self.user = user;
            NSLog(@"%@", self.user.username);
            
            //Open the wall
            [self performSegueWithIdentifier:@"LoginSuccesful" sender:self];
        } else {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LoginSuccesful"]) {
        
        TabBarViewController *mainView = segue.destinationViewController;
        
        mainView.user = self.user;
        
    }
}


@end
