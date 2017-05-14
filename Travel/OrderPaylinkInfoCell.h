//
//  OrderPaylinkInfoCell.h
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

@interface OrderPaylinkInfoCell : UITableViewCell

- (void)loadInfo: (NSString *)linkName
           phone: (NSString *)linkPhone;

@end
