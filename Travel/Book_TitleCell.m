//
//  Book_TitleCell.m
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "Book_TitleCell.h"
#import "NSDate+ToString.h"
#import "NSString+ToDate.h"


@interface Book_TitleCell()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *flightInfo;
@property (weak, nonatomic) IBOutlet UILabel *startDate;
@property (weak, nonatomic) IBOutlet UILabel *endDate;
@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *startAirPort;
@property (weak, nonatomic) IBOutlet UILabel *endAirPort;
@property (weak, nonatomic) IBOutlet UILabel *TicketPrice;
@property (weak, nonatomic) IBOutlet UILabel *otherFee;

@end

@implementation Book_TitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (IBAction)showDetail:(id)sender {
}
- (IBAction)showRefundRule:(id)sender {
}


- (void)loadInfo: (Flight *)flight
           cabin: (Cabin *)cabin {
    NSDate *startDate = [flight.TakeOffDate convertWith:@"yyyy-MM-dd HH:mm"];
    NSDate *endDate = [flight.ArrivalDate convertWith:@"yyyy-MM-dd HH:mm"];
    _title.text = [NSString stringWithFormat:@"%@    %@ - %@",[startDate convertWith:@"MM月dd日"], flight.TakeoffCityName, flight.ArriveCityName];
    _flightInfo.text = [NSString stringWithFormat:@"%@ %@ | %@ | %@%@折",
                        flight.AirlineName,
                        flight.FligthNo,
                        flight.PlaneModel,
                        cabin.CabinType,
                        [NSString stringWithFormat:@"%ld",(long)cabin.CabinDiscount]];
    _startDate.text = [startDate convertWith:@"mm月dd日"];
    _endDate.text = [endDate convertWith:@"mm月dd日"];
    _startTime.text = [startDate convertWith:@"HH:MM"];
    _endTime.text = [endDate convertWith:@"HH:MM"];
    _startAirPort.text = [NSString stringWithFormat:@"%@%@", flight.TakeoffAirportName, flight.TakeoffTerm];
    _endAirPort.text = [NSString stringWithFormat:@"%@%@", flight.ArriveAirportName, flight.ArrivalTerm];
    _TicketPrice.text = [NSString stringWithFormat:@"￥%0.0f", cabin.TicketPrice];
    _otherFee.text = [NSString stringWithFormat:@"￥%0.0f", flight.FuelFee];
    
}

+ (CGFloat)height: (BOOL)showDetail {
    if (showDetail) {
        return 217;
    } else {
        return 217 - 104;
    }
}

@end
