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
@property (weak, nonatomic) NSString *monthString;
@property BOOL riverOn;
@property (weak, nonatomic) NSString *riverString;
@property BOOL speciesOn;
@property (weak, nonatomic) NSString *speciesString;
@property BOOL flyOn;
@property (weak, nonatomic) NSString *flyString;



+ (id)sharedInstance;


@end
