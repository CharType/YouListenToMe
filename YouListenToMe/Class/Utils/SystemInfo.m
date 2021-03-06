//
//  SNSystemInfo.m
//  SNFoundation
//
//  Created by liukun on 14-3-3.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import "SystemInfo.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <sys/sockio.h>
#include <net/if.h>
#include <errno.h>
#include <net/if_dl.h>
//#import "IPAddress.h"

@implementation SystemInfo

+ (NSString *)osVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)platform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

+ (NSString *)platformString
{
    NSString *platform = [self platform];
    
    if ([platform isEqualToString:@"iPhone1,1"])   return @"iPhone1G GSM";
    if ([platform isEqualToString:@"iPhone1,2"])   return @"iPhone3G GSM";
    if ([platform isEqualToString:@"iPhone2,1"])   return @"iPhone3GS GSM";
    if ([platform isEqualToString:@"iPhone3,1"])   return @"iPhone4 GSM";
    if ([platform isEqualToString:@"iPhone3,3"])   return @"iPhone4 CDMA";
    if ([platform isEqualToString:@"iPhone4,1"])   return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"])   return @"iPhone5 GSM";
    if ([platform isEqualToString:@"iPhone5,2"])   return @"iPhone5 CDMA";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c CDMA";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c GSM";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5S CDMA";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5S GSM";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6Plus ";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad1 WiFi";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2 WiFi";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2 GSM";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2 CDMAV";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2 CDMAS";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad mini WiFi";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3 WiFi";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3 GSM";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3 CDMA";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad4 Wifi";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad4 4G";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad4 CDMA";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air WiFi";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air GSM";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air CDMA";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini WiFi";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini GSM";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini CDMA";
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"])
        return @"iPhone Simulator";
    
    return platform;
}

//获取系统当前时间
+ (NSString *)systemTimeInfo
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateString = [dateFormatter stringFromDate:[NSDate date]];
    return currentDateString;
}

+ (NSString *)appVersion
{
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return [NSString stringWithFormat:@"%@", version];
}

+ (BOOL)is_iPhone_5
{
    if ([UIScreen mainScreen].bounds.size.height == 568.0f) {
        return YES;
    }else{
        return NO;
    }
}


+ (BOOL)is_iPhone_4s
{
    if ([UIScreen mainScreen].bounds.size.height == 480.0f) {
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)is_iPhone_6
{
    if ([UIScreen mainScreen].bounds.size.height == 667.0f) {
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)is_iPhone_6P
{
    if ([UIScreen mainScreen].bounds.size.height == 736.0f) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark -
#pragma mark jailbreaker

static const char * __jb_app = NULL;

+ (BOOL)isJailBroken
{
	static const char * __jb_apps[] =
	{
		"/Application/Cydia.app",
		"/Application/limera1n.app",
		"/Application/greenpois0n.app",
		"/Application/blackra1n.app",
		"/Application/blacksn0w.app",
		"/Application/redsn0w.app",
		NULL
	};
    
	__jb_app = NULL;
    
	// method 1
    for ( int i = 0; __jb_apps[i]; ++i )
    {
        if ( [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:__jb_apps[i]]] )
        {
			__jb_app = __jb_apps[i];
			return YES;
        }
    }
	
    // method 2
	if ( [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/apt/"] )
	{
		return YES;
	}
	

	// method 3
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        return YES;
    }
    //system("ls")模拟器可能崩溃，替换成上面的方法，modify by 邢宪平
//	if ( 0 == system("ls") )
//	{
//		return YES;
//	}
	
    return NO;
}

+ (NSString *)jailBreaker
{
	if ( __jb_app )
	{
		return [NSString stringWithUTF8String:__jb_app];
	}
	else
	{
		return @"";
	}
}



+(BOOL)isAllowedNotification {
    if (IOS8_OR_LATER) {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }
    } else {//iOS7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone != type)
            return YES;
        }
    return NO;
}

@end
