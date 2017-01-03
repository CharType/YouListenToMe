//
//  AppDelegate.m
//  YouListenToMe
//
//  Created by 程倩 on 15/11/17.
//  Copyright (c) 2015年 CQ. All rights reserved.
//

/**
 *  虾米音乐  Appkey
 *
 *  @param BOOL <#BOOL description#>
 *
 *  @return <#return value description#>
 */
#define Appkey @"b77c731c3c9d8176a4fd08d6cda97eff"
#define Secret @"8041b220ea04f2931c9aff752f1ddb6a"


#import "AppDelegate.h"
#import "XiamiRequest.h"
#import "UIWindow+Extension.h"

@interface AppDelegate ()
{

}
//@property(nonatomic,strong) CQMainTabBarController *tabBarVc;
@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BOOL isok =  [XiamiRequest registerAppKey:Appkey appSecret:Secret];
    if(isok)
    {
        NSString *versionss =  [XiamiRequest version];
//        NSLog(@"初始化虾米音乐SDK成功 SDK版本号为： %@",versionss);
    }
    
////    // 1.创建window
//   
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
////    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    self.window.backgroundColor = [UIColor blackColor];
//
//    self.tabBarVc = [[CQMainTabBarController alloc] init];
//    self.window.rootViewController = self.tabBarVc;
//    
////    [self.window chooseRootViewController];
////
////    // 3.显示window
//    [self.window makeKeyAndVisible];
//
    UIApplication *app = [UIApplication sharedApplication];
    app.statusBarStyle = UIStatusBarStyleLightContent;
    

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
   
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
     [application beginBackgroundTaskWithExpirationHandler:nil];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
