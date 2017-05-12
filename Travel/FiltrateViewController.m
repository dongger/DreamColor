//
//  FiltrateViewController.m
//  Travel
//
//  Created by caiyang on 2017/5/12.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "FiltrateViewController.h"
#import "UIColor+Hex.h"

@interface FiltrateViewController ()<UITableViewDelegate, UITableViewDataSource>
@property QueryFlightResult* result;
@property (weak, nonatomic) IBOutlet UITableView *titleTableView;
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;
@property NSArray *titlesArray;
@property NSArray *filtrateArray;
@property NSInteger selectedTitle;

@end

@implementation FiltrateViewController

+ (FiltrateViewController *)instance: (QueryFlightResult *)result {
    FiltrateViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FiltrateViewController"];
    vc.result = result;
    vc.titlesArray = @[@"起飞时间", @"航空公司", @"舱位"];
    vc.filtrateArray = [[NSArray alloc] initWithObjects:result.TimePeriods, result.Airlines, result.CabinLevels, nil];

    return vc;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_titleTableView]) {
        return _filtrateArray.count;
    } else {
        return [_filtrateArray[_selectedTitle] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_titleTableView]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath:indexPath];
        UILabel *title = [cell viewWithTag:999];
        title.text = _titlesArray[indexPath.row];
        
        if (indexPath.row != _selectedTitle) {
            cell.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
            title.textColor = [UIColor lightGrayColor];
        } else {
            cell.backgroundColor = [UIColor whiteColor];
            title.textColor = [UIColor blackColor];
        }
        return cell;

    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
        UILabel *title = [cell viewWithTag:998];
        title.text = _filtrateArray[_selectedTitle][indexPath.row];
        
        UIImageView *imageView = [cell viewWithTag:999];
        imageView.backgroundColor = [UIColor blackColor];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_titleTableView]) {
        _selectedTitle = indexPath.row;
        [_titleTableView reloadData];
        [_infoTableView reloadData];
    } else {
        
    }
}

@end
