//
//  CQLrcCellTableViewCell.h
//  YouListenToMe
//
//  Created by 程倩 on 15/12/13.
//  Copyright © 2015年 CQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQLrcLine.h"
@interface CQLrcCell : UITableViewCell



+ (instancetype)cellWithTableView:(UITableView *)tableView;


@property (nonatomic, strong) CQLrcLine *lrcLine;


@end
