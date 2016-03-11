//
//  RootTableViewController.m
//  CoffeeFinder
//
//  Created by Andrew Palka on 3/7/16.
//  Copyright © 2016 Andrew Palka. All rights reserved.
//

#import "RootTableViewController.h"

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "Place.h"
#import "MyManager.h"
#import "WarningView.h"
#import "DatailViewController.h"
@interface RootTableViewController () <CLLocationManagerDelegate, WarningViewDelegate>

@property CLLocationManager *locationManager;
@property CLLocation *currentLocation;
@property int k;
@property NSMutableArray *itemsOnMap;
@property NSMutableArray *placesOnMap;

@property NSIndexPath *indexPath;
@property WarningView *xib;

@property BOOL done;

@property NSArray *coffeeArray;
@property NSArray *zooArray;
@property NSArray *froyoArray;
@property NSArray *bowlingArray;
@property NSArray *barArray;
@property NSArray *swingDancingArray;

@property (strong, nonatomic) IBOutlet UITableView *rootTV;

@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.itemsOnMap = [NSMutableArray new];
    self. placesOnMap = [NSMutableArray new];
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    
    NSLog(@"%d",self.k);
    
    if (self.k == 0) {
        [self updateLocation];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void) loadView {
    [super loadView];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    [self.tableView reloadData];
}
#pragma mark CoreLocation and MapKit functionality
-(void)updateLocation {
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    self.k++;
}
-(void)findLocalBar: (CLLocation *)location {
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    
    request.naturalLanguageQuery = @"Bar";
    request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(.5, .5));
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *mapItems = response.mapItems;
        NSMutableArray *filteredArray = [NSMutableArray new];
        NSMutableArray *temp = [NSMutableArray new];
        
        for (int i = 0; i < mapItems.count; i++) {
            MKMapItem *item = mapItems[i];
            //            if ([item.name containsString:@"Starbuck"] || [item.name containsString:@"Dunkin'"] || [item.name containsString:@"7-Eleven"])
            
            if ([self checkForBadLocation:item.name]) {
                NSLog(@"Oh hell no");
                NSLog(@"%@", item.name);
            } else {
                [filteredArray addObject:item];
            }
        }
        BOOL doBreak = false;
        for (int i = 0; (i < 10 || i < filteredArray.count) && !doBreak; i++) {
            
            //            MKMapItem *item = filteredArray[i];
            if (filteredArray.count == i) {
                NSLog(@"BREAKING on %d", i);
                doBreak = true;
                break;
            } else {
                MKMapItem *item = filteredArray[i];
                CLLocationDistance metersAway = [item.placemark.location distanceFromLocation:location];
                float miles = metersAway / 1609.34;
                Place *place = [Place new];
                place.mapItem = item;
                place.milesDifference = miles;
                
                //                    [self.itemsOnMap insertObject:item atIndex:i];
                //                    [self.placesOnMap insertObject:place atIndex:i];
                [temp addObject:place];
                NSLog(@"temp Desc");
                NSLog(@"%lu", (unsigned long)temp.count);
                
                NSLog(@"PRINTING ONCE HITTING ELSE");
                NSLog(@"%d", i);
                NSLog(@"%@", item.name);
            }
        }
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"milesDifference" ascending:true];
        
        self.barArray = [temp sortedArrayUsingDescriptors:@[descriptor]];
        NSLog(@"%@", self.barArray.description);
        NSLog(@"DESCRIPTION INSIDE ^^^");
        [self.tableView reloadData];
    }];
}

