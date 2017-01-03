//
//  CQYouListenToMeUtils.m
//  YouListenToMe
//
//  Created by 程倩 on 15/11/23.
//  Copyright (c) 2015年 CQ. All rights reserved.
//

#import "CQYouListenToMeUtils.h"

@implementation CQYouListenToMeUtils
+ (UILabel *)creatLabelWith:(CGRect)rect :(NSString *)title :(UIFont *)font :(UIColor *)color
{
    UILabel *temp        = [[UILabel alloc] initWithFrame:rect];
    temp.backgroundColor = [UIColor clearColor];
    temp.text            = title;
    temp.textColor       = color;
    temp.font            = font;
    
    return temp;
}

+ (UIButton *)creatCustomButton:(CGRect)rect :(NSString *)title :(NSInteger)fontSize :(UIColor *)color
{
    UIButton *temp                   = [UIButton buttonWithType:UIButtonTypeCustom];
    temp.frame                       = rect;
    [temp setTitle:title forState:UIControlStateNormal];
    [temp setTitleColor:color forState:UIControlStateNormal];
    temp.titleLabel.font             = [UIFont systemFontOfSize:fontSize];
    temp.adjustsImageWhenHighlighted = NO;
    
    return temp;
}

/**
 *  <#Description#>
 *
 *  @param rect  imageview的fream
 *  @param image image的名称
 *
 *  @return return 接受事件的UIImageView
 */
+ (UIImageView *)creatCustomImageView:(CGRect)rect :(UIImage *)image
{
    UIImageView *temp           = [[UIImageView alloc] initWithFrame:rect];
    temp.userInteractionEnabled = YES;
    temp.backgroundColor        = [UIColor clearColor];
    temp.image                  = image;
    
    return temp;
}

+ (UITextField *)creatCustomTextfield:(CGRect)rect :(NSInteger)fontSize
{
    UITextField *temp             = [[UITextField alloc] initWithFrame:rect];
    temp.backgroundColor          = [UIColor clearColor];
    temp.font                     = [UIFont systemFontOfSize:fontSize];
    temp.returnKeyType            = UIReturnKeyDone;
    temp.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    return temp;
}

+ (UITextView *)creatCustomTextView:(CGRect)rect :(NSInteger)fontSize :(UIColor *)color
{
    UITextView *temp     = [[UITextView alloc] initWithFrame:rect];
    temp.backgroundColor = [UIColor clearColor];
    temp.font            = [UIFont systemFontOfSize:fontSize];
    temp.textColor       = color;
    
    return temp;
}
//将NSTimeInterval 转换为分钟 秒。
+(NSString *)timeIntervalConversionString:(NSTimeInterval)time
{
    int  timeint = time;
    
    return [NSString stringWithFormat:@"%02d:%02d",timeint / 60 ,timeint % 60];
}

@end
