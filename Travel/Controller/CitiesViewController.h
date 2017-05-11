//
//  CitiesViewController.h
//  Travel
//
//  Created by caiyang on 2017/5/10.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "City.h"

typedef void(^_Nullable CityPickedBlock)(City* _Nullable city);
@interface CitiesViewController : BaseTableViewController
@property CityPickedBlock selectBlock;
+ (CitiesViewController *_Nonnull)instance:(void(^_Nullable)(City* _Nullable city))didSelectBlock;
@end
