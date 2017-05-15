//
//  InsurancesViewController.h
//  Travel
//
//  Created by caiyang on 2017/5/15.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "BaseTableViewController.h"
#import "CheckPriceResult.h"
#import "BookOrderEntity.h"

@interface InsurancesViewController : BaseTableViewController

+ (InsurancesViewController *)instanceWithResult: (CheckPriceResult *)result
                                      selectedID: (BookOrderEntity *)bookOrderEntity;

@end
