//
//  DatailViewController.m
//  CoffeeFinder
//
//  Created by Andrew Palka on 3/7/16.
//  Copyright © 2016 Andrew Palka. All rights reserved.
//

#import "DatailViewController.h"
#import "MyManager.h"

@interface DatailViewController ()
@end

@implementation DatailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _manager.someProperty;

    // Do any additional setup after loading the view.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
