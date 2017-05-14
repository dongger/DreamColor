//
//  OrderPayViewController.h
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@interface OrderPayViewController : BaseTableViewController

+ (OrderPayViewController *)instanceWithOrderId: (NSString *)orderId;

@end
