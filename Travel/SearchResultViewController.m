//
//  SearchResultViewController.m
//  Travel
//
//  Created by yang cai on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "SearchResultViewController.h"
#import "FlightInfoCell.h"
#import "QueryFlightModel.h"
#import "FiltrateViewController.h"
#import "FiltrateViewController.h"
#import "NSObject+Cache.h"
#import "CalendarViewController.h"
#import "NSDate+ToString.h"
#import "NSString+ToDate.h"
#import "CyAlertView.h"

static NSString *saveKey = @"kQueryFlightResult";
static NSString *searchDateKey = @"kSearchDate";

@interface SearchResultViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSInteger selectedRow;
@property (weak, nonatomic) IBOutlet UIButton *pickDateButton;

@end


@implementation SearchResultViewController

+ (SearchResultViewController *)instance {
    SearchResultViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SearchResultViewController"];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self filtrate];
}

- (void)setUp {
    _selectedRow = -1;
    [self setDate:_searchDate];
    [self fetchData];
}

- (IBAction)pickDate:(id)sender {
    CalendarViewController *calendar = [CalendarViewController instance:^(NSDate * _Nullable date) {
        _searchDate = date;
        [self setDate:date];
    }];
    [self.navigationController pushViewController:calendar animated:YES];
}

- (void)setDate: (NSDate *)date {
    [[NSUserDefaults standardUserDefaults] setObject:[date convertWith:@"yyyy-MM-dd"] forKey:searchDateKey];
    NSString *dateString = [_searchDate convertWith:@"MM-dd"];
    [_pickDateButton setTitle:[NSString stringWithFormat:@" %@ %@",dateString,[date dayName]] forState:UIControlStateNormal];
}

- (BOOL)isEnble: (NSDate *)date  {
    NSDate *lastDate = [[NSDate date] dateByAddingTimeInterval:60*60*24*180];
    if ([[date earlierDate:[NSDate date]] isEqualToDate:date] || [[date laterDate:lastDate] isEqualToDate:date]) {
        return NO;
    } else {
        return YES;
    }
}

- (IBAction)before:(id)sender {
    NSDate *newDate = [_searchDate dateByAddingTimeInterval:-60*60*24];
    newDate = [self GMTOffset:newDate];
    if ([self isEnble:newDate]) {
        _searchDate = [_searchDate dateByAddingTimeInterval:-60*60*24];
        [self setUp];
    } else {
        [CyAlertView message:@"不可以查询今天以前的航班"];
    }
}
- (IBAction)after:(id)sender {
    NSDate *newDate = [_searchDate dateByAddingTimeInterval:60*60*24];
    newDate = [self GMTOffset:newDate];
    if ([self isEnble:newDate]) {
        _searchDate = [_searchDate dateByAddingTimeInterval:60*60*24];
        [self setUp];
    } else {
        [CyAlertView message:@"不可以查询180天以后的航班"];
    }
}

- (NSDate *)GMTOffset: (NSDate *)date {
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:_searchDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:_searchDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    return [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
}

- (void)filtrate {
    if (_result != nil && _selectedFiltrateArray.count == 3) {
        [self getCache];
        NSMutableArray *flights = [[NSMutableArray alloc] init];
        for (Flight *flight in _result.Flights) {
            BOOL needShow = YES;
            if ([_selectedFiltrateArray[0] count] > 0) {
                //筛选时间
                if (![_selectedFiltrateArray[0] containsObject:flight.TakeOffDatePeriods]) {
                    needShow = NO;
                    continue;
                }
            }
            if ([_selectedFiltrateArray[1] count] > 0) {
                //筛选航司
                if (![_selectedFiltrateArray[1] containsObject:flight.AirlineName]) {
                    needShow = NO;
                    continue;
                }
            }
            if ([_selectedFiltrateArray[2] count] > 0) {
                //筛选舱位
                NSMutableArray *cabins = [[NSMutableArray alloc] init];
                for (Cabin *cabin in flight.Cabins) {
                    if ([_selectedFiltrateArray[2] containsObject: cabin.CabinType]) {
                        [cabins addObject:cabin];
                    }
                }
                if (cabins.count > 0) {
                    flight.Cabins = cabins;
                } else {
                    needShow = NO;
                    continue;
                }
            }
            if (needShow) {
                [flights addObject:flight];
            }
        }
        _result.Flights = flights;
        [_tableView reloadData];
    }
}

- (void)fetchData {
    [QueryFlightModel fetchWithStartCityCode:_startCity.Code
                         destinationCityCode:_destinationCity.Code
                                        date:_searchDate
                                    bookType:_bookType
                                  travelType:_travelType
                                     success:^(QueryFlightResult* result)
     {
         if (_result == nil) {
             _selectedFiltrateArray = [[NSMutableArray alloc]
                                       initWithObjects:
                                       [NSMutableArray arrayWithArray:@[]],
                                       [NSMutableArray arrayWithArray:@[]],
                                       [NSMutableArray arrayWithArray:@[]],nil];
         }
         _result = result;
         [_result saveWithKey: saveKey];
         [self.tableView reloadData];
     } failure:^(NSString *errorMessage) {
         
     }];
}

- (void)getCache {
    if ([QueryFlightResult getFromKey:saveKey] != nil) {
        _result = [QueryFlightResult getFromKey:saveKey];
        _selectedRow = -1;
        [_tableView reloadData];
    }
}

- (IBAction)filtrate:(id)sender {
    FiltrateViewController *vc = [FiltrateViewController instanceWithdelegate:self];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)sortedByTakeOffDate {
    _result.Flights = [_result.Flights sortedArrayUsingComparator:^NSComparisonResult(Flight * _Nonnull obj1, Flight *  _Nonnull obj2) {
        return [obj1.TakeOffDate compare:obj2.TakeOffDate];
    }];
    _selectedRow = -1;
    [self.tableView reloadData];
}

- (IBAction)sortedByPrice {
    _result.Flights = [_result.Flights sortedArrayUsingComparator:^NSComparisonResult(Flight * _Nonnull obj1, Flight *  _Nonnull obj2) {
        return [@(obj1.LowestPrice) compare: @(obj2.LowestPrice)];
    }];
    _selectedRow = -1;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _result.Flights.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FlightInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FlightInfoCell" forIndexPath:indexPath];
    Flight *flight = _result.Flights[indexPath.row];
    [cell loadInfo:flight];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedRow == indexPath.row) {
        Flight *flight = _result.Flights[indexPath.row];
        return [FlightInfoCell heightOfCabinsCount:flight.Cabins.count];
    } else {
        return [FlightInfoCell heightOfCabinsCount:0];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedRow == indexPath.row) {
        _selectedRow = -1;
    } else {
        _selectedRow = indexPath.row;
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
@end
