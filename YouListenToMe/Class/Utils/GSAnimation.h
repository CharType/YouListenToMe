//  GSAnimation.h
//  动画效果封装
//  Created by ShangchaoGao on 15-6-02.
//  Copyright (c) 2015年 ShangchaoGao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GSAnimation : NSObject
/**
 *  视图抖动动画
 *
 *  @param view      <#view description#>
 *  @param fDuration <#fDuration description#>
 */
+ (void)shakeView:(UIView *)view duration:(CGFloat)fDuration;
/**
 *  抖动动画 （密码输入错误时的提示）
 *
 *  @param view     <#view description#>
 *  @param duration <#duration description#>
 */
+ (void)addShakeAnimationForView:(UIView *)view withDuration:(NSTimeInterval)duration;
/**
 *  心跳动画
 *
 *  @param view      <#view description#>
 *  @param fDuration <#fDuration description#>
 */
+ (void)heartbeatView:(UIView *)view duration:(CGFloat)fDuration;
/**
 *  对指定视图进行截图
 *
 *  @param view <#view description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *)screenShotView:(UIView *)view;
/**
 *  弹出动画，类似于苹果弹出视图
 *
 *  @param view <#view description#>
 */
+(void)popViewAnimation:(UIView *)view;
+(void)popViewAnimation:(UIView *)view Duration:(float) duration;
/**
 *  永久闪烁的动画
 *
 *  @param time   <#time description#>
 *  @param toView <#toView description#>
 */
+(void)opacityForeverAnimation:(float)time toView:(UIView *)toView;
/**
 *  渐隐效果的动画
 *
 *  @param time   <#time description#>
 *  @param toView <#toView description#>
 */
+(void)opacityAnimation:(float)time toView:(UIView *)toView;
/**
 *  旋转动画
 *
 *  @param time   <#time description#>
 *  @param axis   <#axis description#>
 *  @param toView <#toView description#>
 */
+(void)rotationAnimation:(float)time XYZ_Axis:(NSString *)axis toView:(UIView *)toView;
/**
 *  跳动效果
 *
 *  @param x         <#x description#>
 *  @param y         <#y description#>
 *  @param imageName <#imageName description#>
 *  @param toView    <#toView description#>
 */
+(void)hotSpotX:(float)x hotSpotY:(float)y imageName:(NSString *)imageName  toView:(UIView *)toView;


/**
 *  淡入淡出的动画
 *
 *  @param durationTime <#durationTime description#>
 *  @param toView       <#toView description#>
 */
+(void)fadeAnimation:(float)durationTime toView:(UIView *)toView;
/**
 *  阿拉伯神灯吸入的动画
 *
 *  @param durationTime <#durationTime description#>
 *  @param toView       <#toView description#>
 */
+(void)suckEffectAnimation:(float)durationTime toView:(UIView *)toView;
/**
 *  立方体切换的动画
 *
 *  @param durationTime <#durationTime description#>
 *  @param toView       <#toView description#>
 */
+(void)cubeAnimation:(float)durationTime toView:(UIView *)toView;
/**
 *  上下翻转的动画
 *
 *  @param durationTime <#durationTime description#>
 *  @param toView       <#toView description#>
 */
+(void)oglFlipAnimation:(float)durationTime toView:(UIView *)toView;
/**
 *  水纹的动画
 *
 *  @param durationTime <#durationTime description#>
 *  @param toView       <#toView description#>
 */
+(void)rippleEffectAnimation:(float)durationTime toView:(UIView *)toView;
/**
 *  移除的动画
 *
 *  @param durationTime <#durationTime description#>
 *  @param toView       <#toView description#>
 */
+(void)revealAnimation:(float)durationTime toView:(UIView *)toView;
/**
 *  push动画
 *
 *  @param subType <#subType description#>
 *  @param toView  <#toView description#>
 */
+(void)pushAnimationWithSubType:(NSString *)subType toView:(UIView *)toView;



#pragma mark - Custom Animation
// reveal
+ (void)animationRevealFromBottom:(UIView *)view;
+ (void)animationRevealFromTop:(UIView *)view;
+ (void)animationRevealFromLeft:(UIView *)view;
+ (void)animationRevealFromRight:(UIView *)view;

/**
 *  渐隐渐消
 *
 *  @param view <#view description#>
 */
+ (void)animationEaseIn:(UIView *)view;
+ (void)animationEaseOut:(UIView *)view;

/**
 *  翻转
 *
 *  @param view <#view description#>
 */
+ (void)animationFlipFromLeft:(UIView *)view;
+ (void)animationFlipFromRigh:(UIView *)view;

/**
 *  翻页
 *
 *  @param view <#view description#>
 */
+ (void)animationCurlUp:(UIView *)view;
+ (void)animationCurlDown:(UIView *)view;

// push
+ (void)animationPushUp:(UIView *)view;
+ (void)animationPushDown:(UIView *)view;
+ (void)animationPushLeft:(UIView *)view;
+ (void)animationPushRight:(UIView *)view;

// move
+ (void)animationMoveUp:(UIView *)view duration:(CFTimeInterval)duration;
+ (void)animationMoveDown:(UIView *)view duration:(CFTimeInterval)duration;
+ (void)animationMoveLeft:(UIView *)view;
+ (void)animationMoveRight:(UIView *)view;

/**
 *  各种旋转缩放效果
 *
 *  @param view     <#view description#>
 *  @param duration <#duration description#>
 */
+(void)animationRotateAndScaleEffects:(UIView *)view DurationTime:(float) duration;

/**
 *  旋转同时缩小放大效果
 *
 *  @param time <#time description#>
 *  @param view <#view description#>
 */
+ (void)animationRotateAndScaleDownUpWithDuration:(CGFloat)time forView:(UIView *)view;


#pragma mark - Private API

/**
 *  下面动画里用到的某些属性在当前API里是不合法的,但是也可以用
 *
 *  @param view <#view description#>
 */

+ (void)animationFlipFromTop:(UIView *)view;
+ (void)animationFlipFromBottom:(UIView *)view;

+ (void)animationCubeFromLeft:(UIView *)view;
+ (void)animationCubeFromRight:(UIView *)view;
+ (void)animationCubeFromTop:(UIView *)view;
+ (void)animationCubeFromBottom:(UIView *)view;

+ (void)animationSuckEffect:(UIView *)view;

+ (void)animationRippleEffect:(UIView *)view;

+ (void)animationCameraOpen:(UIView *)view;
+ (void)animationCameraClose:(UIView *)view;

@end

