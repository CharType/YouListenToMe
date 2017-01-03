//
//  CQMusciSearchViewController.h
//  YouListenToMe
//
//  Created by 程倩 on 15/11/26.
//  Copyright (c) 2015年 CQ. All rights reserved.
//音乐搜索频道

#import <UIKit/UIKit.h>
@class Musicdetail;

@protocol CQMusciSearchViewControllerdelegate <NSObject>

-(void)getChoiceOfMusic:(Musicdetail *)musicdto;

@end

@interface CQMusciSearchViewController : UIViewController

@property(nonatomic,weak)id<CQMusciSearchViewControllerdelegate> delegate;

@end
