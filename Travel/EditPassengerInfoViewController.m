//
//  EditPassengerInfoViewController.m
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "EditPassengerInfoViewController.h"
#import "ASBirthSelectSheet.h"

#define ConstIndexPath1 [NSIndexPath indexPathForRow:1 inSection:2]
#define ConstIndexPath2 [NSIndexPath indexPathForRow:3 inSection:2]
#define ConstSection 1

@interface EditPassengerInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *num;

@end

@implementation EditPassengerInfoViewController

+ (EditPassengerInfoViewController *)instance {
    EditPassengerInfoViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"EditPassengerInfoViewController"];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)typeChanged:(UIButton *)sender {
}

- (IBAction)sexChanged:(UIButton *)sender {
}

- (IBAction)pickDate:(UIButton *)sender {
    ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
    datesheet.selectDate = @"2015-12-08";
    datesheet.GetSelectDate = ^(NSString *dateStr) {
        NSLog(@"ok Date:%@", dateStr);
        [sender setTitle:dateStr forState:UIControlStateNormal];
    };
    [self.view addSubview:datesheet];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

@end
