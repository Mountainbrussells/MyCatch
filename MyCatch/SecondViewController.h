//
//  SecondViewController.h
//  MyCatch
//
//  Created by Ben Russell on 3/3/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SecondViewController : UIViewController<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>


@property (nonatomic, strong) PFUser *user;

@property (weak, nonatomic) IBOutlet UISwitch *filterSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *monthSwitch;
@property (weak, nonatomic) IBOutlet UITextField *monthTextField;
@property (weak, nonatomic) IBOutlet UISwitch *riverSwitch;
@property (weak, nonatomic) IBOutlet UITextField *riverTextField;
@property (weak, nonatomic) IBOutlet UISwitch *speciesSwitch;
@property (weak, nonatomic) IBOutlet UITextField *speciesTextField;
@property (weak, nonatomic) IBOutlet UISwitch *flySwitch;
@property (weak, nonatomic) IBOutlet UITextField *flyTextField;
@property (weak, nonatomic) IBOutlet UISwitch *weatherSwitch;
@property (weak, nonatomic) IBOutlet UITextField *weatherTextField;


// Adding pickerViews and arrays

@property (strong, nonatomic) UIPickerView *monthPicker;
@property (strong, nonatomic) NSMutableArray *monthData;
@property (strong, nonatomic) UIPickerView *riverPicker;
@property (strong, nonatomic) NSMutableArray *riverData;
@property (strong, nonatomic) UIPickerView *speciesPicker;
@property (strong, nonatomic) NSMutableArray *speciesData;
@property (strong, nonatomic) UIPickerView *flyPicker;
@property (strong, nonatomic) NSMutableArray *flyData;
@property (strong, nonatomic) UIPickerView *weatherPicker;
@property (strong, nonatomic) NSMutableArray *weatherData;

// scrollView

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

