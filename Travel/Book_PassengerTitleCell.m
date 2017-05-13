//
//  Book_PassengerTitleCell.m
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "Book_PassengerTitleCell.h"
#import "LoginUser.h"

@interface Book_PassengerTitleCell()
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation Book_PassengerTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)add:(id)sender {
}

- (void)loadCount: (NSInteger)count {
    if (count < 10 && count > 0) {
        _count.hidden = NO;
        _count.text = [NSString stringWithFormat:@"共%ld人",(long)count];
    } else {
        _count.hidden = YES;
    }
    //个人用户无此按钮
    [_addButton setHidden:([[LoginUser share] Type] == 4)];
}
@end
