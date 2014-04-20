//
//  HWCViewController.h
//  iHotWarmCold
//
//  Created by Karl Nosworthy on 18/04/2014.
//  Copyright (c) 2014 Karl Nosworthy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWCViewController : UIViewController

@property (nonatomic) IBOutlet UILabel *beaconUuidLabel;
@property (nonatomic) IBOutlet UILabel *beaconVersionLabel;
@property (nonatomic) IBOutlet UILabel *beaconStatsLabel;
@property (nonatomic) IBOutlet UIView *indicatorView;
@property (nonatomic) IBOutlet UILabel *indicatorLabel;

@end
