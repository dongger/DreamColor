//
//  SearchResultViewController.h
//  Travel
//
//  Created by yang cai on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "QueryFlightResult.h"
#import "City.h"

@interface SearchResultViewController : BaseViewController

@property QueryFlightResult* result;
@property NSArray *filtrateArray;
@property NSMutableArray *selectedFiltrateArray;
@property City *startCity;
@property City *destinationCity;
@property NSDate *searchDate;
@property NSInteger bookType; //1:普通乘客 2:公务员
@property NSInteger travelType; //1:因公 2:因私

+ (SearchResultViewController *)instance;
- (void)getCache;
@end
