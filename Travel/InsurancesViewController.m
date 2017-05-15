//
//  InsurancesViewController.m
//  Travel
//
//  Created by caiyang on 2017/5/15.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "InsurancesViewController.h"

@interface InsurancesViewController ()
@property BookOrderEntity *bookOrderEntity;
@property CheckPriceResult *result;
@end

@implementation InsurancesViewController

+ (InsurancesViewController *)instanceWithResult: (CheckPriceResult *)result
                                      selectedID: (BookOrderEntity *)bookOrderEntity {
    InsurancesViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"InsurancesViewController"];
    vc.result = result;
    vc.bookOrderEntity = bookOrderEntity;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _result.Insurances.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
    Insurances *insurance = _result.Insurances[indexPath.row];
    cell.textLabel.text = insurance.Name;
    if (_bookOrderEntity.InsKey == insurance.ID) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Insurances *insurance = _result.Insurances[indexPath.row];
    _bookOrderEntity.InsKey = insurance.ID;
    [self.navigationController popViewControllerAnimated:YES];
}

@end
