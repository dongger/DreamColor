//
//  CyAlertView.m
//  MedLinker
//
//  Created by caiyang on 15/6/17.
//  Copyright (c) 2015年 MedLinker. All rights reserved.
//

#import "CyAlertView.h"
static CyAlertView *cyAlertView;
static CGFloat messageFont = 13;
static CGFloat inset = 24;

@interface CyAlertView ()

@property (retain,nonatomic) UILabel *messageLabel;
@property (retain,nonatomic) UIView *blackgroundView;

@property (assign,nonatomic) CGRect  initRect;
@property (retain,nonatomic) NSTimer *timer;

@end
@implementation CyAlertView

+(CyAlertView*)shareCyAlertView
{
    @synchronized (self)
    {
        //找出 主视图的window 以免加在了 alertview等的window上 导致现实瑕疵
//        UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
        UIWindow * window = [[UIApplication sharedApplication] keyWindow];
        if (window.windowLevel != UIWindowLevelNormal)
        {
            NSArray *windows = [[UIApplication sharedApplication] windows];
            for(UIWindow * tmpWin in windows)
            {
                if (tmpWin.windowLevel == UIWindowLevelNormal)
                {
                    window = tmpWin;
                    break;
                }
            }
        }

        if (cyAlertView == nil)
        {
            cyAlertView =  [[CyAlertView alloc] init];

            float width = [UIScreen mainScreen].bounds.size.width;
            float height = [UIScreen mainScreen].bounds.size.height;

            cyAlertView.initRect = CGRectMake(0, height/3, width, 44);
            cyAlertView.frame = cyAlertView.initRect;
            cyAlertView.backgroundColor = [UIColor clearColor];
            cyAlertView.alpha = 0;
            [window addSubview:cyAlertView];
            
            cyAlertView.blackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 44)];
            cyAlertView.blackgroundView.backgroundColor = [UIColor colorWithRed:3/255.0 green:12/255.0 blue:27/255.0 alpha:1.0];
            cyAlertView.blackgroundView.alpha = 0.6;
            cyAlertView.blackgroundView.layer.cornerRadius = 5.0;
            cyAlertView.blackgroundView.layer.masksToBounds = YES;
            [cyAlertView addSubview:cyAlertView.blackgroundView];

            cyAlertView.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, width - 24, 44)];
            cyAlertView.messageLabel.textAlignment = NSTextAlignmentCenter;
            cyAlertView.messageLabel.textColor = [UIColor whiteColor];
            cyAlertView.messageLabel.font = [UIFont systemFontOfSize:messageFont];
            cyAlertView.messageLabel.numberOfLines = 0;
            [cyAlertView addSubview:cyAlertView.messageLabel];
            
            cyAlertView.timer = [[NSTimer alloc]init];
        }
        else
        {
            //防止window变化 导致不可见
            [cyAlertView removeFromSuperview];
            [window addSubview:cyAlertView];
        }
    }
    return cyAlertView;
}

-(void)show
{
    [[CyAlertView shareCyAlertView].timer invalidate];
    
    float labelWidth = [UIApplication sharedApplication].keyWindow.bounds.size.width - 24 - inset;
    CGSize size = [self boundingRectWithSize:CGSizeMake(labelWidth, 0)];
    self.messageLabel.frame = CGRectMake(12 + inset/2, self.frame.size.height - size.height, size.width, size.height);
    CGPoint center = CGPointMake(self.center.x, self.messageLabel.center.y);
    self.messageLabel.center = center;
    
    self.blackgroundView.frame = CGRectMake(0, 0, size.width + inset, size.height + inset);
    self.blackgroundView.center = self.messageLabel.center;
    
    CGRect tempRect = _initRect;
    
    [UIView animateWithDuration:0.3 animations:^{
        [CyAlertView shareCyAlertView].alpha = 1;
        [CyAlertView shareCyAlertView].frame = tempRect;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)close
{
    [UIView animateWithDuration:0.3 animations:^{
        [CyAlertView shareCyAlertView].alpha = 0;
        [CyAlertView shareCyAlertView].frame = _initRect;
    } completion:^(BOOL finished) {

    }];
}

+(void)message:(NSString *)message
{
    if ([message isKindOfClass:[NSString class]])
    {
        [CyAlertView shareCyAlertView].messageLabel.text = message;
        [[CyAlertView shareCyAlertView] show];
        [CyAlertView shareCyAlertView].timer = [NSTimer scheduledTimerWithTimeInterval:2 target:[CyAlertView shareCyAlertView] selector:@selector(close) userInfo:nil repeats:NO];
    }
    else
    {
        [CyAlertView message:@"No message"];
    }
}


- (CGSize)boundingRectWithSize:(CGSize)size
{
    UIFont *font = [UIFont systemFontOfSize:messageFont];
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize retSize = [self.messageLabel.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}


@end
