//
//  CustomTableViewCell.h
//  MyCatch
//
//  Created by Ben Russell on 3/9/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *catchImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *riverLabel;
@property (weak, nonatomic) IBOutlet UILabel *speciesLabel;



@end
