//
//  CQMusicSrarchChannelView.h
//  YouListenToMe
//
//  Created by 程倩 on 15/11/27.
//  Copyright (c) 2015年 CQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQMusicSearchChannelTableView.h"


@protocol CQMusicSrarchChannelViewdelegate <NSObject>

-(void)getChoiceOfMusic:(Musicdetail *)musicdto;
//搜索框键盘弹回
-(void)resignToFirstResponder;


@end

@interface CQMusicSrarchChannelView : UIView

@property (nonatomic, strong) CQMusicSearchChannelTableView *tableView;

/** 搜索的数据 */
@property (nonatomic,strong) NSMutableArray *dataArray;
/** 搜索的关键字 */
@property (nonatomic,copy) NSString *keyWord;

// 是否还有下一页
@property (nonatomic,assign) BOOL isHaveMore;
// 页码  默认1
@property (nonatomic,assign) NSInteger pageIndex;
// 每页的行数，默认20
@property (nonatomic,assign) NSInteger pageSize;

@property (nonatomic, weak)   UINavigationController      *parentNavController;



@property(nonatomic,weak)id<CQMusicSrarchChannelViewdelegate> Musicdelegate;


@end
