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
#import <RTRootNavigationController.h>
#import "UIColor+Hex.h"
#import "CityCollectionCell.h"


@interface CitiesViewController ()<UISearchBarDelegate>
@property NSMutableArray *CitiesData;
@property NSMutableArray *titlesArray;

@property UISearchBar *searchBar;
@end

@implementation CitiesViewController

+ (CitiesViewController *)instance:(void(^_Nullable)(City* _Nullable city))didSelectBlock {
    CitiesViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CitiesViewController"];
    vc.selectBlock = didSelectBlock;
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
        [self prepareCitiesData];
        [self.tableView reloadData];
    } else {
        [CitiesModel fetchWithSuccess:^(NSArray *citiesData) {
            [CyAlertView message:[citiesData description]];
            [citiesData saveWithKey:@"kCitiesData"];
            _CitiesData = [[NSMutableArray alloc] initWithArray:citiesData];
            [self prepareCitiesData];
            [self.tableView reloadData];
        } failure:^(NSString *errorMessage) {
            [CyAlertView message:errorMessage];
        }];
    }
}

- (void)prepareCitiesData {
    [self HistoryCitiesGroup];
    _titlesArray = [[NSMutableArray alloc] init];
    for (CitiesGroup *group in _CitiesData) {
        if (group.Cities.count > 0) {
            [_titlesArray addObject:group.FirstLetter];
        }
    }
    if ([self hasHistory]) {
        ((CitiesGroup *)(_CitiesData[1])).FirstLetter = @"热门城市";
        _titlesArray[0] = @"历史";
        _titlesArray[1] = @"热门";
    } else {
        ((CitiesGroup *)(_CitiesData.firstObject)).FirstLetter = @"热门城市";
        _titlesArray[0] = @"热门";
    }
}

- (NSInteger)indexInTitles: (NSInteger)index {
    NSString *letter = _titlesArray[index];
    NSMutableArray *groupFirstLetterArray = [[NSMutableArray alloc] init];
    for (CitiesGroup *group in _CitiesData) {
        if (group.Cities.count > 0) {
            [groupFirstLetterArray addObject:group.FirstLetter];
        }
    }
    if ([self hasHistory]) {
        groupFirstLetterArray[0] = @"历史";
        groupFirstLetterArray[1] = @"热门";
    } else {
        groupFirstLetterArray[0] = @"热门";
    }
    for (NSString *groupletter in groupFirstLetterArray) {
        if ([groupletter isEqualToString:letter]) {
            return [groupFirstLetterArray indexOfObject:groupletter];
        }
    }
    return 0;
}

- (void)initUI {
    self.tableView.sectionIndexColor = [UIColor colorWithRed:0/255.0 green:134/255.0 blue:216/255.0 alpha:1];
    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(60, 0, [[UIScreen mainScreen] bounds].size.width - 75, 44)];
    _searchBar.placeholder = @"北京/beijing/bj                           ";
    _searchBar.delegate = self;
    _searchBar.returnKeyType = UIReturnKeyDone;
    _searchBar.enablesReturnKeyAutomatically = NO;
    [_searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.navigationController.navigationBar addSubview:_searchBar];
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
                if ([city.Code containsString:searchString] ||
                    [city.Name containsString:searchString] ||
                    [city.Initials containsString:searchString] ||
                    [city.Pinyin containsString:searchString]) {
                    [tempGroup.Cities addObject:city];
                }
            }
        }
        _CitiesData = resultArray;
        [self prepareCitiesData];
    }
    [self.tableView reloadData];
}

- (void)HistoryCitiesGroup {
    if ([self hasHistory]) {
        NSMutableArray *history = [[NSMutableArray alloc] initWithArray:[City getArrayFromKey:@"kCitiesHistory"]];
        CitiesGroup *group = [[CitiesGroup alloc] init];
        group.FirstLetter = @"历史选择";
        group.Cities = history;
        [_CitiesData insertObject:group atIndex:0];
    }
}

- (BOOL)hasHistory {
    NSMutableArray *history = [[NSMutableArray alloc] initWithArray:[City getArrayFromKey:@"kCitiesHistory"]];
    if (history.count > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isCollectionCell: (NSInteger)index {
    NSMutableArray *history = [[NSMutableArray alloc] initWithArray:[City getArrayFromKey:@"kCitiesHistory"]];
    if (history.count > 0) {
        if (index < 2) {
            return YES;
        }
    } else if (index < 1) {
        return YES;
    }
    return NO;
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isCollectionCell:indexPath.section]) {
    
    } else {
        CitiesGroup *group = _CitiesData[[self indexInTitles:indexPath.section]];
        City *city = group.Cities[indexPath.row];
        [city cacheToHistory];
        self.selectBlock(city);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titlesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self isCollectionCell: section]) {
        return 1;
    } else {
        CitiesGroup *group = _CitiesData[[self indexInTitles:section]];
        return group.Cities.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isCollectionCell:indexPath.section]) {
        CityCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityCollectionCell" forIndexPath:indexPath];
        CitiesGroup *group = _CitiesData[[self indexInTitles:indexPath.section]];
        [cell loadCities:group.Cities];
        cell.citiesVC = self;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell" forIndexPath:indexPath];
        CitiesGroup *group = _CitiesData[[self indexInTitles:indexPath.section]];
        City *city = group.Cities[indexPath.row];
        cell.textLabel.text = city.Name;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isCollectionCell:indexPath.section]) {
        CitiesGroup *group = _CitiesData[[self indexInTitles:indexPath.section]];
        return [CityCollectionCell heightOfCitiesCount:group.Cities.count];
    } else {
        return 44;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0.0, [[UIScreen mainScreen] bounds].size.width, 30)];
    view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 0.0, [[UIScreen mainScreen] bounds].size.width - 15, 30)];
    headerLabel.textColor = [UIColor lightGrayColor];
    headerLabel.font = [UIFont systemFontOfSize:14];
    CitiesGroup *group = _CitiesData[[self indexInTitles:section]];
    headerLabel.text = group.FirstLetter;
    [view addSubview:headerLabel];
    return view;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
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
