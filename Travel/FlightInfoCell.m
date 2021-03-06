//
//  FlightInfoCell.m
//  Travel
//
//  Created by yang cai on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "FlightInfoCell.h"
#import "NSString+ToDate.h"
#import "NSDate+ToString.h"
#import "NSString+Attributed.h"
#import "CabinInfoCell.h"
#import "UIColor+Hex.h"

@interface FlightInfoCell()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *moreDayMark;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *startPlace;
@property (weak, nonatomic) IBOutlet UILabel *endPlace;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *airLineInfo;
@property Flight *flight;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FlightInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadInfo: (Flight *)flight {
    _flight = flight;
    _startTime.text = [[flight.TakeOffDate convertWith:@"yyyy-MM-dd HH:mm"] convertWith:@"HH:MM"];
    _endTime.text = [[flight.ArrivalDate convertWith:@"yyyy-MM-dd HH:mm"] convertWith:@"HH:MM"];
    NSString *moneyString = [NSString stringWithFormat:@"￥%.0f",flight.LowestPrice];
    _money.attributedText = [moneyString setColor:_money.textColor font: [UIFont systemFontOfSize:10] forSubString:@"￥"];
    _startPlace.text = [NSString stringWithFormat:@"%@ %@", flight.TakeoffAirportName, flight.TakeoffTerm];
    _endPlace.text = [NSString stringWithFormat:@"%@ %@", flight.ArriveAirportName, flight.ArrivalTerm];
    _airLineInfo.text = [NSString stringWithFormat:@"%@%@ | %@", flight.AirlineName, flight.FligthNo, flight.PlaneModel];
    
    [_logo setImage:[UIImage imageNamed:[NSString stringWithFormat:@"airline_%@",[flight.Airline lowercaseString]]]];
    
    if (self.bounds.size.height > 113) {
        self.backgroundColor = [UIColor colorWithHexString:@"#E5F6FF"];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
    if ([[[flight.TakeOffDate convertWith:@"yyyy-MM-dd HH:mm"] convertWith:@"dd"] isEqualToString:[[flight.ArrivalDate convertWith:@"yyyy-MM-dd HH:mm"] convertWith:@"dd"]]) {
        [_moreDayMark setHidden:YES];
    } else {
        [_moreDayMark setHidden:NO];
    }
    [_tableView reloadData];
}

+ (CGFloat)heightOfCabinsCount: (NSInteger)count {
    return count*70 + 113;
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _flight.Cabins.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CabinInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CabinInfoCell" forIndexPath:indexPath];
    Cabin *cabin = _flight.Cabins[indexPath.row];
    [cell loadInfo:cabin flight:_flight];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

@end
