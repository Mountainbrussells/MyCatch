//
//  FilterSingleton.h
//  MyCatch
//
//  Created by Ben Russell on 3/12/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterSingleton : NSObject

@property BOOL filterOn;
@property BOOL monthOn;
@property (strong, retain) NSString *monthString;
@property BOOL riverOn;
@property (strong, retain) NSString *riverString;
@property BOOL speciesOn;
@property (strong, retain) NSString *speciesString;
@property BOOL flyOn;
@property (strong, retain) NSString *flyString;
@property BOOL weatherOn;
@property (strong, retain) NSString *weatherString;




+ (id)sharedInstance;


@end
