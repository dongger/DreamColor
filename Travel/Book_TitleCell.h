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

typedef void(^_Nullable ClickBlock)();

@interface Book_TitleCell : UITableViewCell

- (void)loadInfo: (Flight *_Nonnull)flight
           cabin: (Cabin *_Nonnull)cabin
      clickBlock: (void(^_Nullable)())clickBlock;

+ (CGFloat)height: (BOOL)showDetail;

@end
