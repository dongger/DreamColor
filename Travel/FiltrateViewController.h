//
//  FiltrateViewController.h
//  Travel
//
//  Created by caiyang on 2017/5/12.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryFlightResult.h"
#import "BaseViewController.h"
#import "SearchResultViewController.h"

@interface FiltrateViewController : BaseViewController
+ (FiltrateViewController *)instanceWithdelegate: (SearchResultViewController *)searchResultVC;
@end
