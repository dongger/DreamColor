//
//  CreatOrderViewController.m
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "CreatOrderViewController.h"
#import "Book_TitleCell.h"
#import "Book_PassengerTitleCell.h"
#import "Book_PassengerCell.h"
#import "Book_PassengerNullCell.h"
#import "Book_AddPassengerCell.h"
#import "Book_LinkManCell.h"
#import "Book_LinkPhoneCell.h"
#import "Book_InsurancesCell.h"
#import "Book_NeedAddressCell.h"
#import "Book_AddressCell.h"
#import "LoginUser.h"
#import "CheckPriceResult.h"
#import "UIColor+Hex.h"
#import "EditPassengerInfoViewController.h"
#import "BookOrderModel.h"
#import "CyAlertView.h"
#import "OrderPayViewController.h"
#import "InsurancesViewController.h"

@interface CreatOrderViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property Cabin *cabin;
@property Flight *flight;
@property CheckPriceResult *checkResult;
@property BOOL needShowTitleDetail;
@property BOOL needAddress;

@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@end

@implementation CreatOrderViewController

+ (CreatOrderViewController *)instanceWithFlight: (Flight *)flight
                                           cabin: (Cabin *)cabin
                                     checkResult: (CheckPriceResult *)result {
    CreatOrderViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CreatOrderViewController"];
    vc.flight = flight;
    vc.cabin = cabin;
    vc.checkResult = result;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)setUpData {
    _bookOrderEntity = [[BookOrderEntity alloc] init];
    _bookOrderEntity.FlightKey = _flight.Key;
    _bookOrderEntity.CabinKey = _cabin.Key;
    _bookOrderEntity.PriceChecked = _checkResult.PriceChecked;
    _bookOrderEntity.LinkName = [[LoginUser share] LinkName];
    _bookOrderEntity.LinkPhone = [[LoginUser share] LinkPhone];
    _bookOrderEntity.ReimAddress = [[LoginUser share] Address];
    _bookOrderEntity.InsKey = 0;
    _bookOrderEntity.Passengers = [[NSMutableArray alloc] init];
    _needShowTitleDetail = NO;
    _needAddress = NO;
    
    if (_checkResult.PriceChecked == 0) {
        _totalPrice.text = [NSString stringWithFormat:@"%0.0f",_checkResult.NewPrice];
    } else {
        _totalPrice.text = [NSString stringWithFormat:@"%0.0f",_cabin.SalePrice];
    }
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView setTableFooterView:footerView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(0, -999, [UIScreen mainScreen].bounds.size.width, 1000)];
    blueView.backgroundColor = [UIColor colorWithHexString:@"2685D7"];
    [headerView addSubview:blueView];
    [_tableView setTableHeaderView:headerView];
}

- (IBAction)commit:(id)sender {
    if (_bookOrderEntity.Passengers.count < 1) {
        [CyAlertView message:@"请填写乘机人"];
        return;
    }
    if (_bookOrderEntity.LinkName.length < 1) {
        [CyAlertView message:@"请填写联系人姓名"];
        return;
    }
    if (_bookOrderEntity.LinkPhone.length < 1) {
        [CyAlertView message:@"请填写联系人手机号"];
        return;
    }
    
    //强制购买保险(1:强制，0: 不强制)，为 1 的情况下，保险 不能选择为不购买
    if (_checkResult.Force == 1) {
        if (_bookOrderEntity.InsKey < 1) {
            [CyAlertView message:@"请购买保险"];
            return;
        }
    }
    
    [BookOrderModel bookWithEntity:_bookOrderEntity success:^(NSString * _Nullable orderId, NSInteger code) {
        NSLog(@"%@", orderId);
         OrderPayViewController *vc = [OrderPayViewController instanceWithOrderId:orderId];
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSString * _Nullable errorMessage, NSInteger code) {
        [CyAlertView message:errorMessage];
    }];
}

