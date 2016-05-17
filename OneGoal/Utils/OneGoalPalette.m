//
//  OneGoalPalette.m
//  OneGoal
//
//  Created by stone on 16/5/13.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "OneGoalPalette.h"

@implementation OneGoalPalette

UIColor *colorFromRGB(NSInteger rgbValue) {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

+ (UIColor *)blue
{
    return colorFromRGB(0x95E5E5);
}

+ (UIColor *)white
{
    return colorFromRGB(0xFFFEEC);
}

+ (UIColor *)red
{
    return colorFromRGB(0xD16161);
}

+ (UIColor *)black
{
    return colorFromRGB(0x2B2D2E);
}

+ (UIColor *)buttonTextColorYellow
{
    return colorFromRGB(0xFFFBDF);
}

+ (NSString *)paletteName
{
    return @"Main Palette";
}

@end
