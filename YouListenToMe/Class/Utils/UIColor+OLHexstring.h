//
//  UIColor+OLHexstring.h
//  onlineService
//
//  Created by pro on 15/9/11.
//  Copyright (c) 2015年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DaoDaoStatusBarHeight  ((IOS7_OR_LATER) ? 20 : 0)

#define CQBackGroundColor [UIColor colorWithHexString:@"#f2f2f2"]

//16进制色值参数转换
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 *  字体
 *
 *  @param OLHexstring <#OLHexstring description#>
 *
 *  @return <#return value description#>
 */
#define CQ_COMMON_FONT_48PX [UIFont systemFontOfSize:24]

#define CQ_COMMON_FONT_38PX [UIFont systemFontOfSize:19]

#define CQ_COMMON_FONT_34PX [UIFont systemFontOfSize:17]

#define CQ_COMMON_FONT_30PX [UIFont systemFontOfSize:15]

#define CQ_COMMON_FONT_28PX [UIFont systemFontOfSize:14]

#define CQ_COMMON_FONT_26PX [UIFont systemFontOfSize:13]

#define CQ_COMMON_FONT_24PX [UIFont systemFontOfSize:12]

#define CQ_COMMON_FONT_22PX [UIFont systemFontOfSize:11]

#define CQ_COMMON_FONT_20PX [UIFont systemFontOfSize:10]

#define CQ_COMMON_FONT_18PX [UIFont systemFontOfSize:9]

/**粗体**/
#define CQ_COMMON_FONT_BOLD_48PX [UIFont boldSystemFontOfSize:24]

#define CQ_COMMON_FONT_BOLD_38PX [UIFont boldSystemFontOfSize:19]

#define CQ_COMMON_FONT_BOLD_34PX [UIFont boldSystemFontOfSize:17]

#define CQ_COMMON_FONT_BOLD_30PX [UIFont boldSystemFontOfSize:15]

#define CQ_COMMON_FONT_BOLD_28PX [UIFont boldSystemFontOfSize:14]

#define CQ_COMMON_FONT_BOLD_26PX [UIFont boldSystemFontOfSize:13]

#define CQ_COMMON_FONT_BOLD_24PX [UIFont boldSystemFontOfSize:12]

#define CQ_COMMON_FONT_BOLD_22PX [UIFont boldSystemFontOfSize:11]

#define CQ_COMMON_FONT_BOLD_20PX [UIFont boldSystemFontOfSize:10]

#define CQ_COMMON_FONT_BOLD_18PX [UIFont boldSystemFontOfSize:9]

@interface UIColor (OLHexstring)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithRGBHex:(UInt32)hex;

@end
