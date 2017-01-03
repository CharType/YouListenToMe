//
//  CQMusicSrarchChannelView.m
//  YouListenToMe
//
//  Created by 程倩 on 15/11/27.
//  Copyright (c) 2015年 CQ. All rights reserved.
//

#import "CQMusicSrarchChannelView.h"
#import "XiaMiUtils.h"
#import "Musicdetail.h"
#import "CQMusicSearchChannelTableView.h"
#import "CQMusicSearchTableViewCell.h"
#import "MJRefresh.h"

@interface CQMusicSrarchChannelView()<UITableViewDelegate,UITableViewDataSource,XiaMiUtilsdelegate,CQMusicSearchChannelTableViewdelegate>


@property(nonatomic,strong)XiaMiUtils *xiamiutils;
@end
@implementation CQMusicSrarchChannelView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpWithPageType];
    }
    return self;
}

-(void)setUpWithPageType
{
    CGSize size = self.frame.size;
    _tableView = [[CQMusicSearchChannelTableView alloc]initWithFrame:CGRectMake(.0f,.0f,size.width,size.height) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.Musicdelegate = self;
    self.pageSize        = 20;
    self.pageIndex = 1;
    self.isHaveMore = YES;
    
    [self addSubview:_tableView];
    self.dataArray = [NSMutableArray array];
    
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(refreshLoad)];
    
}


// 刷新表格
- (void)refreshLoad
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.keyWord forKey:@"key"];
    NSString *pageindex = [NSString stringWithFormat:@"%ld",++self.pageIndex];
    [dict setObject:pageindex forKey:@"page"];
    
    [self.xiamiutils requestWithMethod:@"search.songs" params:dict];
}
#pragma mark 虾米音乐上拉请求更多数据回调
- (void) getMusicSerchResult:(NSArray *)array ismore:(BOOL)more
{
    if(array.count>0)
    {
        for(int i=0;i<array.count;i++)
        {
            NSDictionary *dict = [array safeObjectAtIndex:i];
            Musicdetail *dto=[Musicdetail parser:dict];
            [self.dataArray addObject:dto];
        }
        self.isHaveMore = more;
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
        
        if(!more)
        {
            self.tableView.footer.hidden = YES;

        }
    
    }
}


#pragma mark - 设置数据的时候刷新表格
-(void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = [NSMutableArray arrayWithArray:dataArray];
    
    [self.tableView reloadData];
}


#pragma mark - XiaMiUtils懒加载
-(XiaMiUtils *)xiamiutils
{
    if(!_xiamiutils)
    {
        _xiamiutils =[[XiaMiUtils alloc]init];
        _xiamiutils.delegate = self;
    }
    return _xiamiutils;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"SNPMChannelMusicCellIdentify";
    CQMusicSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (nil == cell) {
        cell = [[CQMusicSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:identify];
        cell.backgroundColor = [UIColor clearColor];
    }
    if (self.dataArray != nil){
        cell.MusicDTO =[self.dataArray safeObjectAtIndex:indexPath.row];
    }
    
    __weak typeof(self) weakSelf = self;
    cell.cellDidSelecteBlock = ^{
        Musicdetail *musicDto =[self.dataArray safeObjectAtIndex:indexPath.row];
        if([weakSelf.Musicdelegate respondsToSelector:@selector(getChoiceOfMusic:)])
        {
            [weakSelf.Musicdelegate getChoiceOfMusic:musicDto];
        }
        
    };
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


#pragma mark - 滚动的时候缩回键盘
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([self.Musicdelegate respondsToSelector:@selector(resignToFirstResponder)])
    {
        [self.Musicdelegate resignToFirstResponder];
    }
    
}
@end
