//
//  CitiesViewController.m
//  Travel
//
//  Created by caiyang on 2017/5/10.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "CitiesViewController.h"
#import "CitiesModel.h"
#import "CyAlertView.h"
#import "NSObject+Cache.h"
#import "CitiesGroup.h"
#import "City.h"
#import <RTRootNavigationController.h>
#import "UIColor+Hex.h"

@interface CitiesViewController ()<UISearchBarDelegate>
@property NSMutableArray *CitiesData;
@property NSMutableArray *titlesArray;

@property UISearchBar *searchBar;
@end

@implementation CitiesViewController

+ (CitiesViewController *)instance {
    CitiesViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CitiesViewController"];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCitiesData];
    [self initUI];
}

- (void)initCitiesData {
    if ([CitiesGroup getArrayFromKey:@"kCitiesData"].count > 0) {
        _CitiesData = [[NSMutableArray alloc] initWithArray:[CitiesGroup getArrayFromKey:@"kCitiesData"]];
        [self initTitles];
        [self.tableView reloadData];
    } else {
        [CitiesModel fetchWithSuccess:^(NSArray *citiesData) {
            [CyAlertView message:[citiesData description]];
            [citiesData saveWithKey:@"kCitiesData"];
            _CitiesData = [[NSMutableArray alloc] initWithArray:citiesData];
            [self initTitles];
            [self.tableView reloadData];
        } failure:^(NSString *errorMessage) {
            [CyAlertView message:errorMessage];
        }];
    }
}

- (void)initTitles {
    _titlesArray = [[NSMutableArray alloc] init];
    for (CitiesGroup *group in _CitiesData) {
        if (group.Cities.count > 0) {
            [_titlesArray addObject:group.FirstLetter];
        }
    }
}

- (NSInteger)indexInTitles: (NSInteger)index {
    NSString *letter = _titlesArray[index];
    for (CitiesGroup *group in _CitiesData) {
        if ([group.FirstLetter isEqualToString:letter]) {
            return [_CitiesData indexOfObject:group];
        }
    }
    return 0;
}

- (void)initUI {
    self.tableView.sectionIndexColor = [UIColor colorWithRed:0/255.0 green:134/255.0 blue:216/255.0 alpha:1];
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(60, 0, [[UIScreen mainScreen] bounds].size.width - 75, 44)];
    _searchBar.placeholder = @"北京/beijing/bj                           ";
    _searchBar.delegate = self;
    _searchBar.returnKeyType = UIReturnKeyDone;
    _searchBar.enablesReturnKeyAutomatically = NO;
    [_searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.navigationController.navigationBar addSubview:_searchBar];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"#2685d7"]];
}

- (void)searchCities {
    [self initCitiesData];
    if (_searchBar.text.length > 0) {
        NSMutableArray *resultArray = [[NSMutableArray alloc] init];
        for (CitiesGroup *group in _CitiesData) {
            CitiesGroup *tempGroup = [[CitiesGroup alloc] init];
            tempGroup.FirstLetter = group.FirstLetter;
            tempGroup.Cities = [[NSMutableArray alloc] init];
            [resultArray addObject:tempGroup];
            for (City *city in group.Cities) {
                NSString *searchString = [_searchBar.text lowercaseString];
                if ([city.CityCode containsString:searchString] ||
                    [city.CityName containsString:searchString] ||
                    [city.Initials containsString:searchString] ||
                    [city.Pinyin containsString:searchString]) {
                    [tempGroup.Cities addObject:city];
                }
            }
        }
        _CitiesData = resultArray;
        [self initTitles];
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titlesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CitiesGroup *group = _CitiesData[[self indexInTitles:section]];
    return group.Cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell" forIndexPath:indexPath];
    CitiesGroup *group = _CitiesData[[self indexInTitles:indexPath.section]];
    City *city = group.Cities[indexPath.row];
    cell.textLabel.text = city.CityName;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CitiesGroup *group = _CitiesData[[self indexInTitles:section]];
    return group.FirstLetter;
}

//添加索引列
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _titlesArray;
}
  
//索引列点击事件
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
     //点击索引，列表跳转到对应索引的行
     [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
     //弹出首字母提示
    [CyAlertView message:title];
    return index;
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"%@", searchText);
    [self searchCities];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

@end
