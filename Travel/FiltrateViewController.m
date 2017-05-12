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
@property SearchResultViewController *delegate;
@property (weak, nonatomic) IBOutlet UITableView *titleTableView;
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;
@property NSArray *titlesArray;

@property NSMutableArray *selectedFiltrateArray;
@property NSArray *allFiltrateArray;

@property NSInteger selectedTitle;

@end

@implementation FiltrateViewController

+ (FiltrateViewController *)instanceWithdelegate: (SearchResultViewController *)searchResultVC {
    FiltrateViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FiltrateViewController"];
    vc.delegate = searchResultVC;
    vc.titlesArray = @[@"起飞时间", @"航空公司", @"舱位"];
    
    vc.allFiltrateArray = [[NSArray alloc] initWithObjects:
                           searchResultVC.result.TimePeriods,
                           searchResultVC.result.Airlines,
                           searchResultVC.result.CabinLevels, nil];
    vc.selectedFiltrateArray = searchResultVC.selectedFiltrateArray;
    return vc;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
}
- (IBAction)reloadFiltrate:(id)sender {
    for (NSMutableArray *array in _selectedFiltrateArray) {
        [array removeAllObjects];
    }
    [_delegate getCache];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)isNOLimit {
    if ([_selectedFiltrateArray[_selectedTitle] count] == 0) {
        return YES;
    } else {
        return NO;
    }
}

- (void)setCell: (UITableViewCell *)cell
       selected: (BOOL) selected {
    UIImageView *imageView = [cell viewWithTag:998];
    if (selected) {
        [imageView setImage:[UIImage imageNamed:@"first"]];
    } else {
        [imageView setImage:nil];
    }
}

- (void)setCell: (UITableViewCell *)cell
      withTitle: (NSString *) title {
    UILabel *label = [cell viewWithTag:999];
    label.text = title;
}

- (void)setCell: (UITableViewCell *)cell
      withTitle: (NSString *) title
          color: (UIColor *) color
backgroundColor: (UIColor *) backgroundColor {
    UILabel *label = [cell viewWithTag:999];
    label.text = title;
    cell.backgroundColor = backgroundColor;
    label.textColor = color;
}

- (void)addFiltrateCondition: (NSString *)condition {
    if (![_selectedFiltrateArray[_selectedTitle] containsObject:condition]) {
        [_selectedFiltrateArray[_selectedTitle] addObject:condition];
    }
}

- (void)removeFiltrateCondition: (NSString *)condition {
    [_selectedFiltrateArray[_selectedTitle] removeObject: condition];
}

- (void)setNolimit {
    [_selectedFiltrateArray[_selectedTitle] removeAllObjects];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_titleTableView]) {
        return _allFiltrateArray.count;
    } else {
        return [_allFiltrateArray[_selectedTitle] count] + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_titleTableView]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath:indexPath];
        if (indexPath.row != _selectedTitle) {
            [self setCell:cell withTitle:_titlesArray[indexPath.row]
                    color:[UIColor lightGrayColor]
          backgroundColor:[UIColor colorWithHexString:@"#EFEFEF"]];
        } else {
            [self setCell:cell withTitle:_titlesArray[indexPath.row]
                    color:[UIColor blackColor]
          backgroundColor:[UIColor whiteColor]];
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [self setCell:cell withTitle:@"不限"];
            [self setCell:cell selected:[self isNOLimit]];
        } else {
            NSString *item = _allFiltrateArray[_selectedTitle][indexPath.row - 1];
            [self setCell:cell withTitle: item];
            if ([_selectedFiltrateArray[_selectedTitle] containsObject:item]) {
                [self setCell:cell selected:YES];
            } else {
                [self setCell:cell selected:NO];
            }
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_titleTableView]) {
        _selectedTitle = indexPath.row;
        [_titleTableView reloadData];
        [_infoTableView reloadData];
    } else {
        if (indexPath.row == 0) {
            [self setNolimit];
        } else {
            NSString *item = _allFiltrateArray[_selectedTitle][indexPath.row - 1];
            if ([_selectedFiltrateArray[_selectedTitle] containsObject:item]) {
                [self removeFiltrateCondition:item];
            } else {
                [self addFiltrateCondition:item];
            }
        }
        [_infoTableView reloadData];
    }
}

@end
