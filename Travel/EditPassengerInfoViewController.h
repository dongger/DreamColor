//
//  EditPassengerInfoViewController.h
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "ABStaticTableViewController.h"
#import "Passenger.h"
#import "CreatOrderViewController.h"

@interface EditPassengerInfoViewController : ABStaticTableViewController

+ (EditPassengerInfoViewController *)instanceWithPassenger: (Passenger *)passenger
                                              creatOrderVC: (CreatOrderViewController *)creatOrderVC;

@end
