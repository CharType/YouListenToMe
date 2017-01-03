//
//  CQMusicLrcView.h
//  YouListenToMe
//
//  Created by 程倩 on 15/12/12.
//  Copyright © 2015年 CQ. All rights reserved.
//

#import "DRNRealTimeBlurView.h"

@interface CQMusicLrcView : UIView

/**
 *  音乐所有歌词
 */
@property (nonatomic, copy) NSString *MusiclrUrl;

/**
 *  当前播放时间
 */
@property (nonatomic, assign) NSTimeInterval currentTime;

/**
 *  歌词是否全屏状态
 */
@property(nonatomic,assign) BOOL   isfullscreen;

/**
 *  歌词类型，1为text,2为lrc,3为trc,4为翻译歌词
 */
@property(nonatomic,copy)NSString *lyric_type;

@property(nonatomic,strong)UILabel *nolrcLable;

@end
