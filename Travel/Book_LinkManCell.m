//
//  Book_LinkManCell.m
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "Book_LinkManCell.h"

@interface Book_LinkManCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property Block block;

@end

@implementation Book_LinkManCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadInfo:(NSString *)name
           block: (void(^_Nullable)(NSString * _Nullable string))block {
    _block = block;
    _name.text = name;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_block != nil) {
        _block(textField.text);
    }
}

@end
