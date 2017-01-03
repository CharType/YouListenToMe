//
//  CQMainTabBarController.m
//  YouListenToMe
//
//  Created by 程倩 on 15/11/23.
//  Copyright (c) 2015年 CQ. All rights reserved.
//

#import "CQMainTabBarController.h"
#import "GSAnimation.h"





@interface CQMainTabBarController ()

@end

@implementation CQMainTabBarController





- (void)viewDidLoad {
    [super viewDidLoad];
//    NSArray *array  =  [NSArray arrayWithObjects:@"音乐",@"视频",@"直播",@"设置", nil];
    NSArray *imageNames = [NSArray arrayWithObjects:@"TabBar_Music_default",@"TabBar_Video_default",@"TabBar_ DBS_default",@"TabBar_Settings_default", nil];
    NSArray *seleictimageNames =[NSArray arrayWithObjects:@"TabBar_Music_select",@"TabBar_Video_select",@"TabBar_ DBS_select",@"TabBar_Settings_select", nil];
    for(int i=0;i<self.tabBar.items.count;i++)
    {
        UITabBarItem *item =self.tabBar.items[i];
        UIImage *image = [UIImage imageNamed:imageNames[i]];
        UIImage *image_select = [UIImage imageNamed:seleictimageNames[i]];
        // 设置选中后  选中前的图片
        
        item.selectedImage = [image_select imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        // 设置选中后  选中前的字体颜色
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#7352c4"],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        
    }
}



@end
