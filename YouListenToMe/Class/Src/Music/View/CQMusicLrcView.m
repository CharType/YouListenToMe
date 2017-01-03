//
//  CQMusicLrcView.m
//  YouListenToMe
//
//  Created by 程倩 on 15/12/12.
//  Copyright © 2015年 CQ. All rights reserved.
//

#import "CQMusicLrcView.h"
#import "CQLrcLine.h"
#import "CQLrcCell.h"
#import "UIView+CQFoundation.h"

@interface CQMusicLrcView()<UITableViewDataSource,UITableViewDelegate>

// 显示的tableview
@property (nonatomic, weak) UITableView *tableView;
// 存放歌词的数组
@property (nonatomic, strong) NSMutableArray *lrcLines;
// 当前播放行数的下标
@property (nonatomic, assign) int currentIndex;

 @end

@implementation CQMusicLrcView

#pragma mark - 初始化
- (NSMutableArray *)lrcLines
{
    if (_lrcLines == nil) {
        self.lrcLines = [NSMutableArray array];
    }
    return _lrcLines;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        [self setup];
    }
    return self;
}
-(void)setIsfullscreen:(BOOL)isfullscreen
{
    _isfullscreen = isfullscreen;
  
       self.tableView.frame = CGRectMake(0, 0, self.width, self.height);
    
   
}

-(UILabel *)nolrcLable
{
  if(!_nolrcLable)
  {
      _nolrcLable = [[UILabel alloc]initWithFrame:CGRectMake(self.left, (self.height-30)/2, self.width, 30)];
      _nolrcLable.backgroundColor = [UIColor clearColor];
       _nolrcLable.font = [UIFont boldSystemFontOfSize:18];
      _nolrcLable.textAlignment = NSTextAlignmentCenter;
      _nolrcLable.textColor = [UIColor whiteColor];
      [self addSubview:_nolrcLable];
  }
    
    return _nolrcLable;
}

- (void)setup
{
    // 1.添加表格控件
    UITableView *tableView = [[UITableView alloc] init];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.tableView = tableView;
}
#pragma mark - 设置歌词后
-(void)setMusiclrUrl:(NSString *)MusiclrUrl
{
    _MusiclrUrl = [MusiclrUrl copy];
    
    NSURL *url = [NSURL URLWithString:_MusiclrUrl];
    NSString *musiclrc = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    // 0.清空之前的歌词数据
    [self.lrcLines removeAllObjects];
    
    // 没有找到歌词
    if(IsStrEmpty(musiclrc))
    {
        self.nolrcLable.hidden = NO;
        self.nolrcLable.text = @"没有找到歌词";
        self.tableView.hidden = YES;
        
    }else{
        
        
        self.nolrcLable.hidden = YES;
        self.tableView.hidden = NO;
        // 拆分歌词
        NSArray *lrcCmps = [musiclrc componentsSeparatedByString:@"\n"];
        
        
        
        // 2.输出每一行歌词
        for (NSString *lrcCmp in lrcCmps) {
            CQLrcLine *line = [[CQLrcLine alloc] init];
            [self.lrcLines addObject:line];
            if (![lrcCmp hasPrefix:@"["]) continue;
            
            // 如果是歌词的头部信息（歌名、歌手、专辑）
            if ([lrcCmp hasPrefix:@"[ti:"] || [lrcCmp hasPrefix:@"[ar:"] || [lrcCmp hasPrefix:@"[al:"] ) {
                NSString *word = [[lrcCmp componentsSeparatedByString:@":"] lastObject];
                line.word = [word substringToIndex:word.length - 1];
            } else { // 非头部信息
                NSArray *array = [lrcCmp componentsSeparatedByString:@"]"];
                line.time = [[array firstObject] substringFromIndex:1];
                line.word = [array lastObject];
                if([self.lyric_type isEqualToString:@"3"])
                {//3为trc
                    NSMutableString *mutablestring = [[NSMutableString alloc]init];
                    NSString *str  =  line.word;
                    NSArray *strarray = [str componentsSeparatedByString:@">"];
                    
                    for(int i=1;i<=strarray.count-1;i++)
                    {
                        
                        NSString *s = [strarray[i] substringWithRange:NSMakeRange(0, 1)];
                        [mutablestring appendString:s];
                    }
                    line.word = [mutablestring copy];
                    
                }
            }
            
        }
        
        // 3.刷新表格
        [self.tableView reloadData];
    }
 
}
#pragma mark - 设置当前播放时间后
-(void)setCurrentTime:(NSTimeInterval)currentTime
{
    if (currentTime < _currentTime) {
        self.currentIndex = -1;
    }
    
     _currentTime = currentTime;
    
    int minute = currentTime / 60;
    int second = (int)currentTime % 60;
    int msecond = (currentTime - (int)currentTime) * 100;
    NSString *currentTimeStr = [NSString stringWithFormat:@"%02d:%02d.%02d", minute, second, msecond];
    
    int count = self.lrcLines.count;
    for (int idx = self.currentIndex + 1; idx<count; idx++) {
        CQLrcLine *currentLine = self.lrcLines[idx];
        // 当前模型的时间
        NSString *currentLineTime = currentLine.time;
        // 下一个模型的时间
        NSString *nextLineTime = nil;
        NSUInteger nextIdx = idx + 1;
        if (nextIdx < self.lrcLines.count) {
            CQLrcLine *nextLine = self.lrcLines[nextIdx];
            nextLineTime = nextLine.time;
        }
        
        // 判断是否为正在播放的歌词
        if (
            ([currentTimeStr compare:currentLineTime] != NSOrderedAscending)
            && ([currentTimeStr compare:nextLineTime] == NSOrderedAscending)
            && self.currentIndex != idx) {
            // 刷新tableView
            NSArray *reloadRows = @[
                                    [NSIndexPath indexPathForRow:self.currentIndex inSection:0],
                                    [NSIndexPath indexPathForRow:idx inSection:0]
                                    ];
            self.currentIndex = idx;
            [self.tableView reloadRowsAtIndexPaths:reloadRows withRowAnimation:UITableViewRowAnimationNone];
            
            
               // 滚动到对应的行
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
                [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];

          
            
           
        }
    }

}
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lrcLines.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CQLrcCell *cell = [CQLrcCell cellWithTableView:tableView];
    cell.lrcLine = self.lrcLines[indexPath.row];
    
    if (self.currentIndex == indexPath.row) {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
//          cell.textLabel.textColor = [UIColor greenColor];
    } else {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
//        cell.textLabel.textColor = [UIColor redColor];
    }
    
//     cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    
  
    return cell;
}
@end
