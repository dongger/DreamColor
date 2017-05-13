//
//  UIView+CurrentVC.m
//  Travel
//
//  Created by yang cai on 2017/5/13.
//  Copyright © 2017年 Nil. All rights reserved.
//

#import "UIView+CurrentVC.h"

@implementation UIView (CurrentVC)

- (UIViewController *)currentVC {
    id temp = [self nextResponder];
    while (![temp isKindOfClass:[UIViewController class]]) {
        temp = [temp nextResponder];
    }
    if ([temp isKindOfClass:[UIViewController class]]) {
        return (UIViewController *)temp;
    } else {
        return [[UIViewController alloc] init];
    }
}

@end
