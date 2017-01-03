//
//  CQNavigationController.m
//  YouListenToMe
//
//  Created by 程倩 on 15/11/23.
//  Copyright (c) 2015年 CQ. All rights reserved.
//

#import "CQNavigationController.h"

@interface CQNavigationController ()

@end

@implementation CQNavigationController


+ (void)initialize
{
    
    // 通过外观对象设置导航条的背景颜色
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    [navBar setBackgroundColor:[UIColor colorWithHexString:@"#9B60F4"]];
    
//    [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置导航控制器的标题颜色
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[NSForegroundColorAttributeName] = [UIColor blackColor];
    md[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [navBar setTitleTextAttributes:md];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (id)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
   
        self.navigationBar.backgroundColor = [UIColor colorWithHexString:@"7352c4"];
    
    }
    return self;
}


@end
