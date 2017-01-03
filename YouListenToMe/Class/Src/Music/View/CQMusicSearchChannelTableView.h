//
//  CQMusicSearchChannelTableView.h
//  YouListenToMe
//
//  Created by 程倩 on 15/11/26.
//  Copyright (c) 2015年 CQ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  Musicdetail;

@protocol CQMusicSearchChannelTableViewdelegate <NSObject>

-(void)getChoiceOfMusic:(Musicdetail *)musicdto;
//搜索框键盘弹回
-(void)resignToFirstResponder;


@end

@interface CQMusicSearchChannelTableView : UITableView



@property(nonatomic,weak)id<CQMusicSearchChannelTableViewdelegate> Musicdelegate;





@end
