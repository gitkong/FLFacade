//
//  AppDelegate.m
//  Demo
//
//  Created by 孔凡列 on 2017/7/13.
//  Copyright © 2017年 gitKong. All rights reserved.
//

#import "AppDelegate.h"
#import "FLPresentStackController.h"
#import "PresentViewController.h"
#import "PushViewController.h"
#import "EmbedViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] init];
    UITabBarController *tabVc = [[UITabBarController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[PushViewController alloc] init]];
    nav.tabBarItem.title = @"Push";
    FLPresentStackController *presentStackVc = [[FLPresentStackController alloc] initWithRootViewController:[[PresentViewController alloc] init]];
    presentStackVc.tabBarItem.title = @"Present";
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:[[EmbedViewController alloc] init]];
    nav1.tabBarItem.title = @"Embed";
    [tabVc setViewControllers:@[nav, presentStackVc, nav1] animated:YES];
    self.window.rootViewController = tabVc;
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
