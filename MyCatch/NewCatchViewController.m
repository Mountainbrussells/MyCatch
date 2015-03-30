//
//  NewCatchViewController.m
//  MyCatch
//
//  Created by Ben Russell on 3/9/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import "NewCatchViewController.h"

@interface NewCatchViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@end

@implementation NewCatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *now = [NSDate date];
    // You need an NSDateFormatter that will turn a date into a simple string
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter){
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
    }
    
    // Use filtered NSDate object to set dateLabel contents
    self.dateLabel.text = [dateFormatter stringFromDate:now];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBActions

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)photoButton:(id)sender {
}

- (IBAction)saveButton:(id)sender {
    
    PFObject *catch = [PFObject objectWithClassName:@"Catch"];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger month = [components month];
    NSString *monthString = [NSString stringWithFormat:@"%ld", (long)month];
    // set catch properties
    catch[@"user"] = self.user;
    catch[@"date"] = self.dateLabel.text;
    catch[@"month"] = monthString;
    catch[@"species"] = self.speciesTextView.text;
    catch[@"river"] = self.riverTextView.text;
    catch[@"fly"] = self.flyTextView.text;
    catch[@"weather"] = self.weatherTextView.text;
    catch[@"temperature"] = self.tempTextView.text;
    catch[@"technique"] = self.techniqueTextView.text;
    
    // set catch image
    NSData *imageData = UIImageJPEGRepresentation(self.catchImageView.image, 0.5f);
    PFFile *file = [PFFile fileWithData:imageData];
    catch[@"photo"] = file;
    
    [catch saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // transition back to list screen
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            // present error message
        }
    }];
    
    
}

- (IBAction)takePhoto:(id)sender {
    
    // Create image picker
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // Take a picture
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    // Place picker on the screen
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)choosePhoto:(id)sender {
    // Create image picker
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // Choose photo
    imagePicker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    
    
    imagePicker.delegate = self;
    
    // Place picker on the screen
    [self presentViewController:imagePicker animated:YES completion:nil];
}



- (void)setImageForCatch:(UIImage*)img {
    self.catchImageView.image = img;
    self.catchImageView.backgroundColor = [UIColor clearColor];
}

// Populate photo into UIImageView
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    
    
    
    
    
    
    self.catchImageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

# pragma mark - Text Field Delegates

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.speciesTextView resignFirstResponder];
    [self.riverTextView resignFirstResponder];
    [self.flyTextView resignFirstResponder];
    [self.weatherTextView resignFirstResponder];
    [self.tempTextView resignFirstResponder];
    [self.techniqueTextView resignFirstResponder];
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
