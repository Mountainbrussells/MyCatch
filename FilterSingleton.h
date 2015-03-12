//
//  FilterSingleton.h
//  MyCatch
//
//  Created by Ben Russell on 3/12/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterSingleton : NSObject

@property BOOL *filterOn;
@property BOOL *monthOn;


+ (id)sharedInstance;


@end
