//
//  XiaMiUtils.m
//  虾米音乐Demo
//
//  Created by 程倩 on 15/10/29.
//  Copyright (c) 2015年 CQ. All rights reserved.
//

#import "XiaMiUtils.h"
#import "Musicdetail.h"

@implementation XiaMiUtils

- (void)requestWithMethod:(NSString*)method params:(NSDictionary *)params
{
    
    dispatch_async(dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, DISPATCH_QUEUE_CONCURRENT), ^{
        NSArray *array = nil;

        NSString *jsonstring = [XiamiRequest requestWithMethod:method params:params];
        NSData *data =  [jsonstring dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsondict = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:nil];
        if([method isEqualToString:@"search.songs"])
        {
            //搜索歌曲信息
          
            NSDictionary *dict = EncodeDicFromDic(jsondict, @"data");
            
            array = EncodeArrayFromDic(dict, @"songs");
            BOOL more = YES;
            NSString  *str =EncodeStringFromDic(dict,@"more") ;
            if([str isEqualToString:@"0"])
            {
                more  = NO;
            }
            if(array)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                if([self.delegate respondsToSelector:@selector(getMusicSerchResult:ismore:)])
                {
                    
                    [self.delegate getMusicSerchResult:array ismore:(BOOL)more];
                     }
                    
                });
            }
        }
        
        if([method isEqualToString:@"song.detail"])
        {
            NSDictionary *dict = EncodeDicFromDic(jsondict, @"data");
            Musicdetail *musicDto = [Musicdetail parser:dict];
            dispatch_async(dispatch_get_main_queue(), ^{
                if([self.delegate respondsToSelector:@selector(getMusicDto:)])
                {
                    
                    [self.delegate getMusicDto:musicDto];
                }
                
            });

        }

    });
    
}

-(void)getlogo:(NSString *)logo size:(int)size URLType:(NSString *)type
{
    dispatch_async(dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, DISPATCH_QUEUE_CONCURRENT), ^{
        NSString *string = [XiamiRequest transferImageURL:logo toImageSize:size];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            if([self.delegate respondsToSelector:@selector(getURLConvert:URLType:)])
            {
                
                [self.delegate getURLConvert:string URLType:type];
            }
            
        });
    });

}

@end
