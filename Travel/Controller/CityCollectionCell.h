//
//  CityCollectionCell.h
//  Travel
//
//  Created by caiyang on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CitiesViewController.h"

@interface CityCollectionCell : UITableViewCell
@property (weak) CitiesViewController *citiesVC;
- (void)loadCities: (NSArray *)cities;
+ (CGFloat)heightOfCitiesCount: (NSInteger)count;
@end
