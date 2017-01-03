//
//  XiamiRequest.m
//  xiamiSDK
//
//  Created by zrw on 15/6/17.
//  Copyright (c) 2015年 xiami. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XiamiRequest : NSObject

/**
 *  在虾米sdk中注册第三方应用,需要在每次启动第三方应用程序时调用， 只需调用一次。
 *
 *
 *  @param appKey  开发者appKey
 *  @param appSecret 开发者appSecret
 *  @return SDK 注册是否成功
 */
+ (BOOL)registerAppKey:(NSString *)appKey
             appSecret:(NSString *)appSecret;

/**
 *  通用api调用接口，通过传入命令字和参数调用，返回Json字符串
 *
 * @param method 相应api命令字符串
 * @param params     api传入参数字典
 * @return 返回的Json字符串
 */
+ (NSString*)requestWithMethod:(NSString*)method params:(NSDictionary *)params;

/**
 * 类方法，播放地址解密
 */
+ (NSString*)decryptWithContent:(NSString*) content;

/**
 * 根据给定控件尺寸size，向上兼容返回一个合适的图片尺寸
 * <p>返回的尺寸包括80, 120, 220, 330, 400, 640, 720。都是正方形</p>
 *
 * @param imageURL 原始图片地址
 * @param size 需要返回的尺寸
 * @return 返回图片文件地址
 */
+ (NSString*)transferImageURL:(NSString*)imageURL toImageSize:(int)size;

/**
 * 类方法，返回当前sdk版本
 */
+ (NSString*)version;

@end