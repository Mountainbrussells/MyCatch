//
//  SecondViewController.h
//  MyCatch
//
//  Created by Ben Russell on 3/3/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UISwitch *filterSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *monthSwitch;
@property (weak, nonatomic) IBOutlet UITextField *monthTextField;
@property (weak, nonatomic) IBOutlet UISwitch *riverSwitch;
@property (weak, nonatomic) IBOutlet UITextField *riverTextField;
@property (weak, nonatomic) IBOutlet UISwitch *speciesSwitch;
@property (weak, nonatomic) IBOutlet UITextField *speciesTextField;
@property (weak, nonatomic) IBOutlet UISwitch *flySwitch;
@property (weak, nonatomic) IBOutlet UITextField *flyTextField;

// Adding pickerViews and arrays

@property (strong, nonatomic) UIPickerView *monthPicker;
@property (strong, nonatomic) NSMutableArray *monthData;



@end

