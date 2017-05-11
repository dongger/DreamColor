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

@interface FlightInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *moreDayMark;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *startPlace;
@property (weak, nonatomic) IBOutlet UILabel *endPlace;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *airLineInfo;

@end

@implementation FlightInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadInfo: (Flight *)flight {
    _startTime.text = [[flight.TakeOffDate convertWith:@"yyyy-MM-dd HH:mm"] convertWith:@"HH:MM"];
    _endTime.text = [[flight.ArrivalDate convertWith:@"yyyy-MM-dd HH:mm"] convertWith:@"HH:MM"];
    NSString *moneyString = [NSString stringWithFormat:@"￥%.0f元",flight.LowestPrice];
    _money.attributedText = [moneyString setColor:_money.textColor font: [UIFont systemFontOfSize:12] forSubString:@"￥"];
    _startPlace.text = [NSString stringWithFormat:@"%@ %@", flight.TakeoffAirportName, flight.TakeoffTerm];
    _endPlace.text = [NSString stringWithFormat:@"%@ %@", flight.ArriveAirportName, flight.ArrivalTerm];
    _airLineInfo.text = [NSString stringWithFormat:@"%@%@ | %@", flight.AirlineName, flight.FligthNo, flight.PlaneModel];
}

@end
