//
//  AppDelegate.m
//  sxbapp
//
//  Created by 蔡留洋 on 2017/6/1.
//  Copyright © 2017年 蔡留洋. All rights reserved.
//

#import "AppDelegate.h"
#import "React/RCTRootView.h"
#import "React/RCTBundleURLProvider.h"
#import "BasicTabBarController.h"
#import "LogInViewController.h"
#import "IQKeyboardManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UserInfo *user = [[UserManager sharedUserManager] user];
    if (user.loginName) {
        self.window.rootViewController = [[BasicTabBarController alloc] init];
    } else {
        self.window.rootViewController = [[LogInViewController alloc] init];
    }
    [self.window makeKeyAndVisible];
    
    
    //键盘弹出
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    //enable控制整个功能是否启用
    keyboardManager.enable = YES;
    //shouldResignOnTouchOutside控制点击背景是否收起键盘。
    keyboardManager.shouldResignOnTouchOutside = YES;
    //shouldToolbarUsesTextFieldTintColor
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES;
    //enableAutoToolbar控制是否显示键盘上的工具条。
    keyboardManager.enableAutoToolbar = YES;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
