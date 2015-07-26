//
//  ViewController.h
//  Whereami
//
//  Created by LiZiqiang on 7/12/15.
//  Copyright (c) 2015 LiZiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>
{
    CLLocationManager *locationManager;
    
    IBOutlet MKMapView *worldView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextField *locationTitleField;
    __weak IBOutlet UISegmentedControl *mapTypeSelector;
}

- (void)findLocation;
- (void)foundLocation: (CLLocation *)loc;

@end

