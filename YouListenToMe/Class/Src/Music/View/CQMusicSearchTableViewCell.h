//
//  CQMusicSearchTableViewCell.h
//  YouListenToMe
//
//  Created by 程倩 on 15/11/27.
//  Copyright (c) 2015年 CQ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Musicdetail;

@interface CQMusicSearchTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *musicIcon;  //歌曲专辑图标
@property (nonatomic,strong) UILabel     *musicName;  //歌曲名称
@property (nonatomic,strong) UIView      *contentsView; //存放数据的view
@property (nonatomic,strong) UILabel     *musicDesc;  //演唱者和歌曲专辑名称

@property (nonatomic,strong) Musicdetail *MusicDTO; //数据模型
@property (nonatomic,copy) void(^cellDidSelecteBlock)();

@end
