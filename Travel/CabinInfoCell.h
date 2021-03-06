//
//  CabinInfoCell.h
//  Travel
//
//  Created by yang cai on 2017/5/12.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cabin.h"
#import "Flight.h"

@interface CabinInfoCell : UITableViewCell

- (void)loadInfo: (Cabin *)cabin
          flight: (Flight *)flight;

@end
