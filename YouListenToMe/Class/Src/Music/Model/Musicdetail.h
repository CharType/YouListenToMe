//
//  Musicdetail.h
//  虾米音乐歌曲详情
//
//  Created by 程倩 on 15/11/5.
//  Copyright (c) 2015年 CQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DOUAudioStreamer.h"

@interface Musicdetail : NSObject <DOUAudioFile>
/**
 *  歌曲id
 */
@property(nonatomic,copy)NSString *song_id;
/**
 *  歌曲名称
 */
@property(nonatomic,copy)NSString *song_name;
/**
 *  艺人id, 
 */
@property(nonatomic,copy)NSString *artist_id;

/**
 *  艺人名
 */
@property(nonatomic,copy)NSString *artist_name;
/**
 *  艺人logo
 */
@property(nonatomic,copy)NSString *artist_logo;
/**
 *  演唱者
 */
@property(nonatomic,copy)NSString  *singers;
/**
 *  专辑ID,
 */
@property(nonatomic,copy)NSString *album_id;
/**
 *  专辑名称
 */
@property(nonatomic,copy)NSString *album_name;
/**
 *  专辑logo
 */
@property(nonatomic,copy)NSString *album_logo;
/**
 *  歌曲长度
 */
@property(nonatomic,copy)NSString *length;
/**
 *  歌曲序号
 */
@property(nonatomic,copy)NSString *track;
/**
 *  CD号
 */
@property(nonatomic,copy)NSString *cd_serial;
/**
 *  是否纯音乐，1为纯音乐，0为非纯音乐
 */
@property(nonatomic,copy)NSString *music_type;
/**
 *  试听地址
 */
@property(nonatomic,copy)NSString *listen_file;
/**
 *  播放文件类型, l表示低品质, m表示中品质, h表示高品质, o表示无损品质
 */
@property(nonatomic,copy)NSString *quality;
/**
 *  过期时间
 */
@property(nonatomic,assign)int expire;
/**
 *  声音信息，均衡器使用
 */
@property(nonatomic,copy)NSNumber *play_volume;
/**
 *  歌词类型，1为text,2为lrc,3为trc,4为翻译歌词
 */
@property(nonatomic,copy)NSString *lyric_type;
/**
 *  动态歌词
 */
@property(nonatomic,copy)NSString  *lyric;

+ (Musicdetail *)parser:(NSDictionary *)paras;

@property (nonatomic, strong) NSURL *audioFileURL;


@end
