//
//  CreatOrderViewController.h
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Cabin.h"
#import "Flight.h"

@interface CreatOrderViewController : BaseViewController

+ (CreatOrderViewController *)instanceWithFlight: (Flight *)flight
                                           cabin: (Cabin *)cabin;

@end
