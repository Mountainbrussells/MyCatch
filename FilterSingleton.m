//
//  FilterSingleton.m
//  MyCatch
//
//  Created by Ben Russell on 3/12/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import "FilterSingleton.h"

@implementation FilterSingleton

@synthesize filterOn;
@synthesize monthOn;
@synthesize monthString;
@synthesize riverOn;
@synthesize riverString;


static FilterSingleton *sharedInstance = nil;

// Get the shared instance and create it if necessary.
+ (FilterSingleton *)sharedInstance {
    if (nil != sharedInstance) {
        return sharedInstance;
    }
    
    static dispatch_once_t pred;        // Lock
    dispatch_once(&pred, ^{             // This code is called at most once per app
        sharedInstance = [[FilterSingleton alloc] init];
    });
    
    return sharedInstance;
}

// Below is init method.  It is possible to screw up init of a singleton by calling [[FilterSingleton alloc]init], and it is not bulletproof to not address this.  But, I'm the only one working on this project...

//// We can still have a regular init method, that will get called the first time the Singleton is used.
//- (id)init
//{
//    self = [super init];
//    
//    if (self) {
//        // Work your initialising magic here as you normally would
//    }
//    
//    return self;
//}







@end
