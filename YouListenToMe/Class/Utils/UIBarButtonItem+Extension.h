//
//  UIBarButtonItem+Extension.h
//  YouListenToMe
//
//  Created by 程倩 on 15-11-22.
//  Copyright (c) 2014年 程倩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/**
 *  快速创建item
 *
 *  @param title    需要显示的标题
 *  @param norImage 默认状态显示的图片
 *  @param higImage 高亮状态显示的图片
 *
 *  @return item
 */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title norImage:(NSString *)norImage higImage:(NSString *)higImage tagert:(id)tagert action:(SEL)action;
@end
