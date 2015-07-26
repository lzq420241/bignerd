//
//  ViewController.m
//  Whereami
//
//  Created by LiZiqiang on 7/12/15.
//  Copyright (c) 2015 LiZiqiang. All rights reserved.
//

#import "ViewController.h"
#import "BNRMapPoint.h"

@implementation ViewController

- (IBAction)mapTypeChanged:(UISegmentedControl *)sender {
    NSUInteger idx = [sender selectedSegmentIndex];
    [worldView setMapType:idx];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:(NSCoder *)aDecoder];
    
    if (self) {
        locationManager = [[CLLocationManager alloc] init];
        
        [locationManager setDelegate:self];
        
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //[locationManager setDistanceFilter:50];
        
        // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [locationManager requestWhenInUseAuthorization];
        }
        
        //[locationManager startUpdatingLocation];
        //[locationManager startUpdatingHeading];
    }
    return self;
}

- (void)findLocation
{
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    [locationTitleField setHidden:YES];
}

- (void)foundLocation:(CLLocation *)loc
{
    CLLocationCoordinate2D coord = [loc coordinate];
    BNRMapPoint *mp = [[BNRMapPoint alloc] initWithCoordinate:coord title:[locationTitleField text]];
    
    [worldView addAnnotation:mp];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    [worldView setRegion:region animated:YES];
    
    [locationTitleField setText:@""];
    [activityIndicator stopAnimating];
    [locationTitleField setHidden:NO];
    [worldView setShowsUserLocation:NO];
    [locationManager stopUpdatingLocation];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self findLocation];
    [textField resignFirstResponder];
    return YES;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MKAnnotationView *view = [views lastObject];
    //[view setCanShowCallout:YES];
    [mapView selectAnnotation:[view annotation] animated:YES];
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    //[view setCanShowCallout:YES];
    [mapView selectAnnotation:[view annotation] animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateLocations:(NSArray *)locations
{
    CLLocation *newloc = [locations lastObject];
    NSLog(@"%@", newloc);
    
    NSTimeInterval t = [[newloc timestamp] timeIntervalSinceNow];
    if (t < -180) {
        return ;
    }
    
    [self foundLocation:newloc];
}

- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading
{
    NSLog(@"%@", newHeading);
}

- (void)locationManager: (CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
}


- (void)viewDidLoad
{
    // As log as this property is YES, the map view continues to track the user's location
    // and update it periodically
    [worldView setShowsUserLocation:YES];
    [mapTypeSelector setSelectedSegmentIndex:0];
}


- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [worldView setRegion:region animated:YES];
}
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//}

- (void)dealloc
{
    // Tell the location manager to stop sending us messages
    [locationManager setDelegate:nil];
}

@end
