//
//  Book_LinkPhoneCell.m
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "Book_LinkPhoneCell.h"

@interface Book_LinkPhoneCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property Block block;
@end

@implementation Book_LinkPhoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadInfo:(NSString *)phone
           block: (void(^_Nullable)(NSString * _Nullable string))block {
    _block = block;
    _phone.text = phone;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (_block != nil) {
        _block(textField.text);
    }
    return YES;
}

@end
