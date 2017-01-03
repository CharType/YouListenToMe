//
//  CQMusicViewControoler.m
//  YouListenToMe
//
//  Created by 程倩 on 15/11/21.
//  Copyright © 2015年 CQ. All rights reserved.
//

#import "CQMusicViewControoler.h"
#import "CQMusciSearchViewController.h"
#import "XiaMiUtils.h"
#import "Musicdetail.h"
#import "CQYouListenToMeUtils.h"
#import "UIImageView+WebCache.h"
//#import "FXBlurView.h"
#import "DRNRealTimeBlurView.h"
#import "DOUAudioStreamer.h"
#import <AVFoundation/AVFoundation.h>
#import "CQMusicLrcView.h"

//#import "MusicPlayerSingleton.h"
//#import "AFSoundItem.h"
#import "YYFPSLabel.h"

#define CQStatusProp @"status"
#define CQDurationProp @"duration"
#define CQBufferingRatioProp @"bufferingRatio"







@interface CQMusicViewControoler ()<CQMusciSearchViewControllerdelegate,XiaMiUtilsdelegate>

@property(nonatomic,strong)UIButton *searchMusic;
@property(nonatomic,strong)UIButton *historyMusic;

// 当前选中的要播放的数据
@property(nonatomic,strong)Musicdetail  *currenMusicdto;
@property(nonatomic,strong)XiaMiUtils   *xiamiutils;
@property(nonatomic,strong)UILabel      *titleLabel;
// 控件 背景图 显示歌手图片
@property(nonatomic,strong)UIImageView *bgimageview;
// 显示专辑图片
@property(nonatomic,strong)UIImageView *albumimageview;
// 显示在歌手图片上的毛玻璃效果图
@property(nonatomic,strong)DRNRealTimeBlurView  *fxblurview;
// 播放暂停按钮
@property(nonatomic,strong)UIButton    *playButton;
// 播放进度条
@property(nonatomic,strong)UISlider   *slider;
// 当前播放时间
@property(nonatomic,strong)UILabel    *currentPlayLabel;
// 这首歌的所有播放时间
@property(nonatomic,strong)UILabel    *finalPlayLabel;
// 存放slider 当前时间，最终时间的view
@property(nonatomic,strong)UIView     *sliderView;
// 监听进度定时器
@property (strong, nonatomic) NSTimer *currentTimeTimer;
// 使用DOUBan播放音乐
@property (strong, nonatomic) DOUAudioStreamer *audioStreamer;

// 专辑地址个毛玻璃效果上的点击手势
@property (strong, nonatomic)UITapGestureRecognizer  *albumimageviewTap;
@property (strong, nonatomic)UITapGestureRecognizer  *fxblurviewTap;
// 当前是否在执行动画中
@property(nonatomic,assign)BOOL isanimation;
//歌词是否全屏显示
@property(nonatomic,assign) BOOL   isfullscreen;



// 显示歌词的view
@property(nonatomic,strong)CQMusicLrcView *cqnusiclrc;






@end

@implementation CQMusicViewControoler

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        // 创建一个会话模式
        AVAudioSession *session = [AVAudioSession sharedInstance];
        // 设置会话模式
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        // 设置活动状态
        [session setActive:YES error:nil];
        self.isfullscreen = NO;
      
    }
    return self;
}

#pragma mark -生命周期方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 音乐频道左右按钮
    UIBarButtonItem *leftitem = [[UIBarButtonItem alloc] initWithCustomView:self.searchMusic];
    self.navigationItem.leftBarButtonItem = leftitem;
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithCustomView:self.historyMusic];
    self.navigationItem.rightBarButtonItem = rightitem;
    
   
    

}

