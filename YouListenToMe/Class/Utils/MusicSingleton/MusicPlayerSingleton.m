//
//  SNPMDaoDaoMusicPlayerSingleton.m
//  SuningEBuy
//
//  Created by 李尧伟 on 15/11/23.
//  Copyright © 2015年 Suning. All rights reserved.
//

#import "MusicPlayerSingleton.h"

@implementation MusicPlayerSingleton




SingleTonM(MusicPlayerSingleton);



-(AFSoundPlayback *)playBack{
//    if(self.dto != nil)
//    {
        if (! _playBack)  {
            
           
            
//           if(![self.musicdetail.listen_file hasPrefix:@"http"])
//           {
//                NSString *Path = [NSString stringWithFormat:@"%@/%@.mp3",[SNPMDaoDaoUtils getaudioFilePath],self.dto.musicdto.song_id];
//                _musicItem = [[AFSoundItem alloc]initWithLocalResource:nil atPath:Path];
//           
//           }else{
            _musicItem = [[AFSoundItem alloc]initWithStreamingURL:[NSURL URLWithString:self.musicdetail.listen_file]];
//           }
            
           
            
            
            _playBack = [[AFSoundPlayback alloc]initWithItem:self.musicItem];
            
//            return _playBack;
        }
//        else{
            return _playBack;
//        }


//        
//    }else{
//        return nil;
//    }

}

-(BOOL)PlayMusic
{
    if(self.playBack.status == AFSoundStatusPlaying)
    {
        return YES;
    }else{
        return  NO;
    }
}





@end
