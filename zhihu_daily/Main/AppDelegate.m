//
//  AppDelegate.m
//  zhihu_daily
//
//  Created by 朱凌霄 on 2019/3/5.
//  Copyright © 2019年 朱凌霄. All rights reserved.
//

#import <MMDrawerController/MMDrawerController.h>
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "LeftMenuViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //1.创建左侧边栏
    LeftMenuViewController *leftMenu = [[LeftMenuViewController alloc] init];
    
    //2.创建center
    HomeViewController *home = [[HomeViewController alloc] init];
    UINavigationController *homeInNav = [[UINavigationController alloc] initWithRootViewController:home];
    
    //第一行的代码会使右滑失效，第二行添加此行恢复。
    [homeInNav setNavigationBarHidden:YES];
    homeInNav.interactivePopGestureRecognizer.delegate=(id)self;
    
    MMDrawerController * root = [[MMDrawerController alloc] initWithCenterViewController:homeInNav leftDrawerViewController:leftMenu];
    
    //设置打开/关闭抽屉的手势
    root.openDrawerGestureModeMask  = MMOpenDrawerGestureModeAll;
    root.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
    //设置侧边栏宽度
    [root setMaximumLeftDrawerWidth:200.f];
    
    self.window.rootViewController = root;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
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
