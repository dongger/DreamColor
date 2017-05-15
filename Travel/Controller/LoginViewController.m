//
//  LoginViewController.m
//  Travel
//
//  Created by yang cai on 2017/5/9.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginUser.h"
#import "CyAlertView.h"
#import "UserModel.h"

@interface LoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property NSString *accountString;
@property NSString *codeString;
@property NSInteger type; //登彔方式(1:普通登彔，2: 短信登彔)
@property BOOL isEnterprise;
@end

@implementation LoginViewController

+ (LoginViewController *)instanceIsEnterprise: (BOOL)isEnterprise {
    LoginViewController *loginView = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    loginView.isEnterprise = isEnterprise;
    
    if (loginView.isEnterprise) {
        loginView.accountString = @"用户名";
        loginView.codeString = @"密码";
    } else {
        loginView.accountString = @"手机号";
        loginView.codeString = @"获取短信密码";
    }
    loginView.type = 1;
    return loginView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}

- (IBAction)login:(id)sender {
    if (_phoneTextField.text.length < 1) {
        [CyAlertView message:[NSString stringWithFormat:@"请输入%@",_accountString]];
        return;
    }
    if (_passwordTextField.text.length < 1) {
        [CyAlertView message:[NSString stringWithFormat:@"请输入%@",_codeString]];

        return;
    }
    
    
    NSDictionary *dic = @{@"Account":_phoneTextField.text,
                          @"Password":_passwordTextField.text,
                          @"Type":@(_type)};

    if (_type == 1) {
        [UserModel login:dic success:^(User *user) {
            [LoginUser loadInfo:user];
            [CyAlertView message:LoginUser.share.Session];
        } failure:^(NSString *errorMessage) {
            [CyAlertView message:errorMessage];
        }];
    } else {
        [UserModel enterpriseLogin:dic success:^(User *user) {
            [LoginUser loadInfo:user];
            [CyAlertView message:LoginUser.share.Session];
        } failure:^(NSString *errorMessage) {
            [CyAlertView message:errorMessage];
        }];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isEqual:_phoneTextField]) {
        NSString *tempString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (tempString.length > 11) {
            return NO;
        }
    }
    return YES;
}
@end
