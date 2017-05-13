//
//  CheckPriceResult.h
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Insurances.h"
#import <UIKit/UIKit.h>

@interface CheckPriceResult : NSObject

@property NSArray *Insurances;
@property NSInteger Force; //强制购买保险(1:强制，0: 不强制)，为 1 的情况下，保险 不能选择为不购买
@property CGFloat NewPrice;

@end
