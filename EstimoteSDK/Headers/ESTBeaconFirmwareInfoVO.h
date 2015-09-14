//
//  ESTBeaconFirmwareInfoVO.h
//  EstimoteSDK
//
//  Version: 2.1.5
//  Created by Łukasz Pikor on 01.04.2014.
//  Copyright (c) 2014 Estimote. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESTBeaconFirmwareInfoVO : NSObject

@property (nonatomic, strong) NSString *hardwareVersion;
@property (nonatomic, strong) NSString *firmwareVersion;
@property (nonatomic, strong) NSString *changelog;
@property (nonatomic, assign) BOOL isUpdateAvailable;

@end
