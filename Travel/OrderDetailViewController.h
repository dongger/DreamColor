//
//  OrderDetailViewController.h
//  Travel
//
//  Created by yang cai on 2017/5/15.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "Order.h"

@interface OrderDetailViewController : BaseViewController

+ (OrderDetailViewController *)instance: (Order *)order;

@end
