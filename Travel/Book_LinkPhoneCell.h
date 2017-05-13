//
//  Book_LinkPhoneCell.h
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^_Nullable Block)(NSString * _Nullable string);

@interface Book_LinkPhoneCell : UITableViewCell

- (void)loadInfo:(NSString *_Nonnull)phone
           block: (void(^_Nullable)(NSString * _Nullable string))block;

@end
