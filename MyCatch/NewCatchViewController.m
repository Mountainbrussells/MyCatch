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

@synthesize scrollView;

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
    
    [self.catchImageView.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.catchImageView.layer setBorderWidth:2.0];
    
    // add scrollView method
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
    
    tapScroll.cancelsTouchesInView = NO;
    [self.scrollView addGestureRecognizer:tapScroll];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"LighterFishnet_scalechange"]]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBActions

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    NSString *species = [self.speciesTextView.text capitalizedString];
    catch[@"species"] = species;
    NSString *river = [self.riverTextView.text capitalizedString];
    catch[@"river"] = river;
    NSString *fly = [self.flyTextView.text capitalizedString];
    catch[@"fly"] = fly;
    NSString *weather = [self.weatherTextView.text capitalizedString];
    catch[@"weather"] = weather;
    NSString *temp = [self.tempTextView.text capitalizedString];
    catch[@"temperature"] = temp;
    NSString *technique = [self.techniqueTextView.text capitalizedString];
    catch[@"technique"] = technique;
    
    // set catch image
    if (!self.catchImageView.image) {
        NSLog(@"there is no photo");
    } else {
    NSData *imageData = UIImageJPEGRepresentation(self.catchImageView.image, 0.5f);
    PFFile *file = [PFFile fileWithData:imageData];
    catch[@"photo"] = file;
    }
    
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

// tapped method for scrollView

- (void)tapped
{
    [self.tempTextView resignFirstResponder];
    [self.riverTextView resignFirstResponder];
    [self.speciesTextView resignFirstResponder];
    [self.flyTextView resignFirstResponder];
    [self.weatherTextView resignFirstResponder];
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
