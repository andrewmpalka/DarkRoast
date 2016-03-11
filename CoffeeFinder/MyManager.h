//
//  MyManager.h
//  CoffeeFinder
//
//  Created by Andrew Palka on 3/7/16.
//  Copyright © 2016 Andrew Palka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MyManager : NSObject {
    NSString *someProperty;
}

@property NSString *someProperty;

+ (id)sharedManager;

@end
