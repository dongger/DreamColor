//
//  Book_LinkPhoneCell.m
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "Book_LinkPhoneCell.h"
#import "NSString+Check.h"
#import "CyAlertView.h"

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

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_block != nil) {
        if ([textField.text valiMobile]) {
            _block(textField.text);
        } else {
            [CyAlertView message:@"请输入正确格式的手机号码"];
            textField.text = @"";
        }
    }
}

@end
