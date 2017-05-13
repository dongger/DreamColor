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



@interface CreatOrderViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property Cabin *cabin;
@property Flight *flight;
@property BOOL needShowTitleDetail;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@end

@implementation CreatOrderViewController

+ (CreatOrderViewController *)instanceWithFlight: (Flight *)flight
                                           cabin: (Cabin *)cabin {
    CreatOrderViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CreatOrderViewController"];
    vc.flight = flight;
    vc.cabin = cabin;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _needShowTitleDetail = NO;

}

- (IBAction)commit:(id)sender {
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
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        Book_TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Book_TitleCell" forIndexPath:indexPath];
        [cell loadInfo:_flight cabin:_cabin clickBlock:^{
            _needShowTitleDetail = !_needShowTitleDetail;
            [tableView reloadRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationAutomatic];
        }];
        return cell;
    }
    Book_TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Book_TitleCell" forIndexPath:indexPath];
    [cell loadInfo:_flight cabin:_cabin clickBlock:^{
        _needShowTitleDetail = !_needShowTitleDetail;
        [tableView reloadRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationAutomatic];
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [Book_TitleCell height: _needShowTitleDetail];
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section < 2) {
        return 0.001;
    }
    return 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

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
