//
//  ViewController.h
//  HappySquare
//
//  Created by Alexander Kustov on 28/06/14.
//  Copyright (c) 2014 LisbonHelpaThon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *LabelHappy;

@property (weak, nonatomic) IBOutlet UILabel *Lat;
@property (weak, nonatomic) IBOutlet UILabel *Longi;
@property (weak, nonatomic) IBOutlet UILabel *morada;


- (IBAction)HappyButton:(id)sender;



@end
