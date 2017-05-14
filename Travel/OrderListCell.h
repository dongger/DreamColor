//
//  OrderListCell.h
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface OrderListCell : UITableViewCell

+ (CGFloat)height: (Order *)order;

- (void)loadInfo: (Order *)order;

@end
