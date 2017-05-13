//
//  EditPassengerInfoViewController.m
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "EditPassengerInfoViewController.h"
#import "ASBirthSelectSheet.h"

#define SexIndexPath [NSIndexPath indexPathForRow:4 inSection:0]

@interface EditPassengerInfoViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *num;
@property BOOL isHideSex;
@property Passenger *passenger;
@end

@implementation EditPassengerInfoViewController

+ (EditPassengerInfoViewController *)instance {
    EditPassengerInfoViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"EditPassengerInfoViewController"];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_passenger) {
        //默认身份证 隐藏性别
        [self hideSex];
        _passenger = [[Passenger alloc] init];
        _passenger.IdType = 0;
        _passenger.IdTypeName = @"身份证";
    } else {
        switch (_passenger.IdType) {
            case 0:
                [self hideSex];
                break;
            default:
                [self showSex];
                break;
        }
    }
}

- (void)hideSex {
    if (!_isHideSex) {
        _isHideSex = YES;
        [self deleteRowsAtIndexPaths:@[SexIndexPath]];
        [self.tableView reloadData];
    }
}

- (void)showSex {
    if (_isHideSex) {
        _isHideSex = NO;
        [self insertRowsAtIndexPaths:@[SexIndexPath]];
        [self.tableView reloadData];
    }
}

- (IBAction)typeChanged:(UIButton *)sender {
    sender.selected = YES;
    switch (sender.tag) {
        case 1001: {
            //身份证
            _passenger.IdType = 0;
            _passenger.IdTypeName = @"身份证";
            UIButton *button1 = [sender.superview viewWithTag:1002];
            UIButton *button2 = [sender.superview viewWithTag:1003];
            button1.selected = NO;
            button2.selected = NO;
            [self hideSex];
        }
            break;
        case 1002: {
            //护照
            _passenger.IdType = 1;
            _passenger.IdTypeName = @"护照";
            UIButton *button1 = [sender.superview viewWithTag:1001];
            UIButton *button2 = [sender.superview viewWithTag:1003];
            button1.selected = NO;
            button2.selected = NO;
            [self showSex];
        }
            break;
        case 1003: {
            //其他
            _passenger.IdType = 2;
            _passenger.IdTypeName = @"其他";
            UIButton *button1 = [sender.superview viewWithTag:1001];
            UIButton *button2 = [sender.superview viewWithTag:1002];
            button1.selected = NO;
            button2.selected = NO;
            [self showSex];
        }
            break;
        default:
            break;
    }
}

- (IBAction)sexChanged:(UIButton *)sender {
    sender.selected = YES;
    switch (sender.tag) {
        case 1001: {
            //男
            _passenger.Sex = 1;
            UIButton *button = [sender.superview viewWithTag:1002];
            button.selected = NO;
        }
            break;
        case 1002: {
            //女
            _passenger.Sex = 0;
            UIButton *button = [sender.superview viewWithTag:1001];
            button.selected = NO;
        }
            break;
        default:
            break;
    }

}

- (IBAction)pickDate:(UIButton *)sender {
    ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
    datesheet.selectDate = @"2015-12-08";
    datesheet.GetSelectDate = ^(NSString *dateStr) {
        NSLog(@"ok Date:%@", dateStr);
        [sender setTitle:dateStr forState:UIControlStateNormal];
        _passenger.Birthday = dateStr;
    };
    [self.view addSubview:datesheet];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField isEqual:_name]) {
        _passenger.Name = textField.text;
    } else if ([textField isEqual:_num]) {
        _passenger.IdNumber = textField.text;
    }
}
@end
