//
//  CalendarViewController.h
//  Travel
//
//  Created by yang cai on 2017/5/10.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^_Nullable DatePickedBlock)(NSDate* _Nullable date);

@interface CalendarViewController : UITableViewController
@property (weak) DatePickedBlock selectBlock;

+ (CalendarViewController *_Nullable)instance:(void(^_Nullable)(NSDate* _Nullable date))didSelectBlock;

@end
