//
//  FirstViewController.h
//  MyCatch
//
//  Created by Ben Russell on 3/3/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) PFUser *user;
@property (weak, nonatomic) IBOutlet UITableView *catchTable;



@end

