//
//  Book_NeedAddressCell.h
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^_Nullable SwitchBlock)(BOOL need);

@interface Book_NeedAddressCell : UITableViewCell

- (void)loadInfo: (BOOL)need
           block: (void(^_Nullable)(BOOL need))block;

@end
