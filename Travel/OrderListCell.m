//
//  OrderListCell.m
//  Travel
//
//  Created by yang cai on 2017/5/14.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "OrderListCell.h"
#import "UIColor+Hex.h"
#import "NSString+Attributed.h"

@interface OrderListCell()
@property (weak, nonatomic) IBOutlet UIButton *typeMark;
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *startPlaceWidth;
@property (weak, nonatomic) IBOutlet UILabel *startPlace;
@property (weak, nonatomic) IBOutlet UILabel *endPlace;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *dateInfo;
@property (weak, nonatomic) IBOutlet UILabel *flightInfo;
@property (weak, nonatomic) IBOutlet UIButton *payButton;

@property Order *order;


@end

@implementation OrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (CGFloat)height: (Order *)order {
    if (order.OrderStatus == 0) {
        return 161;
    } else {
        return 120;
    }
}

- (void)loadInfo: (Order *)order {
    _order = order;
    switch (_order.BookMode) {
        case 0: {
            //直客
            [_typeMark setImage:nil forState:UIControlStateNormal];
        }
            break;
        case 1: {
            //因公
            [_typeMark setImage:[UIImage imageNamed:@"official_order_ico"] forState:UIControlStateNormal];

        }
            break;
        case 2: {
            //因私
            [_typeMark setImage:[UIImage imageNamed:@"private_order_ico"] forState:UIControlStateNormal];

        }
            break;

        default:
            break;
    }
    [_typeMark setTitle:[NSString stringWithFormat:@"  %@  预订",_order.CreateDate] forState:UIControlStateNormal];
    _orderStatus.text = _order.OrderStatusString;
    _orderStatus.textColor = [UIColor colorWithHexString:_order.OrderStatusColor];
    _startPlace.text = _order.TakeoffCityName;
    _endPlace.text = _order.ArriveCityName;
    NSString *priceString = [NSString stringWithFormat:@"￥%0.0f",_order.SettlePrice];
    _price.attributedText = [priceString setColor:_price.textColor font:[UIFont systemFontOfSize:10] forSubString:@"￥"];
    
    _dateInfo.text = [NSString stringWithFormat:@"%@ 起飞",_order.TakeOffDate];
    _flightInfo.text = [NSString stringWithFormat:@"%@%@",_order.Airline,_order.FligthNo];
    
    _payButton.layer.borderColor = [[UIColor colorWithHexString:@"#ff4000"] CGColor];
    _payButton.layer.borderWidth = 1;
    
    if (order.OrderStatus == 3) {
        _startPlace.textColor = [UIColor colorWithHexString:@"#bbbbbb"];
        _endPlace.textColor = [UIColor colorWithHexString:@"#bbbbbb"];
    } else {
        _startPlace.textColor = [UIColor colorWithHexString:@"#333333"];
        _endPlace.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    _startPlaceWidth.constant = [self widthForString:_startPlace.text andHeight:_startPlace.bounds.size.height];
}

- (IBAction)pay:(id)sender {
    
}

- (float) widthForString:(NSString *)value andHeight:(float)height{
    //获取当前文本的属性
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:value];
    NSRange range = NSMakeRange(0, attrStr.length);
    [attrStr addAttribute:NSFontAttributeName value: _startPlace.font range:range];

    // 获取该段attributedString的属性字典
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    // 计算文本的大小
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(MAXFLOAT, height) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:dic        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.width + 2;
}

@end