- (IBAction)showDetail:(id)sender {
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        if (_bookOrderEntity.Passengers.count == 0) {
            return 2;
        } else if (_bookOrderEntity.Passengers.count == 9) {
            return 10;
        } else {
            return _bookOrderEntity.Passengers.count + 2;
        }
    } else if (section == 2) {
        return 2;
    } else if (section == 3) {
        return 1;
    } else {
        if (_needAddress) {
            return 2;
        } else {
            return 1;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //titleCell
        Book_TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Book_TitleCell" forIndexPath:indexPath];
        [cell loadInfo:_flight cabin:_cabin clickBlock:^{
            _needShowTitleDetail = !_needShowTitleDetail;
            [tableView reloadRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationAutomatic];
        }];
        return cell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //乘机人标题 共X人
            Book_PassengerTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Book_PassengerTitleCell" forIndexPath:indexPath];
            [cell loadCount:_bookOrderEntity.Passengers.count];
            return cell;
        }
        if (_bookOrderEntity.Passengers.count == 9) {
            Book_PassengerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Book_PassengerCell" forIndexPath:indexPath];
            Passenger *passenger = _bookOrderEntity.Passengers[indexPath.row - 1];
            [cell loadInfo:passenger];
            return cell;
        } else if (_bookOrderEntity.Passengers.count == 0) {
            Book_PassengerNullCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Book_PassengerNullCell" forIndexPath:indexPath];
            return cell;
        } else if (_bookOrderEntity.Passengers.count < 9) {
            if (indexPath.row - 1 < _bookOrderEntity.Passengers.count ) {
                Book_PassengerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Book_PassengerCell" forIndexPath:indexPath];
                Passenger *passenger = _bookOrderEntity.Passengers[indexPath.row - 1];
                [cell loadInfo:passenger];
                return cell;
            } else {
                Book_AddPassengerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Book_AddPassengerCell" forIndexPath:indexPath];
                return cell;
            }
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            Book_LinkManCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Book_LinkManCell" forIndexPath:indexPath];
            [cell loadInfo:_bookOrderEntity.LinkName block:^(NSString * _Nullable string) {
                _bookOrderEntity.LinkName = string;
            }];
            return cell;
        } else {
            Book_LinkPhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Book_LinkPhoneCell" forIndexPath:indexPath];
            [cell loadInfo:_bookOrderEntity.LinkPhone block:^(NSString * _Nullable string) {
                _bookOrderEntity.LinkPhone = string;
            }];
            return cell;
        }
    } else if (indexPath.section == 3) {
        Book_InsurancesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Book_InsurancesCell" forIndexPath:indexPath];
        [cell loadInfo:_bookOrderEntity.InsKey Insurances: _checkResult.Insurances];
        return cell;
    } else {
        if (indexPath.row == 0) {
            Book_NeedAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Book_NeedAddressCell" forIndexPath:indexPath];
            if (!_needAddress) {
                cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
            } else {
                cell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
            }
            [cell loadInfo:_needAddress block:^(BOOL need) {
                _needAddress = need;
                [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
            return cell;
        } else {
            Book_AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Book_AddressCell" forIndexPath:indexPath];
            [cell loadInfo:_bookOrderEntity.ReimAddress];
            return cell;
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"wrong" forIndexPath:indexPath];
    cell.textLabel.text = @"数据错误";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [Book_TitleCell height: _needShowTitleDetail];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 44;
        }
        if (_bookOrderEntity.Passengers.count == 9) {
            return 75;
        } else if (_bookOrderEntity.Passengers.count == 0) {
            return 75;
        } else if (_bookOrderEntity.Passengers.count < 9) {
            if (indexPath.row -1 < _bookOrderEntity.Passengers.count ) {
                return 75;
            } else {
                return 40;
            }
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return 50;
        } else {
            return 50;
        }
    } else if (indexPath.section == 3) {
        return 50;
    } else {
        if (indexPath.row == 0) {
            return 50;
        } else {
            return 50;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section < 2) {
        return 0.001;
    }
    return 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[Book_PassengerCell class]]) {
        Passenger *passenger = _bookOrderEntity.Passengers[indexPath.row - 1];
        EditPassengerInfoViewController *vc = [EditPassengerInfoViewController instanceWithPassenger:passenger creatOrderVC:self];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([cell isKindOfClass:[Book_AddPassengerCell class]]) {
        EditPassengerInfoViewController *vc = [EditPassengerInfoViewController instanceWithPassenger:nil creatOrderVC:self];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([cell isKindOfClass:[Book_PassengerNullCell class]]) {
        EditPassengerInfoViewController *vc = [EditPassengerInfoViewController instanceWithPassenger:nil creatOrderVC:self];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([cell isKindOfClass:[Book_InsurancesCell class]]) {
        if (_checkResult.Insurances.count < 1) {
            [CyAlertView message:@"无可购买保险"];
        } else {
            InsurancesViewController *insurancesVC = [InsurancesViewController instanceWithResult:_checkResult selectedID:_bookOrderEntity];
            [self.navigationController pushViewController:insurancesVC animated:YES];
        }
    } else if ([cell isKindOfClass:[Book_AddressCell class]]) {
        
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

@end
