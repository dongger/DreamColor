//
//  OrderPayTitleView.h
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
@interface OrderPayTitleView : UIView

- (void)loadInfo: (Order *)order;
+ (CGFloat)height: (Order *)order;

@end
