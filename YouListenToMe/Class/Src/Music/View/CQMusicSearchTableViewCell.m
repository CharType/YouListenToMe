//
//  CQMusicSearchTableViewCell.m
//  YouListenToMe
//
//  Created by 程倩 on 15/11/27.
//  Copyright (c) 2015年 CQ. All rights reserved.
//

#import "CQMusicSearchTableViewCell.h"
#import "Musicdetail.h"
#import "CQYouListenToMeUtils.h"
#import "UIImageView+WebCache.h"

@implementation CQMusicSearchTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle           = UITableViewCellSelectionStyleNone;
        self.backgroundColor          = [UIColor colorWithHexString:@"#f2f2f2"];
        
        _contentsView                 = [[UIView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth-20, 70)];
        _contentsView.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_contentsView addGestureRecognizer:tap];
        
        [self addSubview:_contentsView];
        
        _musicIcon                  = [[UIImageView alloc] initWithFrame:CGRectMake(10,15, 40, 40)];

        [_contentsView addSubview:_musicIcon];
        
        _musicName = [CQYouListenToMeUtils creatLabelWith:CGRectMake(self.musicIcon.right+13, self.musicIcon.top, kScreenWidth-(self.musicIcon.right+33), 20) :@"" :CQ_COMMON_FONT_30PX :UIColorFromRGB(0x353d44) ];
        [_contentsView addSubview:_musicName];
        
        
        
        _musicDesc = [CQYouListenToMeUtils creatLabelWith:CGRectMake(self.musicIcon.right+13, _musicName.bottom, kScreenWidth-(self.musicIcon.right+33), 20) :@"" :CQ_COMMON_FONT_26PX :UIColorFromRGB(0xcccccc)];
        [_contentsView addSubview:_musicDesc];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 69.5, kScreenWidth, 0.5)];
        line.backgroundColor = UIColorFromRGB(0xf2f2f2);
        [_contentsView addSubview:line];
    }
    return self;
}

-(void)setMusicDTO:(Musicdetail *)MusicDTO{
    _MusicDTO = MusicDTO;
    if (!IsStrEmpty(_MusicDTO.album_logo)) {
        [self.musicIcon sd_setImageWithURL:[NSURL URLWithString:_MusicDTO.album_logo]];
    }
    else{
        self.musicIcon.image = [UIImage imageNamed:@"SNPM_DaoDao_SearchChannel_Cell_Icon"];
    }
    self.musicName.text = _MusicDTO.song_name;
    self.musicDesc.text = [NSString stringWithFormat:@"%@ • %@",_MusicDTO.singers,_MusicDTO.album_name];
    
    
}
- (void)tap:(UITapGestureRecognizer *)tap{
    if (self.cellDidSelecteBlock){
        self.cellDidSelecteBlock();
    }
}


@end
