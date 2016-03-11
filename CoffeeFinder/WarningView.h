//
//  warningView.h
//  CoffeeFinder
//
//  Created by Andrew Palka on 3/7/16.
//  Copyright © 2016 Andrew Palka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootTableViewController.h"

@protocol WarningViewDelegate <NSObject>

-(void)warningView:(id)view clickedButton:(UIButton *)button;

@end


@interface WarningView : UIView
@property (nonatomic, assign) id <WarningViewDelegate> delegate;
@end
