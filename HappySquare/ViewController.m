//
//  ViewController.m
//  HappySquare
//
//  Created by Alexander Kustov on 28/06/14.
//  Copyright (c) 2014 LisbonHelpaThon. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

CLLocationManager *locationManager;
CLGeocoder *geocoder;
CLPlacemark *placemark;

int *Happycounter = 0;



- (void)viewDidLoad
{
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];

    
}



- (IBAction)HappyButton:(id)sender {
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    Happycounter++;
    
    _LabelHappy.text = [NSString stringWithFormat:@"%i", Happycounter];


    
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error"
                               message:@"Failed to Get Your Location"
                               delegate:nil
                               cancelButtonTitle:@"OK"
                               otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        _Lat.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        _Longi.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
    
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            _morada.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                 placemark.subThoroughfare, placemark.thoroughfare,
                                 placemark.postalCode, placemark.locality,
                                 placemark.administrativeArea,
                                 placemark.country];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
