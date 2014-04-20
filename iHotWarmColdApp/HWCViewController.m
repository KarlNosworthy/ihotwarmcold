//
//  HWCViewController.m
//  iHotWarmCold
//
//  Created by Karl Nosworthy on 18/04/2014.
//  Copyright (c) 2014 Karl Nosworthy. All rights reserved.
//

#import "ESTBeacon.h"
#import "ESTBeaconManager.h"
#import "ESTBeaconRegion.h"
#import "HWCViewController.h"

// Update these to match your required settings
//
NSString * const REGION_IDENTIFER           = @"regionid";
CLBeaconMajorValue BEACON_MAJOR_VERSION     = 8727;
CLBeaconMajorValue BEACON_MINOR_VERSION     = 42728;

@interface HWCViewController () <ESTBeaconManagerDelegate>
@property (nonatomic, strong) ESTBeaconManager* beaconManager;
@property (nonatomic) CAShapeLayer *indicatorBackgroundLayer;
@end


@implementation HWCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    ESTBeaconRegion* region = [[ESTBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID
                                                                       major:BEACON_MAJOR_VERSION
                                                                       minor:BEACON_MINOR_VERSION
                                                                  identifier:REGION_IDENTIFER];
    
    [self.beaconManager startRangingBeaconsInRegion:region];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.indicatorView.clipsToBounds = YES;

    self.indicatorBackgroundLayer = [CAShapeLayer layer];
    self.indicatorBackgroundLayer.bounds = CGRectMake(self.indicatorView.bounds.origin.x,
                             self.indicatorView.bounds.origin.y,
                             self.indicatorView.bounds.size.width - 10,
                             self.indicatorView.bounds.size.height - 10);
    
    self.indicatorBackgroundLayer.position = CGPointMake(CGRectGetMidX(self.indicatorView.bounds), CGRectGetMidY(self.indicatorView.bounds));
    self.indicatorBackgroundLayer.fillColor = [[UIColor whiteColor] CGColor];
    self.indicatorBackgroundLayer.strokeColor = [[UIColor blackColor] CGColor];
    self.indicatorBackgroundLayer.lineWidth = 8.0;

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, nil, self.indicatorBackgroundLayer.bounds);
    self.indicatorBackgroundLayer.path = path;
    
    [self.indicatorView.layer insertSublayer:self.indicatorBackgroundLayer atIndex:0];
}

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    if ([beacons count] > 0) {
        ESTBeacon *closestBeacon = [beacons firstObject];
        
        [self performSelectorOnMainThread:@selector(updateUI:) withObject:closestBeacon waitUntilDone:YES];
    }
}

- (void)updateUI:(ESTBeacon *)beacon
{
    self.beaconUuidLabel.text = [beacon.proximityUUID UUIDString];
    self.beaconVersionLabel.text = [NSString stringWithFormat:@"%@: %d  %@: %d",
                                               @"Major",
                                               BEACON_MAJOR_VERSION,
                                               @"Minor",
                                               BEACON_MINOR_VERSION];
    
    switch (beacon.proximity) {
        case CLProximityImmediate:
        {
            self.indicatorLabel.text = @"HOT";
            self.indicatorLabel.textColor = [UIColor redColor];
            self.indicatorBackgroundLayer.strokeColor = [[UIColor redColor] CGColor];
        }
            break;
        case CLProximityNear:
        {
            self.indicatorLabel.text = @"WARM";
            self.indicatorLabel.textColor = [UIColor yellowColor];
            self.indicatorBackgroundLayer.strokeColor = [[UIColor yellowColor] CGColor];
        }
            break;
        case CLProximityFar:
        {
            self.indicatorLabel.text = @"COLD";
            self.indicatorLabel.textColor = [UIColor blueColor];
            self.indicatorBackgroundLayer.strokeColor = [[UIColor blueColor] CGColor];
        }
            break;
        case CLProximityUnknown:
        {
            self.indicatorLabel.text = @"?";
            self.indicatorLabel.textColor = [UIColor blackColor];
            self.indicatorBackgroundLayer.strokeColor = [[UIColor blackColor] CGColor];
        }
        break;
    }
    
    NSString *stats = [NSString stringWithFormat:@"%@: %.02f |   %@: %ld",
                       @"Distance",
                       [beacon.distance floatValue],
                       @"Rssi",
                       (long)beacon.rssi];
    
    self.beaconStatsLabel.text = stats;
}

@end
