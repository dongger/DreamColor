//
//  Passenger.h
//  Travel
//
//  Created by caiyang on 2017/5/11.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Passenger : NSObject

@property NSString *PassengerId;
@property NSInteger BookMode; //预订类型 直客 = 0, 因公 = 1, 因私 = 2
@property NSString *TicketNo;
@property NSString *Department;

@property NSString *Name;
@property NSString *Phone;
@property NSInteger IdType; //乘机人证件类型枚举: 身份证 = 0, 护照 = 1, 其他 = 2
@property NSString *IdTypeName;
@property NSString *IdNumber;
@property NSString *Birthday; //乘机人生日(出生年月) 格式:yyyy-MM-dd
@property NSInteger Sex; //乘机人性别 0:女 1:男
@property NSString *ServantBank; //公务卡发卡银行
@property NSString *ServantBankCode; //公务卡发卡银行编号
@property NSString *MileageAirlineCode; //里程卡所属航司
@property NSString *MileageCardNumber; //里程卡卡号
@property NSInteger StaffId; //常用乘机人 Id,如果为手动输入的乘机人则为 0
@property NSInteger VipType; //员工级别 1- 普通 2- Cip 3- Vip 4- VVip

@end
