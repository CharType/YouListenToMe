//
//  CQVideoViewControoler.m
//  YouListenToMe
//
//  Created by 程倩 on 15/11/21.
//  Copyright © 2015年 CQ. All rights reserved.
//

#import "CQVideoViewControoler.h"

@interface CQVideoViewControoler ()

@property(nonatomic,strong)UISegmentedControl *cqSegmented;

@end

@implementation CQVideoViewControoler

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.titleView = self.cqSegmented;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(UISegmentedControl *)cqSegmented
{
  if(!_cqSegmented)
  {
      _cqSegmented = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"在线搜索", @"本地视频", nil]];
      _cqSegmented.frame = CGRectMake(0, 0 , kScreenWidth-160, 30);
            _cqSegmented.layer.cornerRadius = 15;
      _cqSegmented.layer.masksToBounds = YES;
      _cqSegmented.layer.borderWidth = 1;
      _cqSegmented.layer.borderColor = [UIColor colorWithHexString:@"#7352c4"].CGColor;
      _cqSegmented.userInteractionEnabled = YES;
      _cqSegmented.selectedSegmentIndex = 0;
      [_cqSegmented setTintColor:[UIColor colorWithHexString:@"#7352c4"]];
      [_cqSegmented addTarget:self action:@selector(cqSegmentSelected:) forControlEvents:UIControlEventValueChanged];
      
     
  }
    return _cqSegmented;
}

-(void)cqSegmentSelected:(UISegmentedControl *)cqSegmented
{
   
}

#pragma mark - 取消摇一摇
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    return;
}
@end
