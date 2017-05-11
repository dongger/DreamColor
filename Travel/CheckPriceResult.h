//
//  CheckPriceResult.h
//  Travel
//
//  Created by caiyang on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Insurances.h"

@interface CheckPriceResult : NSObject

@property NSArray *Insurances;
@property NSInteger *Force; //强制购买保险(1:强制，0: 丌强制)，为 1 的情况下，保险 丌能选择为丌购买
@property CGFloat *NewPrice;

@end