#pragma mark -控件懒加载
-(CQMusicLrcView *)cqnusiclrc
{
    if(!_cqnusiclrc)
    {
        _cqnusiclrc = [[CQMusicLrcView alloc]initWithFrame:CGRectMake(0, self.sliderView.bottom, kScreenWidth, self.playButton.top-self.sliderView.bottom)];
        
        [self.fxblurview addSubview:_cqnusiclrc];
    }
    
    return _cqnusiclrc;
}
-(UITapGestureRecognizer *)albumimageviewTap
{
   if(!_albumimageviewTap)
   {
       _albumimageviewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickanimation)];
       _albumimageviewTap.numberOfTapsRequired = 1;
   }
    return _albumimageviewTap;
    
}
-(UITapGestureRecognizer *)fxblurviewTap
{
    if(!_fxblurviewTap)
    {
        _fxblurviewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickanimation)];
        _fxblurviewTap.numberOfTapsRequired = 1;
    }
    return _fxblurviewTap;
    
}
-(UIView *)sliderView
{
   if(!_sliderView)
   {
       _sliderView = [[UIView alloc]initWithFrame:CGRectMake(0,self.albumimageview.bottom, kScreenWidth,20)];
       
       [_sliderView addSubview:self.slider];
       [_sliderView addSubview:self.currentPlayLabel];
       [_sliderView addSubview:self.finalPlayLabel];
       _sliderView.backgroundColor = [UIColor colorWithRed:144 green:144 blue:144 alpha:0.01];

   }
    return _sliderView;
}
-(UILabel *)currentPlayLabel
{
   if(!_currentPlayLabel)
   {
       _currentPlayLabel =[CQYouListenToMeUtils creatLabelWith:CGRectMake(5, 7, 35, 13) :@"" :[UIFont systemFontOfSize:12] :[UIColor whiteColor] ];
   }
    return _currentPlayLabel;
}
-(UILabel *)finalPlayLabel
{
    if(!_finalPlayLabel)
    {
        _finalPlayLabel =[CQYouListenToMeUtils creatLabelWith:CGRectMake(kScreenWidth-40, 7, 35, 13) :@"" :[UIFont systemFontOfSize:12] :[UIColor whiteColor] ];
    }
    return _finalPlayLabel;
}
-(UISlider *)slider
{
  if(!_slider)
  {
      UIImage *centerimage = [UIImage imageNamed:@"player_menuvolume_btn_ctrl_white"];
      UIImage *rightimage = [UIImage imageNamed:@"player_progress_bg"];
      UIImage  *leftimage =  [UIImage imageNamed:@"player_progress_listen"];
      _slider = [[UISlider alloc]initWithFrame:CGRectMake(0, -10, kScreenWidth, 20)];
      _slider.userInteractionEnabled = YES;
      _slider.continuous = YES;
      _slider.backgroundColor = [UIColor clearColor];
      _slider.value = 0.0;
      _slider.minimumValue = 0.0;
      _slider.maximumValue = 1.0;

      [_slider setMinimumTrackImage:leftimage forState:UIControlStateNormal];
      [_slider setMaximumTrackImage:rightimage forState:UIControlStateNormal];

      [_slider setThumbImage:centerimage forState:UIControlStateHighlighted];
      [_slider setThumbImage:centerimage forState:UIControlStateNormal];
      
      [_slider addTarget:self action:@selector(updateThumb:) forControlEvents:UIControlEventValueChanged];
       [_slider addTarget:self action:@selector(updateend:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
  }
    return _slider;
}
-(UIButton *)historyMusic
{
    if(!_historyMusic)
    {
        _historyMusic = [UIButton buttonWithType:UIButtonTypeCustom];
        _historyMusic.frame = CGRectMake(.0f,.0f,40.0f,40.0f);
        _historyMusic.titleLabel.font = [UIFont systemFontOfSize:15];
        [_historyMusic setTitleColor:[UIColor colorWithHexString:@"#7352c4"] forState:UIControlStateNormal];
        [_historyMusic setTitleColor:[UIColor colorWithHexString:@"#7352c4"] forState:UIControlStateHighlighted];
        [_historyMusic setTitle:@"本地音乐" forState:UIControlStateNormal];
        [_historyMusic setTitle:@"本地音乐" forState:UIControlStateHighlighted];
        [_historyMusic addTarget:self action:@selector(historyMus:) forControlEvents:UIControlEventTouchUpInside];
        [_historyMusic sizeToFit];
        
    }
    return _historyMusic;
}
-(UIButton *)searchMusic
{
    if(!_searchMusic)
    {
        _searchMusic = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchMusic.frame = CGRectMake(.0f,.0f,40.0f,40.0f);
        [_searchMusic setImage:[UIImage imageNamed:@"my_music_icon_search_mix"] forState:UIControlStateNormal];
         [_searchMusic setImage:[UIImage imageNamed:@"my_music_icon_search_mix"] forState:UIControlStateHighlighted];
        [_searchMusic addTarget:self action:@selector(searchMusicOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_searchMusic sizeToFit];
        
    }
    return _searchMusic;
}
-(XiaMiUtils *)xiamiutils
{
   if(!_xiamiutils)
   {
       _xiamiutils = [[XiaMiUtils alloc]init];
       _xiamiutils.delegate = self;
   }
    return _xiamiutils;
}
-(UILabel *)titleLabel
{
   if(!_titleLabel)
   {
       _titleLabel = [CQYouListenToMeUtils creatLabelWith:CGRectMake(0, 0, 0, 0) :@"" :CQ_COMMON_FONT_26PX :UIColorFromRGB(0x7352c4) ];
       _titleLabel.textAlignment = NSTextAlignmentCenter;
   }
    return _titleLabel;
}
-(UIImageView *)bgimageview
{
   if(!_bgimageview)
   {
       _bgimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight)];
       _bgimageview.userInteractionEnabled = YES;
   }
    [self.view addSubview:_bgimageview];
    return _bgimageview;
}
-(UIImageView *)albumimageview
{
   if(!_albumimageview)
   {
       _albumimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenWidth)];
       _albumimageview.userInteractionEnabled = YES;

   }
    return _albumimageview;
}

