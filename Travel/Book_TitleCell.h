//
//  Book_TitleCell.h
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flight.h"
#import "Cabin.h"

@interface Book_TitleCell : UITableViewCell

- (void)loadInfo: (Flight *)flight
           cabin: (Cabin *)cabin;

+ (CGFloat)height: (BOOL)showDetail;

@end
