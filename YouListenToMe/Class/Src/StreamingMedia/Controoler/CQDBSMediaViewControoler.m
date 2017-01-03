//
//  CQStreamingMediaViewControoler.m
//  YouListenToMe
//
//  Created by 程倩 on 15/11/21.
//  Copyright © 2015年 CQ. All rights reserved.
//

#import "CQDBSMediaViewControoler.h"

@interface CQDBSMediaViewControoler ()

@end

@implementation CQDBSMediaViewControoler

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 取消摇一摇
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    return;
}
@end
