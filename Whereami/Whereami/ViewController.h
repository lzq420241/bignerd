//
//  ViewController.h
//  Whereami
//
//  Created by LiZiqiang on 7/12/15.
//  Copyright (c) 2015 LiZiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

@end