-(DRNRealTimeBlurView *)fxblurview
{
   if(!_fxblurview)
   {
       _fxblurview = [[DRNRealTimeBlurView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight)];
       _fxblurview.userInteractionEnabled = YES;
   }
    [self.bgimageview addSubview:_fxblurview];

    return _fxblurview;
}
-(UIButton *)playButton
{
   if(!_playButton)
   {
       _playButton = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-50)/2, self.fxblurview.height-100, 50, 50)];
       [_playButton setImage:[UIImage imageNamed:@"player_btn_start_normal"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"player_btn_start_select"] forState:UIControlStateHighlighted];
       _playButton.backgroundColor = [UIColor clearColor];
       [_playButton addTarget:self action:@selector(MusicControl) forControlEvents:UIControlEventTouchUpInside];

   }
    return _playButton;
}
#pragma mark - 监听定时器
- (void)addTimer
{
    self.currentTimeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateDuration) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.currentTimeTimer forMode:NSRunLoopCommonModes];
}
#pragma mark -  停止计时器
- (void)removeTimer
{
    [self.currentTimeTimer invalidate];
    self.currentTimeTimer = nil;
}

#pragma mark - 跳转到选择音乐界面
-(void)searchMusicOnClick:(UIButton *)sender
{
     CQMusciSearchViewController *cltr=[[CQMusciSearchViewController alloc]init];
     cltr.delegate = self;
    [self presentViewController:cltr animated:YES completion:nil];
}
#pragma mark - 跳转到历史音乐界面
-(void)historyMus:(UIButton *)sender
{
    NSLog(@"跳转到历史音乐界面");
}
#pragma mark - 获取到歌曲详情返回
-(void)getMusicDto:(Musicdetail *)Musicdetail
{
    self.currenMusicdto = Musicdetail;
    // 专辑地址 歌手地址转换
    [self.xiamiutils getlogo:self.currenMusicdto.artist_logo size:330 URLType:@"artist_logo"];
    [self.xiamiutils getlogo:self.currenMusicdto.album_logo size:330 URLType:@"album_logo"];
    
    
}

#pragma mark - 选择音乐界面返回回调
-(void)getChoiceOfMusic:(Musicdetail *)musicdto
{
    self.currenMusicdto = musicdto;
    
    // 设置演唱者和歌曲名位title
    NSString *str =[NSString stringWithFormat:@"%@•%@",musicdto.singers,musicdto.song_name ];
    self.titleLabel.text = str;
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView  = self.titleLabel;
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    [dict setObject:musicdto.song_id  forKey:@"song_id"];
    [self.xiamiutils requestWithMethod:@"song.detail" params:dict];
    
    NSLog(@"选择歌曲成功");
}

#pragma mark - 转换专辑地址或者歌手地址返回回调
-(void)getURLConvert:(NSString *)logo URLType:(NSString *)type;
{
   if([type isEqualToString:@"artist_logo"])
   {
       self.currenMusicdto.artist_logo = logo;
   
       
   }else{
       self.currenMusicdto.album_logo = logo;
    
   }
    
    [self showMusicPlayView];
}

