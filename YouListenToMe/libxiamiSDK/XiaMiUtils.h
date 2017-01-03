//
//  XiaMiUtils.h
//  虾米音乐Demo
//
//  Created by 程倩 on 15/10/29.
//  Copyright (c) 2015年 CQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XiamiRequest.h"
@class Musicdetail;

@protocol XiaMiUtilsdelegate <NSObject>
//歌曲搜索请求回调
@optional
- (void) getMusicSerchResult:(NSArray *)array ismore:(BOOL)more;

-(void) getMusicDto:(Musicdetail *)Musicdetail;

-(void)getURLConvert:(NSString *)logo URLType:(NSString *)type;

@end

@interface XiaMiUtils : NSObject

@property(nonatomic,weak)id<XiaMiUtilsdelegate>delegate;

/**
 *  调用api 接口
 *
 *  @param method <#method description#>
 *  @param params <#params description#>
 *
 *  @return <#return value description#>
 */
- (void)requestWithMethod:(NSString*)method params:(NSDictionary *)params;

/**
 *  图片地址转换
 *
 *  @param logo url地址
 *  @param size 大小
 *  @param type 类型   歌手地址 或者专辑地址
 */
-(void)getlogo:(NSString *)logo size:(int)size URLType:(NSString *)type;



@end