-(void)findLocalSwingDancing: (CLLocation *)location {
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    
    request.naturalLanguageQuery = @"Swing Dancing";
    request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(.5, .5));
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *mapItems = response.mapItems;
        NSMutableArray *filteredArray = [NSMutableArray new];
        NSMutableArray *temp = [NSMutableArray new];
        
        for (int i = 0; i < mapItems.count; i++) {
            MKMapItem *item = mapItems[i];
            //            if ([item.name containsString:@"Starbuck"] || [item.name containsString:@"Dunkin'"] || [item.name containsString:@"7-Eleven"])
            
            if ([self checkForBadLocation:item.name]) {
                NSLog(@"Oh hell no");
                NSLog(@"%@", item.name);
            } else {
                [filteredArray addObject:item];
            }
        }
        BOOL doBreak = false;
        for (int i = 0; (i < 10 || i < filteredArray.count) && !doBreak; i++) {
            
            //            MKMapItem *item = filteredArray[i];
            if (filteredArray.count == i) {
                NSLog(@"BREAKING on %d", i);
                doBreak = true;
                break;
            } else {
                MKMapItem *item = filteredArray[i];
                CLLocationDistance metersAway = [item.placemark.location distanceFromLocation:location];
                float miles = metersAway / 1609.34;
                Place *place = [Place new];
                place.mapItem = item;
                place.milesDifference = miles;
                
                //                    [self.itemsOnMap insertObject:item atIndex:i];
                //                    [self.placesOnMap insertObject:place atIndex:i];
                [temp addObject:place];
                NSLog(@"temp Desc");
                NSLog(@"%lu", (unsigned long)temp.count);
                
                NSLog(@"PRINTING ONCE HITTING ELSE");
                NSLog(@"%d", i);
                NSLog(@"%@", item.name);
            }
        }
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"milesDifference" ascending:true];
        
        self.swingDancingArray = [temp sortedArrayUsingDescriptors:@[descriptor]];
        NSLog(@"%@", self.swingDancingArray.description);
        NSLog(@"DESCRIPTION INSIDE ^^^");
        [self.tableView reloadData];
    }];
}