#pragma mark - 显示歌曲播放界面，并且开始播放歌曲，加载歌词
-(void)showMusicPlayView
{
    // 设置背景图为专辑图
    NSURL *artistimageurl = [NSURL URLWithString:self.currenMusicdto.album_logo];
    [self.bgimageview sd_setImageWithURL:artistimageurl];
    // 设置毛玻璃效果图
    [self.bgimageview addSubview:self.fxblurview];
    
    // 设置专辑背景图
    NSURL *albumimageurl = [NSURL URLWithString:self.currenMusicdto.album_logo];
    [self.albumimageview sd_setImageWithURL:albumimageurl];
    
    // 在毛玻璃上添加专辑图背景
    [self.fxblurview addSubview:self.albumimageview];
    // 添加播放滑动条
    [self.fxblurview addSubview:self.sliderView];
    // 添加控制按钮
    [self.fxblurview addSubview:self.playButton];
    
    YYFPSLabel *fps = [[YYFPSLabel alloc]init];
    fps.left =  30;
    fps.centerY= self.playButton.centerY;
    [self.fxblurview addSubview:fps];
    
    
    // 添加手势动画
    [self.fxblurview addGestureRecognizer:self.fxblurviewTap];
    [self.albumimageview addGestureRecognizer:self.albumimageviewTap];
    // 加载歌词
    if(self.isfullscreen)
    {// 歌词全屏
      self.cqnusiclrc.frame =CGRectMake(0,0, kScreenWidth, self.sliderView.top);
    }else{
     // 歌词没有全屏
        self.cqnusiclrc.frame =CGRectMake(0, self.sliderView.bottom, kScreenWidth, self.playButton.top-self.sliderView.bottom);
    }
    self.cqnusiclrc.MusiclrUrl = self.currenMusicdto.lyric;
    self.cqnusiclrc.lyric_type = self.currenMusicdto.lyric_type;
    self.cqnusiclrc.isfullscreen = self.isfullscreen;
    
    [self resetAudioStreamer];
    [self startAudioStreamer];
    
}
#pragma mark - 播放按钮的点击后的方法
-(void)MusicControl
{
    if(self.audioStreamer.status == DOUAudioStreamerPlaying)
    {
        [self.audioStreamer pause];
        [self.playButton setImage:[UIImage imageNamed:@"player_btn_start_normal"] forState:UIControlStateNormal];
        [self.playButton setImage:[UIImage imageNamed:@"player_btn_start_select"] forState:UIControlStateHighlighted];
    }else if(self.audioStreamer.status == DOUAudioStreamerPaused){
    
        [self.audioStreamer play];
        [self.playButton setImage:[UIImage imageNamed:@"player_btn_stop_normal"]  forState:UIControlStateNormal];
        [self.playButton setImage:[UIImage imageNamed:@"player_btn_stop_select"] forState:UIControlStateHighlighted];
    }else if(self.audioStreamer.status == DOUAudioStreamerFinished)
    {// 如果播放完毕   在点击按钮 重新播放
        [self startAudioStreamer];
        self.audioStreamer.currentTime = 0.0;
        [self.playButton setImage:[UIImage imageNamed:@"player_btn_stop_normal"]  forState:UIControlStateNormal];
        [self.playButton setImage:[UIImage imageNamed:@"player_btn_stop_select"] forState:UIControlStateHighlighted];
    }
}

#pragma mark - 开始播放方法
- (void)startAudioStreamer
{
    // 1.开始播放
    self.audioStreamer = [DOUAudioStreamer streamerWithAudioFile:self.currenMusicdto];
    
    [self.audioStreamer addObserver:self forKeyPath:CQStatusProp options:NSKeyValueObservingOptionNew context:nil];

    
    [self.audioStreamer play];
    
    [self.playButton setImage:[UIImage imageNamed:@"player_btn_stop_normal"]  forState:UIControlStateNormal];
    [self.playButton setImage:[UIImage imageNamed:@"player_btn_stop_select"] forState:UIControlStateHighlighted];
    
    // 2.开始定时器
    [self addTimer];
}

#pragma mark - 播放器停止
- (void)resetAudioStreamer
{
    // 1.停止播放
    [self.audioStreamer pause];
    [self.audioStreamer removeObserver:self forKeyPath:CQStatusProp];

    self.audioStreamer = nil;
    
    // 2.停止定时器
    [self removeTimer];
    
    // 3.更新状态
    [self updateDuration];
}
#pragma mark - KVO监听播放状态改变的时候
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([keyPath isEqualToString:CQStatusProp]) {
            if(self.audioStreamer.status == DOUAudioStreamerFinished)
            {
                // 播放完毕后停止  重新播放
                [self resetAudioStreamer];
                [self.playButton setImage:[UIImage imageNamed:@"player_btn_start_normal"] forState:UIControlStateNormal];
                [self.playButton setImage:[UIImage imageNamed:@"player_btn_start_select"] forState:UIControlStateHighlighted];
               
                [self startAudioStreamer];
                [self.playButton setImage:[UIImage imageNamed:@"player_btn_stop_normal"]  forState:UIControlStateNormal];
                [self.playButton setImage:[UIImage imageNamed:@"player_btn_stop_select"] forState:UIControlStateHighlighted];
            }
        }
    });
}

