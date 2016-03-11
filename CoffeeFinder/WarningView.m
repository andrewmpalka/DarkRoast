//
//  warningView.m
//  CoffeeFinder
//
//  Created by Andrew Palka on 3/7/16.
//  Copyright © 2016 Andrew Palka. All rights reserved.
//

#import "WarningView.h"

@implementation WarningView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)onColorButtonPress:(UIButton *)sender {
    [self setHidden:true];
    [self removeFromSuperview];
    [self.delegate warningView:self clickedButton:sender];
}

@end
