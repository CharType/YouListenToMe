//
//  CQYouListenToMeUtils.h
//  YouListenToMe
//
//  Created by 程倩 on 15/11/23.
//  Copyright (c) 2015年 CQ. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CQYouListenToMeUtils : NSObject

//动态计算文字尺寸
+ (UILabel *)creatLabelWith:(CGRect)rect :(NSString *)title :(UIFont *)font :(UIColor *)color;

+ (UIImageView *)creatCustomImageView:(CGRect)rect :(UIImage *)image;

+ (UIButton *)creatCustomButton:(CGRect)rect :(NSString *)title :(NSInteger)fontSize :(UIColor *)color;

+ (UITextField *)creatCustomTextfield:(CGRect)rect :(NSInteger)fontSize;

+ (UITextView *)creatCustomTextView:(CGRect)rect :(NSInteger)fontSize :(UIColor *)color;

+(NSString *)timeIntervalConversionString:(NSTimeInterval)time;

@end