#pragma  mark - 定时器调用方法，监听播放进度
-(void)updateDuration
{
   self.slider.value = self.audioStreamer.currentTime / self.audioStreamer.duration;
    self.currentPlayLabel.text = [CQYouListenToMeUtils timeIntervalConversionString:self.audioStreamer.currentTime];
    self.finalPlayLabel.text = [CQYouListenToMeUtils timeIntervalConversionString:self.audioStreamer.duration];
    // 更新歌词进度
    self.cqnusiclrc.currentTime = self.audioStreamer.currentTime;
}

#pragma mark - 歌词显示一半 全部显示
-(void)onClickanimation
{
    // 如果动画未执行完毕 返回
    if(self.isanimation) return;
  self.sliderView.hidden = YES;
    self.isanimation = YES;
  if(self.albumimageview.hidden)
  {
  
      self.albumimageview.hidden = NO;
      self.albumimageview.frame =CGRectMake(50,50, kScreenWidth-100, kScreenWidth-100);
      self.albumimageview.alpha = 0;
      self.cqnusiclrc.frame =CGRectMake(0,0, kScreenWidth, self.playButton.top - 20);
      self.cqnusiclrc.nolrcLable.frame = CGRectMake(self.cqnusiclrc.left, (self.cqnusiclrc.height-30)/2, self.cqnusiclrc.width, 30);
      [UIView animateWithDuration:0.9 animations:^{
          
          self.albumimageview.frame =CGRectMake(0,0, kScreenWidth, kScreenWidth);
          self.albumimageview.alpha = 1;
          self.sliderView.frame = CGRectMake(0,self.albumimageview.bottom, kScreenWidth,20);

          
     
      }completion:^(BOOL finished) {
          
self.cqnusiclrc.frame = CGRectMake(0, self.sliderView.bottom, kScreenWidth, self.playButton.top-self.sliderView.bottom);
self.cqnusiclrc.nolrcLable.frame = CGRectMake(self.cqnusiclrc.left, (self.cqnusiclrc.height-30)/2, self.cqnusiclrc.width, 30);
          self.sliderView.hidden = NO;
          self.isfullscreen = NO;
          self.cqnusiclrc.isfullscreen = NO;
          
      }];

  }else{
      
      self.albumimageview.frame =CGRectMake(0,0, kScreenWidth, kScreenWidth);
      self.albumimageview.alpha = 1;
      self.cqnusiclrc.frame = CGRectMake(0, self.sliderView.bottom, kScreenWidth, self.playButton.top-self.sliderView.bottom);
     self.cqnusiclrc.nolrcLable.frame = CGRectMake(self.cqnusiclrc.left, (self.cqnusiclrc.height-30)/2, self.cqnusiclrc.width, 30);
      
    [UIView animateWithDuration:0.9 animations:^{
       
       self.albumimageview.frame =CGRectMake(50,50, kScreenWidth-100, kScreenWidth-100);
       self.albumimageview.alpha = 0;
        self.sliderView.frame = CGRectMake(0,self.playButton.top - 20, kScreenWidth, 20);

       self.cqnusiclrc.frame =CGRectMake(0,0, kScreenWidth, self.playButton.top - 20);
      self.cqnusiclrc.nolrcLable.frame = CGRectMake(self.cqnusiclrc.left, (self.cqnusiclrc.height-30)/2, self.cqnusiclrc.width, 30);
    }completion:^(BOOL finished) {
   
        self.sliderView.hidden = NO;
        self.albumimageview.hidden = YES;
        self.isfullscreen = YES;
        self.cqnusiclrc.isfullscreen = YES;
    }];
  }
    self.isanimation = NO;
}
#pragma mark - 摇一摇导航条 TabBar 显示或者隐藏
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
    // 不是摇一摇运动事件
    if (motion != UIEventSubtypeMotionShake) return;
    
    if(self.navigationController.navigationBar.hidden)
    {
        self.navigationController.navigationBar.hidden = NO;
        self.tabBarController.tabBar.hidden = NO;
        
    }else{
        self.navigationController.navigationBar.hidden = YES;
        self.tabBarController.tabBar.hidden = YES;
        
    }
}
#pragma mark - 进度条的拖动过程中
-(void)updateThumb:(UISlider *)slider
{
     NSTimeInterval currentTime =   self.audioStreamer.duration  *  slider.value;
      self.currentPlayLabel.text = [CQYouListenToMeUtils timeIntervalConversionString:currentTime];
    self.cqnusiclrc.currentTime =currentTime;
}
#pragma mark - 进度条的拖动结束
-(void)updateend:(UISlider *)slider
{
    NSTimeInterval currentTime =   self.audioStreamer.duration  *  slider.value;
    self.cqnusiclrc.currentTime =currentTime;
    self.audioStreamer.currentTime = currentTime;
}

@end
