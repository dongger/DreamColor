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
#import "CheckPriceResult.h"
#import "BookOrderEntity.h"

@interface CreatOrderViewController : BaseViewController
@property BookOrderEntity *bookOrderEntity;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

+ (CreatOrderViewController *)instanceWithFlight: (Flight *)flight
                                           cabin: (Cabin *)cabin
                                     checkResult: (CheckPriceResult *)result;

@end