-(void)findLocalBowling: (CLLocation *)location {
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    
    request.naturalLanguageQuery = @"Bowling";
    request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(.5, .5));
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *mapItems = response.mapItems;
        NSMutableArray *filteredArray = [NSMutableArray new];
        NSMutableArray *temp = [NSMutableArray new];
        
        for (int i = 0; i < mapItems.count; i++) {
            MKMapItem *item = mapItems[i];
            //            if ([item.name containsString:@"Starbuck"] || [item.name containsString:@"Dunkin'"] || [item.name containsString:@"7-Eleven"])
            
            if ([self checkForBadLocation:item.name]) {
                NSLog(@"Oh hell no");
                NSLog(@"%@", item.name);
            } else {
                [filteredArray addObject:item];
            }
        }
        BOOL doBreak = false;
        for (int i = 0; (i < 10 || i < filteredArray.count) && !doBreak; i++) {
            
            //            MKMapItem *item = filteredArray[i];
            if (filteredArray.count == i) {
                NSLog(@"BREAKING on %d", i);
                doBreak = true;
                break;
            } else {
                MKMapItem *item = filteredArray[i];
                CLLocationDistance metersAway = [item.placemark.location distanceFromLocation:location];
                float miles = metersAway / 1609.34;
                Place *place = [Place new];
                place.mapItem = item;
                place.milesDifference = miles;
                
                //                    [self.itemsOnMap insertObject:item atIndex:i];
                //                    [self.placesOnMap insertObject:place atIndex:i];
                [temp addObject:place];
                NSLog(@"temp Desc");
                NSLog(@"%lu", (unsigned long)temp.count);
                
                NSLog(@"PRINTING ONCE HITTING ELSE");
                NSLog(@"%d", i);
                NSLog(@"%@", item.name);
            }
        }
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"milesDifference" ascending:true];
        
        self.bowlingArray = [temp sortedArrayUsingDescriptors:@[descriptor]];
        NSLog(@"%@", self.bowlingArray.description);
        NSLog(@"DESCRIPTION INSIDE ^^^");
        [self.tableView reloadData];
    }];
}
-(void)findLocalFroyo: (CLLocation *)location {
        MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    
        request.naturalLanguageQuery = @"Frozen Yogurt";
        request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(.5, .5));
        
        MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
        
        [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
            NSArray *mapItems = response.mapItems;
            NSMutableArray *filteredArray = [NSMutableArray new];
            NSMutableArray *temp = [NSMutableArray new];
            
            for (int i = 0; i < mapItems.count; i++) {
                MKMapItem *item = mapItems[i];
                //            if ([item.name containsString:@"Starbuck"] || [item.name containsString:@"Dunkin'"] || [item.name containsString:@"7-Eleven"])
                
                if ([self checkForBadLocation:item.name]) {
                    NSLog(@"Oh hell no");
                    NSLog(@"%@", item.name);
                } else {
                    [filteredArray addObject:item];
                }
            }
            BOOL doBreak = false;
            for (int i = 0; (i < 10 || i < filteredArray.count) && !doBreak; i++) {
                
                //            MKMapItem *item = filteredArray[i];
                if (filteredArray.count == i) {
                    NSLog(@"BREAKING on %d", i);
                    doBreak = true;
                    break;
                } else {
                    MKMapItem *item = filteredArray[i];
                    CLLocationDistance metersAway = [item.placemark.location distanceFromLocation:location];
                    float miles = metersAway / 1609.34;
                    Place *place = [Place new];
                    place.mapItem = item;
                    place.milesDifference = miles;
                    
                    //                    [self.itemsOnMap insertObject:item atIndex:i];
                    //                    [self.placesOnMap insertObject:place atIndex:i];
                    [temp addObject:place];
                    NSLog(@"temp Desc");
                    NSLog(@"%lu", (unsigned long)temp.count);
                    
                    NSLog(@"PRINTING ONCE HITTING ELSE");
                    NSLog(@"%d", i);
                    NSLog(@"%@", item.name);
                }
            }
            NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"milesDifference" ascending:true];
            
            self.froyoArray = [temp sortedArrayUsingDescriptors:@[descriptor]];
            NSLog(@"%@", self.froyoArray.description);
            NSLog(@"DESCRIPTION INSIDE ^^^");
            [self.tableView reloadData];
        }];
}
-(void)findLocalZoo: (CLLocation *)location {
        MKLocalSearchRequest *request = [MKLocalSearchRequest new];
        
        request.naturalLanguageQuery = @"Zoo";
        request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(.5, .5));
        
        MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
        
        [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
            NSArray *mapItems = response.mapItems;
            NSMutableArray *filteredArray = [NSMutableArray new];
            NSMutableArray *temp = [NSMutableArray new];
            
            for (int i = 0; i < mapItems.count; i++) {
                MKMapItem *item = mapItems[i];
                //            if ([item.name containsString:@"Starbuck"] || [item.name containsString:@"Dunkin'"] || [item.name containsString:@"7-Eleven"])
                
                if ([self checkForBadLocation:item.name]) {
                    NSLog(@"Oh hell no");
                    NSLog(@"%@", item.name);
                } else {
                    [filteredArray addObject:item];
                }
            }
            BOOL doBreak = false;
            for (int i = 0; (i < 10 || i < filteredArray.count) && !doBreak; i++) {
                
                //            MKMapItem *item = filteredArray[i];
                if (filteredArray.count == i) {
                    NSLog(@"BREAKING on %d", i);
                    doBreak = true;
                    break;
                } else {
                    MKMapItem *item = filteredArray[i];
                    CLLocationDistance metersAway = [item.placemark.location distanceFromLocation:location];
                    float miles = metersAway / 1609.34;
                    Place *place = [Place new];
                    place.mapItem = item;
                    place.milesDifference = miles;
                    
                    //                    [self.itemsOnMap insertObject:item atIndex:i];
                    //                    [self.placesOnMap insertObject:place atIndex:i];
                    [temp addObject:place];
                    NSLog(@"temp Desc");
                    NSLog(@"%lu", (unsigned long)temp.count);
                    
                    NSLog(@"PRINTING ONCE HITTING ELSE");
                    NSLog(@"%d", i);
                    NSLog(@"%@", item.name);
                }
            }
            NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"milesDifference" ascending:true];
            
            self.zooArray = [temp sortedArrayUsingDescriptors:@[descriptor]];
            NSLog(@"%@", self.zooArray.description);
            NSLog(@"DESCRIPTION INSIDE ^^^");
            [self.tableView reloadData];
        }];
}
-(void)findLocalCoffee: (CLLocation *)location {
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    
    request.naturalLanguageQuery = @"Coffee";
    request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(.4, .4));
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *mapItems = response.mapItems;
        NSMutableArray *filteredArray = [NSMutableArray new];
        NSMutableArray *temp = [NSMutableArray new];
        
        for (int i = 0; i < mapItems.count; i++) {
            MKMapItem *item = mapItems[i];
            //            if ([item.name containsString:@"Starbuck"] || [item.name containsString:@"Dunkin'"] || [item.name containsString:@"7-Eleven"])
            
            if ([self checkForBadLocation:item.name]) {
                NSLog(@"Oh hell no");
                NSLog(@"%@", item.name);
            } else {
                [filteredArray addObject:item];
            }
        }
        BOOL doBreak = false;
        for (int i = 0; (i < 10 || i < filteredArray.count) && !doBreak; i++) {
            
            //            MKMapItem *item = filteredArray[i];
            if (filteredArray.count == i) {
                NSLog(@"BREAKING on %d", i);
                doBreak = true;
                break;
            } else {
                MKMapItem *item = filteredArray[i];
                CLLocationDistance metersAway = [item.placemark.location distanceFromLocation:location];
                float miles = metersAway / 1609.34;
                Place *place = [Place new];
                place.mapItem = item;
                place.milesDifference = miles;
                
                //                    [self.itemsOnMap insertObject:item atIndex:i];
                //                    [self.placesOnMap insertObject:place atIndex:i];
                [temp addObject:place];
                NSLog(@"temp Desc");
                NSLog(@"%lu", (unsigned long)temp.count);
                
                NSLog(@"PRINTING ONCE HITTING ELSE");
                NSLog(@"%d", i);
                NSLog(@"%@", item.name);
            }
        }
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"milesDifference" ascending:true];
        
        self.coffeeArray = [temp sortedArrayUsingDescriptors:@[descriptor]];
        NSLog(@"%@", self.coffeeArray.description);
        NSLog(@"DESCRIPTION INSIDE ^^^");
        [self.tableView reloadData];
    }];
    
    
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    self.currentLocation = locations.firstObject;
    NSLog(@"%@", self.currentLocation);
    [self.locationManager stopUpdatingLocation];
    [self findLocalCoffee:self.currentLocation];
    [self findLocalZoo:self.currentLocation];
    [self findLocalFroyo:self.currentLocation];
}

