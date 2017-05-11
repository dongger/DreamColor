//
//  SearchResultViewController.h
//  Travel
//
//  Created by yang cai on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "QueryFlightResult.h"

@interface SearchResultViewController : BaseTableViewController
+ (SearchResultViewController *)instance: (QueryFlightResult *)result;
@end
