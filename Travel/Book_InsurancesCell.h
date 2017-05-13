//
//  Book_InsurancesCell.h
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Insurances.h"

@interface Book_InsurancesCell : UITableViewCell

- (void)loadInfo: (NSInteger )InsKey
      Insurances: (NSArray *)InsurancesArray;

@end