#pragma mark - Error Handling and Warnings
-(BOOL)checkForBadLocation: (NSString *)itemName {
    NSArray *array = @[@"Starbuck", @"Dunkin'", @"7-Eleven", @"Vending"];
    
    for (NSString *word in array) {
        if ([itemName containsString:word]) {
            return true;
        }
    }
    return false;
}

-(void)warningView:(id)view clickedButton:(UIButton *)button {
    self.done = false;
    [self updateLocation];
    NSLog(@"DONE");
        NSLog(@"DEPRECATED");
    [self.xib removeFromSuperview];
}
//-(void)warningView:(id)view {
//    [self.xib removeFromSuperview];
//}
//-(void)warningView:(id)view {
//    [self.xib setHidden:YES];
//    [self.tableView reloadData];
//}

#pragma mark - Table view data source
/*
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 #warning Incomplete implementation, return the number of sections
 return self.placesOnMap.count;
 }
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.coffeeArray.count > 0) {
        if ([[self.view subviews] containsObject:self.xib]) {
            self.done = true;
//            [self.view.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
            NSLog(@"cA count:");
//            [self.xib setHidden:YES];
            
            NSLog(@"%lu", self.coffeeArray.count);
            return self.coffeeArray.count;
        }
        return  self.coffeeArray.count;
    } else if (self.coffeeArray.count == 0 || self.coffeeArray == nil){
        
//        self.xib = [[[NSBundle mainBundle] loadNibNamed:@"WarningView" owner:self.xib  options:nil] objectAtIndex:0];
//        self.xib.delegate = self;
//                [self.xib setFrame:CGRectMake(0, 0, 320, 480)];
//        [self.view addSubview:self.xib];

        return 0;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    Place *selected = self.coffeeArray[indexPath.row];
    // Configure the cell...
    cell.textLabel.text = selected.mapItem.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f miles", selected.milesDifference];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    
    MyManager *manager = [MyManager new];
    manager.someProperty = cell.textLabel.text;
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DatailViewController *dvc = segue.destinationViewController;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:selectedIndexPath];
    MyManager *manager = [MyManager new];
    manager.someProperty = cell.textLabel.text;
    dvc.manager = manager;

}


@end
