//
//  SNPMDaoDaoMusicPlayerSingleton.h
//  SuningEBuy
//
//  Created by 李尧伟 on 15/11/23.
//  Copyright © 2015年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFSoundManager.h"
//引入完美单例
#import"SingleTon.h"
#import "Musicdetail.h"

@interface MusicPlayerSingleton : NSObject

SingleTonH(MusicPlayerSingleton);

@property (nonatomic,strong)AFSoundPlayback * playBack;//音乐播放器
@property (nonatomic,strong)AFSoundItem * musicItem;//音乐参数

@property(nonatomic,strong)Musicdetail *musicdetail;  // 当前播放的音乐模型数据

@property(nonatomic,assign)BOOL        PlayMusic;


@end
