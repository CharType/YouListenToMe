//
//  Musicdetail.m
//  虾米音乐歌曲详情
//
//  Created by 程倩 on 15/11/5.
//  Copyright (c) 2015年 CQ. All rights reserved.
//

#import "Musicdetail.h"
#import "XiamiRequest.h"

@implementation Musicdetail

+ (Musicdetail *)parser:(NSDictionary *)paras {
    Musicdetail *dto = nil;
    if (nil != paras
        && [paras isKindOfClass:[NSDictionary class]]) {
        dto = [[Musicdetail alloc] init];
        dto.song_id          = EncodeStringFromDic(paras, @"song_id");
        dto.song_name        = EncodeStringFromDic(paras, @"song_name");
        dto.artist_id        = EncodeStringFromDic(paras, @"artist_id");
        dto.artist_name      = EncodeStringFromDic(paras, @"artist_name");
        dto.artist_logo      = EncodeStringFromDic(paras, @"artist_logo");
        dto.singers          = EncodeStringFromDic(paras, @"singers");
        dto.album_id         = EncodeStringFromDic(paras, @"album_id");
        dto.album_name       = EncodeStringFromDic(paras, @"album_name");
        dto.album_logo       = EncodeStringFromDic(paras, @"album_logo");
        dto.length           =EncodeStringFromDic(paras, @"length");
        dto.track            =EncodeStringFromDic(paras, @"track");
        dto.cd_serial        =EncodeStringFromDic(paras, @"cd_serial");
        dto.music_type       =EncodeStringFromDic(paras, @"music_type");
        dto.listen_file      = [XiamiRequest decryptWithContent:EncodeStringFromDic(paras, @"listen_file")];
        dto.quality           = EncodeStringFromDic(paras, @"quality");
        dto.lyric_type        = EncodeStringFromDic(paras, @"lyric_type");
        dto.lyric            =  EncodeStringFromDic(paras, @"lyric");
        
    }
    return dto;
}

-(void)setListen_file:(NSString *)listen_file
{
    _listen_file = listen_file;
    NSURL *url = [NSURL URLWithString:listen_file];
    self.audioFileURL = url;
}

@end
